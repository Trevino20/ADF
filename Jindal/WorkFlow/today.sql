SELECT [Material Code], [Ratio M to TO]
FROM stg.MaterialMaster
WHERE [Material Code] = 'BKERW80HSS'


select Material_Code,Ratio_M_T
from stg.[W_Beam]
where Material_Code = 'BKERW80HSS'


select * from stg.W_Beam where Ratio_M_T is not null


SELECT 
    e.[Item Material ID],
    e.[AcceptQty],
    e.[UOM type],
    cm.ConvFactor,
    CASE 
        WHEN e.[UOM type] = 'Mtr.' THEN CAST(e.[AcceptQty] AS float) / NULLIF(cm.ConvFactor, 0)
        WHEN e.[UOM type] = 'Kg.' THEN CAST(e.[AcceptQty] AS float) / 1000
        WHEN e.[UOM type] = 'Ton' THEN CAST(e.[AcceptQty] AS float)
        ELSE CAST(e.[AcceptQty] AS float)
    END AS BaseConversion,
    w.[Ratio_M_T],
    CASE 
        WHEN w.[Material_Code] IS NOT NULL 
            THEN CAST(e.[AcceptQty] AS float) / NULLIF(w.[Ratio_M_T], 0)
        ELSE 
            CASE 
                WHEN e.[UOM type] = 'Mtr.' THEN CAST(e.[AcceptQty] AS float) / NULLIF(cm.ConvFactor, 0)
                WHEN e.[UOM type] = 'Kg.' THEN CAST(e.[AcceptQty] AS float) / 1000
                WHEN e.[UOM type] = 'Ton' THEN CAST(e.[AcceptQty] AS float)
                ELSE CAST(e.[AcceptQty] AS float)
            END
    END AS FinalConversionFactor

FROM dbo1.FactBidding e

LEFT JOIN dbo1.DimMaterial_OB m 
    ON m.[MaterialCode] = e.[Item Material ID]

LEFT JOIN stg.ConvMaster cm 
    ON e.[Size of GI & MS] = cm.[Size] 
    AND TRIM(e.[Thickness]) = TRIM(cm.[Class])

LEFT JOIN stg.[W_Beam] w 
    ON e.[Item Material ID] = w.[Material_Code]

WHERE ISNULL(m.[Product], '') != 'GI Beam' and w.Ratio_M_T is not null;


select [UOM type] from dbo1.FactBidding e
LEFT JOIN stg.[W_Beam] w 
    ON e.[Item Material ID] = w.[Material_Code]
    where w.Ratio_M_T is not null

select [UOM type] from dbo1.FactBidding e
LEFT JOIN stg.[MaterialMaster] w 
    ON e.[Item Material ID] = w.[Material Code]
    where w.[Ratio M to TO] is not null


select count(*) from dbo1.FactBidding