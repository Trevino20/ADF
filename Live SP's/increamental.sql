/****** Object:  StoredProcedure [schema].[procedure_name] ******/

SET ANSI_NULLS ON

GO
 
SET QUOTED_IDENTIFIER ON

GO
 
CREATE PROCEDURE [test].[test_update_stg_to_dbo_VIVO]

-- [schema].[procedure_name]

AS

BEGIN
 
 
--------------------------------------------------

-- Start Transaction

--------------------------------------------------

BEGIN TRANSACTION;

BEGIN TRY
 
    --------------------------------------------------

    -- 1. DECLARE VARIABLES

    --------------------------------------------------

    --DECLARE @CurrentYear INT;

    --DECLARE @CurrentMonth INT;

    --DECLARE @CurrentDay INT;
 
 
    --------------------------------------------------

    -- 2. DATA CLEANING / FORMAT FIX

    --------------------------------------------------

    -- Example:

    -- UPDATE table_name

    -- SET column = value
 
    -- select * from test.[stg2.vivo]
 
UPDATE test.[stg2.vivo]

SET [SAP Despatch Date]= CONVERT(nvarchar, CONVERT(date, [SAP Despatch Date], 103), 23)

WHERE TRY_CONVERT(date,[SAP Despatch Date],23) IS NULL
 
ALTER TABLE test.[stg2.vivo]

ALTER COLUMN [SAP Despatch Date] Date
 
 
 
UPDATE test.[stg2.vivo]

SET [Gate IN Date]= CONVERT(nvarchar, CONVERT(date, [Gate IN Date], 103), 23)

WHERE TRY_CONVERT(date,[Gate IN Date],23) IS NULL
 
ALTER TABLE test.[stg2.vivo]

ALTER COLUMN [Gate IN Date] Date
 
 
UPDATE test.[stg2.vivo]

SET [Gate Out Date]= CONVERT(nvarchar, CONVERT(date, [Gate Out Date], 103), 23)

WHERE TRY_CONVERT(date,[Gate Out Date],23) IS NULL
 
ALTER TABLE test.[stg2.vivo]

ALTER COLUMN [Gate Out Date] Date
 
 
    --------------------------------------------------

    -- 3. DELETE OLD / DUPLICATE DATA

    --------------------------------------------------

    -- Example:

    -- DELETE FROM table_name

    -- WHERE condition
 
 
    --------------------------------------------------

    -- 4. ALTER TABLE / ADD COLUMNS

    --------------------------------------------------

    -- Example:

    -- IF NOT EXISTS (

    --     SELECT 1

    --     FROM INFORMATION_SCHEMA.COLUMNS

    --     WHERE TABLE_NAME = 'table_name'

    --     AND COLUMN_NAME = 'column_name'

    -- )

    -- BEGIN

    --     ALTER TABLE table_name

    --     ADD column_name datatype;

    -- END
 
 
-- ************* Converted Gate IN to Tare WT *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted Gate IN to Tare WT'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted Gate IN to Tare WT] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted Gate IN to Tare WT] =

