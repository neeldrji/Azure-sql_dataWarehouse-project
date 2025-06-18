
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Azure Blob storage (containers) -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Usage Example:
   EXEC bronze.Load_Bronze_tire;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.Load_Bronze_tire
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @StartTime DATETIME = GETDATE();
    DECLARE @EndTime DATETIME;
    DECLARE @RowCount INT = 0;
    DECLARE @Message NVARCHAR(500);
    
    BEGIN TRY
        PRINT '[' + CONVERT(VARCHAR(20), @StartTime, 120) + '] Starting data load from Azure blob...';
        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';

        -- CRM_CUST_INFO
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'crm/cust_info.csv'  
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'crm_cust_info - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;

        -- CRM_PRD_INFO
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'crm/prd_info.csv'  
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'crm_prd_info - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;

        -- CRM_SALES_DETAILS
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'crm/sales_details.csv'  
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'crm_sales_details - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;

        PRINT '------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------------------';

        -- ERP_LOC_A101
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'erp/LOC_A101.csv'  
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'erp_loc_a101 - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;

        -- ERP_CUST_AZ12
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'erp/CUST_AZ12.csv'
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'erp_cust_az12 - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;

        -- ERP_PX_CAT_G1V2
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'erp/PX_CAT_G1V2.csv'  
        WITH (
            DATA_SOURCE = 'AzureStoragedw',
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @RowCount = @@ROWCOUNT;
        SET @Message = 'erp_px_cat_g1v2 - ' + CAST(@RowCount AS VARCHAR) + ' rows loaded successfully.';
        PRINT @Message;
    
    END TRY
    BEGIN CATCH
        SET @EndTime = GETDATE();
        SET @Message = '[' + CONVERT(VARCHAR(20), @EndTime, 120) + '] ERROR: ' + 
                     ERROR_MESSAGE() + ' (Duration: ' + 
                     CONVERT(VARCHAR, DATEDIFF(SECOND, @StartTime, @EndTime)) + ' seconds)';
        PRINT @Message;
        RETURN 1;
    END CATCH
END;
GO

