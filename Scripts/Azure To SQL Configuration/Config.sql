/*
===============================================================================
Configuration Steps:
===============================================================================
Script Purpose:
    This Script shows step by step process of how to make configuration using Azure SAS token and get permission for the bulk insert in bronze tier. 
    
===============================================================================
*/


--creating marster key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'My!Password123';
Go

-- Drop external data source with verified URL
IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'AzureStoragedw')
    DROP EXTERNAL DATA SOURCE AzureStoragedw;
GO


-- First drop existing credential if it exists
IF EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'AzureStorageCredentialdw')
    DROP DATABASE SCOPED CREDENTIAL AzureStorageCredentialdw;
GO

-- Create credential with proper SAS token
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredentialdw
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sv=2024-11-04&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-06-19T05:09:00Z&st=2025-06-17T21:09:00Z&spr=https&sig=5cw3Rgn%2BjzP%2FUXfW8Ii1uPx4xVk1RV9VF%2FqelkH5Ckg%3D';
GO


--Recreate external data source with verified URL
CREATE EXTERNAL DATA SOURCE AzureStoragedw
WITH (
    TYPE = BLOB_STORAGE,
    LOCATION = 'https://sqlwarehousestorage.blob.core.windows.net',  -- No trailing slash
    CREDENTIAL = AzureStorageCredentialdw
);
GO
