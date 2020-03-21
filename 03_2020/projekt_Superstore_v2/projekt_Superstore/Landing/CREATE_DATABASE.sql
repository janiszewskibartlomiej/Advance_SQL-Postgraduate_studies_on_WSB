USE master
GO
IF DB_ID (N'Superstore_ODS') IS NOT NULL
DROP DATABASE SuperstoreLanding;

CREATE DATABASE SuperstoreLanding
 CONTAINMENT = NONE
GO



