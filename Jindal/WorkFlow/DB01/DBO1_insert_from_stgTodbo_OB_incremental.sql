/****** Object:  StoredProcedure [dbo1].[insert_from_stgTodbo_OB_incremental]    Script Date: 3/27/2026 9:31:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE    PROCEDURE [dbo1].[insert_from_stgTodbo_OB_incremental] AS
begin

begin transaction;

begin try


-- extra
	DECLARE @CurrentYear INT = YEAR(GETDATE());
    DECLARE @CurrentMonth INT = MONTH(GETDATE());
    DECLARE @CurrentDay INT = DAY(GETDATE());
    DECLARE @MinDateMinusOneDay DATE;
-- Extra

INSERT INTO dbo1.FactBidding
SELECT c.DateKey
		,e.EventKey
		,cs.CustomerKey
		,m.MaterialKey
		,g.GeoKey
		
		,ed.[Event ID]
		,ed.[Event Title]
		,ed.[Event Date] 
		,ed.[Company Name] 
		,ed.[Customer Name] 		
		,ed.[Sold To Party] 
		,ed.[Ship To Party] 
		,ed.[Item Name] 
		,ed.[MG-1] 
		,ed.[MG-2] 
		,ed.[MG-3] 
		,ed.[MG-4] 
		,ed.[MG-5] 
		,ed.[ItemPlant]      
		,ed.[Item Shipping Point]      
		,ed.[ItemRank]      
		,ed.[Region Name]      
		,ed.[UOM type]      
		,ed.[ItemFOB]      
		,ed.[ItemRegion]      
		,ed.[ItemWidth]      
		,ed.[TC GF Column Name 1]      
		,ed.[TC GF Column Name 2]      
		,ed.[BidderQty]      
		,ed.[BidderQty 1]      
		,ed.[BidderQty 2]      
		,ed.[BidderAmt]     
		,ed.[FreightValue]      
		,ed.[AcceptQty]     
		,ed.[TonValue]      
		,ed.[Mtr Value]      
		,ed.[AcceptAmt]      
		,ed.[Action]      
		,ed.[CustomerRemarks]      
		,ed.[CanceledQty]      
		,ed.[AdminRemarks]      
		,ed.[HeaderNote]      
		,ed.[OrderStatus]      
		,ed.[Post Length H-Name]      
		,ed.[Post Length Value]      
		,ed.[Destination Port]      
		,ed.[Destination Port Freight Value]      
		,ed.[IP Address]      
		,ed.[Sales Person]      
		,ed.[Extra Discount Price]      
		,ed.[Item Material ID]      
		,ed.[Clean Event Title]      
		,ed.[Product]      
		,ed.[SubProduct]      
		,ed.[Category]      
		,ed.[Material Group]      
		,ed.[Category-2]      
		,ed.[Material Width For Production]      
		,ed.[Width]  
		,ed.[Alu Zinc Coating]      
		,ed.[Event Type]      
		,ed.[Indicative Price]      
		,ed.[PriceGap]     
		,ed.[Zone]      
		,ed.[InvoicePrice]     
		,ed.[SAP PO NUMBER]      
		,ed.[SAP Sales Order NUMBER]      
		,ed.[SAP Base Quantity]     
		,ed.[Pipe]      
		,ed.[Descriptn]      
		,ed.[Descriptn1]      
		,ed.[Descriptn2]      
		,ed.[Thickness]      
		,ed.[End]      
		,ed.[Size of Section]    
		,ed.[Pipe Category 1]      
		,ed.[Size of GI & MS]     
		,ed.[Pipe Category 2]      
		,ed.[Pending Qty]     
		,ed.[Pending/Non-Pending]      
		,ed.[ConversionFactor]     
		,ed.[Quantity In Ton]
		,ed.[Category_1]
		,ed.[Decision_Taken_Date]
FROM stg.EventsData ed
LEFT JOIN dbo1.DimCalendar c
ON c.[Date]=ed.[Decision_Taken_Date]
LEFT JOIN dbo1.DimEvent e
ON upper(trim(replace(e.[Name],char(160),' ')))=upper(trim(replace(ed.[Clean event Title],char(160),' ')))--replaces any non-breaking spaces (ASCII 160) with regular spaces.
--ON upper(trim(e.[Name]))=upper(trim(ed.[Clean event Title]))
LEFT JOIN dbo1.DimCustomer_OB cs
ON cs.[Customer Code]=ed.[Sold to party]
LEFT JOIN dbo1.DimMaterial_OB m
ON m.[MaterialCode]=ed.[Item Material ID]
LEFT JOIN dbo1.DimGeo g
ON lower(trim(g.[State]))=lower(trim(ed.[ItemRegion]))
WHERE 
[Decision_Taken_Date]>(SELECT LastModifiedDate
						FROM dbo1.high_watermark
						WHERE TableName='dbo1.FactBidding'
						)
AND 
ed.[Action]='Accepted' AND ed.[Event Type] IS NOT NULL AND ed.[Item Material ID] IS NOT NULL AND ed.PRODUCT IS NOT NULL




------------------------------------------------------------------------------------------------------------------------------------------------



--UPDATE dbo1.high_watermark
--SET LastModifiedDate=(SELECT MAX([Event Date])
--						FROM dbo1.FactBidding
--						)

--WHERE TableName='dbo1.FactBidding'

---- Declare variables for the current year and month
--DECLARE @CurrentYear INT = YEAR(GETDATE());
--DECLARE @CurrentMonth INT = MONTH(GETDATE());

---- Declare a variable to hold the minimum date minus one day
--DECLARE @MinDateMinusOneDay DATE;

---- Set the @MinDateMinusOneDay variable
--SELECT @MinDateMinusOneDay = DATEADD(DAY, -1, MIN([Event Date]))
--FROM stg.EventsData
--WHERE YEAR([Event Date] ) = @CurrentYear
--  AND MONTH([Event Date]) = @CurrentMonth;

--PRINT 'The value of @MinDateMinusOneDay is: ' + ISNULL(CONVERT(VARCHAR, @MinDateMinusOneDay), 'NULL');

---- Update the high_watermark table with the calculated date only if @MinDateMinusOneDay is not null
--IF @MinDateMinusOneDay IS NOT NULL
--BEGIN
--    UPDATE dbo1.high_watermark
--    SET LastModifiedDate = @MinDateMinusOneDay
--    WHERE TableName = 'dbo1.FactBidding';
--END





--------------------------------------------------------------------------------------------------------------------------------------------------

--UPDATE dbo1.FactBidding
--SET [ConversionFactor]=


--       CASE 
--           WHEN [UOM type] = 'Mtr.' THEN (cast([AcceptQty] as float)/cm.ConvFactor)
--           WHEN [UOM type] = 'Kg.'  THEN (cast([AcceptQty] as float)/100)
--		   WHEN [UOM type] = 'Ton'  THEN (cast([AcceptQty] as float))
--		Else [AcceptQty]
--       END
--FROM dbo1.FactBidding e
--LEFT JOIN stg.ConvMaster cm ON e.[Size of GI & MS]  = cm.[Size] 
--                             AND trim(e.[Thickness])  = trim(cm.[Class]) 


UPDATE dbo1.FactBidding
SET [ConversionFactor] =
    CASE 
        WHEN [UOM type] = 'Mtr.' THEN (CAST([AcceptQty] AS float) / cm.ConvFactor)
        WHEN [UOM type] = 'Kg.' THEN (CAST([AcceptQty] AS float) / 1000)
        WHEN [UOM type] = 'Ton' THEN (CAST([AcceptQty] AS float))
        ELSE CAST([AcceptQty] AS float)
    END
FROM dbo1.FactBidding e
LEFT JOIN dbo1.DimMaterial_OB m ON m.[MaterialCode] = e.[Item Material ID]
LEFT JOIN stg.ConvMaster cm ON e.[Size of GI & MS] = cm.[Size] 
                            AND TRIM(e.[Thickness]) = TRIM(cm.[Class])
WHERE m.[Product] != 'GI Beam'

update dbo1.FactBidding
set [ConversionFactor] =e.[AcceptQty]/w.[Ratio_M_T]
from dbo1.FactBidding e
left join stg.[W_Beam] w on e.[Item Material ID]= w.[Material_Code]
where w.[Material_Code] is not null



ALTER TABLE stg.EventsData
ALTER COLUMN [Event Date] varchar(255)


ALTER TABLE stg.EventsData
ALTER COLUMN [BidderAmt] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [AcceptQty] varchar(255)


ALTER TABLE stg.EventsData
ALTER COLUMN [Width] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [PriceGap] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [InvoicePrice] nvarchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [SAP Base Quantity] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [Size of GI & MS] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [Pending Qty] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [ConversionFactor] varchar(255)

ALTER TABLE stg.EventsData
ALTER COLUMN [Quantity In Ton] varchar(255)


ALTER TABLE stg.EventsData
ALTER COLUMN [Decision_Taken_Date] varchar(100)




UPDATE stg.EventsData
SET [Decision_Taken_Date]= CONVERT(nvarchar, CONVERT(date,[Decision_Taken_Date], 103), 23)
WHERE TRY_CONVERT(date,[Decision_Taken_Date],23) IS NULL

--ALTER TABLE dbo1.FactBidding
--ALTER COLUMN [Decision_Taken_Date] date


--WITH CTE AS(
--SELECT *,ROW_NUMBER() OVER (PARTITION BY [Event Date],[Clean event Title], [Sold to party],[Item Material ID],[ItemRegion] 
--ORDER BY [Event Date],[Clean event Title], [Sold to party],[Item Material ID],[ItemRegion] )rn
--FROM dbo1.FactBidding
--)
--delete  FROM CTE
--WHERE rn>1


 COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- If any error occurs, print the error message and roll back the transaction
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
        RETURN;
    END CATCH;
END;

GO