(

    CAST(LEFT([Gate IN to Tare Wt.], CHARINDEX(':', [Gate IN to Tare Wt.]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([Gate IN to Tare Wt.], CHARINDEX(':', [Gate IN to Tare Wt.]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([Gate IN to Tare Wt.], 2) AS FLOAT) / 3600

) / 24;
 
-- ************* Converted Tare Wt. to DO Release *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted Tare Wt. to DO Release'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted Tare Wt. to DO Release] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted Tare Wt. to DO Release] =

(

    CAST(LEFT([Tare Wt. to DO Release], CHARINDEX(':', [Tare Wt. to DO Release]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([Tare Wt. to DO Release], CHARINDEX(':', [Tare Wt. to DO Release]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([Tare Wt. to DO Release], 2) AS FLOAT) / 3600

) / 24;
 
-- ************* Converted DO to Loading *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted DO to Loading'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted DO to Loading] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted DO to Loading] =

(

    CAST(LEFT([DO to Loading], CHARINDEX(':', [DO to Loading]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([DO to Loading], CHARINDEX(':', [DO to Loading]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([DO to Loading], 2) AS FLOAT) / 3600

) / 24;
 
-- ************* Converted Loading to Gross Wt. *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted Loading to Gross Wt.'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted Loading to Gross Wt.] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted Loading to Gross Wt.] =

(

    CAST(LEFT([Loading to Gross Wt.], CHARINDEX(':', [Loading to Gross Wt.]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([Loading to Gross Wt.], CHARINDEX(':', [Loading to Gross Wt.]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([Loading to Gross Wt.], 2) AS FLOAT) / 3600

) / 24;
 
-- ************* Converted Gross Wt. to PGI *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted Gross Wt. to PGI'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted Gross Wt. to PGI] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted Gross Wt. to PGI] =

(

    CAST(LEFT([Gross Wt. to PGI], CHARINDEX(':', [Gross Wt. to PGI]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([Gross Wt. to PGI], CHARINDEX(':', [Gross Wt. to PGI]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([Gross Wt. to PGI], 2) AS FLOAT) / 3600

) / 24;
 
 
-- ************* Converted PGI to Way Bill *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted PGI to Way Bill'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted PGI to Way Bill] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted PGI to Way Bill] =

(

    CAST(LEFT([PGI to Way Bill], CHARINDEX(':', [PGI to Way Bill]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([PGI to Way Bill], CHARINDEX(':', [PGI to Way Bill]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([PGI to Way Bill], 2) AS FLOAT) / 3600

) / 24;
 
-- ************* Converted Waybill to Gateout *****************

-- Step 1: Check if column exists

IF NOT EXISTS (

    SELECT 1

    FROM INFORMATION_SCHEMA.COLUMNS

    WHERE TABLE_SCHEMA = 'test'

    AND TABLE_NAME = 'stg2.vivo'

    AND COLUMN_NAME = 'Converted Waybill to Gateout'

)
 
BEGIN

    -- Step 2: Add new column

    ALTER TABLE test.[stg2.vivo]

    ADD [Converted Waybill to Gateout] FLOAT;

END
 
-- Step 3: Update column with converted value

UPDATE test.[stg2.vivo]

SET [Converted Waybill to Gateout] =

(

    CAST(LEFT([Waybill to Gateout], CHARINDEX(':', [Waybill to Gateout]) - 1) AS FLOAT) 

    + CAST(SUBSTRING([Waybill to Gateout], CHARINDEX(':', [Waybill to Gateout]) + 1, 2) AS FLOAT) / 60

    + CAST(RIGHT([Waybill to Gateout], 2) AS FLOAT) / 3600

) / 24;
 
 
    --------------------------------------------------

    -- 5. DATA TRANSFORMATION

    --------------------------------------------------

    -- Example:

    -- UPDATE table_name

    -- SET column = CASE

    --                  WHEN condition THEN value

    --                  ELSE value

    --              END
 
 
    --------------------------------------------------

    -- 6. LOOKUP / JOIN UPDATE

    --------------------------------------------------

    -- Example:

    -- UPDATE t

    -- SET t.column = d.value

    -- FROM table1 t

    -- LEFT JOIN table2 d

    -- ON t.id = d.id
 
 
    --------------------------------------------------

    -- 7. CALCULATIONS

    --------------------------------------------------

    -- Example:

    -- UPDATE table_name

    -- SET column = column1 - column2
 
 
    --------------------------------------------------

    -- 8. HIGH WATERMARK UPDATE

    --------------------------------------------------

    -- Example:

    -- UPDATE watermark_table

    -- SET LastModifiedDate = GETDATE()

    -- WHERE TableName = 'table_name'
 
    DECLARE @CurrentYear INT = YEAR(GETDATE());

    DECLARE @CurrentMonth INT = MONTH(GETDATE());

    DECLARE @CurrentDay INT = DAY(GETDATE());
 
    DECLARE @MinDateMinusOneDay DATE;
 
-- Set the @MinDateMinusOneDay variable

    SELECT @MinDateMinusOneDay = DATEADD(DAY, -1, MIN([SAP Despatch Date]))

    FROM test.[stg2.vivo]

    WHERE YEAR([SAP Despatch Date] ) = @CurrentYear

    AND MONTH([SAP Despatch Date]) = @CurrentMonth;
 
    PRINT 'The value of @MinDateMinusOneDay is: ' + ISNULL(CONVERT(VARCHAR, @MinDateMinusOneDay), 'NULL');
 
-- Update the high_watermark table with the calculated date only if @MinDateMinusOneDay is not null

    IF @MinDateMinusOneDay IS NOT NULL

    BEGIN

    UPDATE dbo2.high_water_mark

    SET [Last_Modified_Date] = @MinDateMinusOneDay

    WHERE Table_name = 'dbo2.Vivo';

    END
 
    --------------------------------------------------

    -- Commit Transaction

    --------------------------------------------------

    COMMIT TRANSACTION;
 
END TRY
 
BEGIN CATCH
 
    --------------------------------------------------

    -- Error Handling

    --------------------------------------------------

    PRINT 'Error occurred: ' + ERROR_MESSAGE();
 
    ROLLBACK TRANSACTION;
 
END CATCH

```
 
END

GO

 