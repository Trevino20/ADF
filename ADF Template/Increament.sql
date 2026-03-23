/****** Object:  StoredProcedure [schema].[procedure_name] ******/

SET ANSI_NULLS ON

GO
 
SET QUOTED_IDENTIFIER ON

GO
 
CREATE PROCEDURE -- [schema].[procedure_name]

AS

BEGIN
-- Additional Part Start....
    DECLARE @CurrentYear INT = YEAR(GETDATE());
    DECLARE @CurrentMonth INT = MONTH(GETDATE());
    DECLARE @CurrentDay INT = DAY(GETDATE());
    DECLARE @MinDateMinusOneDay DATE;
-- Additional Part End.....
```

--------------------------------------------------

-- Start Transaction

--------------------------------------------------

BEGIN TRANSACTION;

BEGIN TRY
 
    --------------------------------------------------

    -- 1. DECLARE VARIABLES

    --------------------------------------------------

    DECLARE @CurrentYear INT;

    DECLARE @CurrentMonth INT;

    DECLARE @CurrentDay INT;
 
 
    --------------------------------------------------

    -- 2. DATA CLEANING / FORMAT FIX

    --------------------------------------------------

    -- Example:

    -- UPDATE table_name

    -- SET column = value
 
 
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

 