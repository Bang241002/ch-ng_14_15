--chướng 14
--vidu1
USE AdventureWorks2019;
GO
DECLARE @TranName VARCHAR(30);
SELECT GTranName = 'FirstTransaction';
BEGIN TRANSACTION @TranName;
DELETE FROM HumanResources.JobCandidate WHERE JobCandidateID = 13;
GO

--vidu2
BEGIN TRANSACTION;
GO
DELETE FROM HumanResources.JobCandidate WHERE JobCandidateID = 11;
GO
COMMIT TRANSACTION;
GO

--vidu3
BEGIN TRANSACTION DeleteCandidate
with mark N'Deleting a job Candidate';
GO
DELETE FROM HumanResources.JobCandidate where JobCandidateID = 11;
GO
COMMIT TRANSACTION DeleteCandidate;
GO

--vidu4
USE Sterling;
GO
CREATE TABLE valueTable ([value] char)
GO

--vidu5
BEGIN TRANSACTION 
INSERT INTO valueTable VALUES ('A'); INSERT INTO valueTable VALUES ('B');
GO
ROLLBACK TRANSACTION 
INSERT INTO valueTable VALUES('C');
SELECT [values] FROM valueTable;
GO

--vidu6



--vidu7 
PRINT @@TRANSOUNT BEGIN TRAN
PRINT @@TRANSOUNT BEGIN TRAN
PRINT @@TRANSOUNT COMMIT
PRINT @@TRANSOUNT COMMIT
PRINT @@TRANSOUNT 
Go

--vidu8
PRINT @@TRANSOUNT BEGIN TRAN
PRINT @@TRANSOUNT BEGIN TRAN
PRINT @@TRANSOUNT 
ROLLBACK
PRINT @@TRANSOUNT 
GO

--vidu9
USE AdventureWorks2019;
Go
BEGIN TRANSACTION ListPriceUpdate
with mark 'Update Product list Prices';
Go
UPDATE Production.Product
SET ListPrice = ListPrice *1.20 where ProductNumber LIKE 'Bk-%';
Go
COMMIT TREANSACTION ListPriceUpdate;
Go

--chương 15
-- vidu1
Begin Try 
Declare @num int ;
Select @num = 217/0;
END Try 
Begin CATCH
Print 'Error occurred, unable to divide by 0'
END CATCH;
GO

-- vidu2
Begin Try 
Select 217/0;
END Try 
Begin CATCH
Select 
ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity, ERROR_LINE()
AS ErrorLine , ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- vidu3
IF OBJECT_ID ( 'sp_ErrorInfo', 'P' ) IS NOT NULL
DROP PROCEDURE sp_ErrorInfo;
GO
CREATE PROCEDURE sp_ErrorInfo
AS
SELECT
ERROR_NUMBER () AS ErrorNumber,
ERROR_SEVERITY () AS ErrorSeverity,
ERROR_STATE () AS ErrorState,
ERROR_PROCEDURE () AS ErrorProcedure,
ERROR_LINE () AS ErrorLine,
ERROR_MESSAGE () AS ErrorMessage;
GO
BEGIN TRY SELECT 217/0;
END TRY
BEGIN CATCH
EXECUTE sp_ErrorInfo;
END CATCH 
GO

-- vidu4
BEGIN TRANSACTION;
BEGIN TRY
DELETE FROM Production.Product WHERE ProductID = 980;
END TRY
BEGIN CATCH
SELECT
 ERROR_SEVERITY () AS ErrorSeverity
,ERROR_NUMBER () AS ErrorNumber
,ERROR_PROCEDURE () AS ErrorProcedure
,ERROR_STATE () AS ErrorState
,ERROR_MESSAGE () AS ErrorMessage
,ERROR_LINE () AS ErrorLine; IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;
END CATCH;
IF @@TRANCOUNT > 0 COMMIT TRANSACTION;
GO

-- vidu5
BEGIN TRY
UPDATE HumanResources.EmployeePayHistory SET PayFrequency = 4
WHERE BusinessEntityID = 1;
END TRY
BEGIN CATCH
IF @@ERROR = 547
PRINT N'Check constraint violation has occurred. ';
END CATCH
GO

-- vidu6
RAISERROR (N'This is an error message $s d.', 10, 1, N'serial number', 23);
GO 

-- vidu7
RAISERROR (N'S*. *s', 10, 1, 7, 3, N'Hello world');
GO
RAISERROR (N'87.3s', 10, 1, N'Helloworld');
GO

-- vidu8
BEGIN TRY
RAISERROR ('Raises Error in the TRY block.', 16, 1);
END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR (4000); DECLARE @ErrorSeverity INT;
DECLARE @ErrorState INT; SELECT
@ErrorMessage = ERROR_MESSAGE (), @ErrorSeverity = ERROR_SEVERITY(),
@ErrorState = ERROR_STATE();
RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
                 
GO

-- vidu9
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_STATE() AS ErrorState;
END CATCH;
GO

-- vidu10
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_SEVERITY() AS ErrorSeverity;
END CATCH;
GO

-- vidu11
IF OBJECT_ID ( 'usp_Example', 'P') IS NOT NULL
DROP PROCEDURE usp_Example;
GO
CREATE PROCEDURE usp_Example AS
SELECT 217/0;
GO
BEGIN TRY
EXECUTE usp_Example;
END TRY
BEGIN CATCH
SELECT ERROR_PROCEDURE () AS ErrorProcedure;
END CATCH;
GO

-- vidu12
IF OBJECT_ID ('usp Example', 'P') IS NOT NULL
DROP PROCEDURE usp_Example;
GO
CREATE PROCEDURE usp_Example AS
SELECT 217/0;
GO
BEGIN TRY
EXECUTE usp_Example;
END TRY
BEGIN CATCH SELECT
ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS ErrorSeverity, ERROR_STATE()
AS ErrorState, ERROR_PROCEDURE() AS ErrorProcedure, ERROR_MESSAGE () AS
ErrorMessage, ERROR_LINE() AS ErrorLine;
END CATCH;
GO

-- vidu13
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() AS ErrorNumber;
END CATCH;
GO

-- vidu14
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE () AS ErrorMessage;
END CATCH;
GO

-- vidu15
BEGIN TRY
SELECT 217/0;
END TRY
BEGIN CATCH
SELECT ERROR_LINE () AS ErrorLine;
END CATCH;
GO

-- vidu16
BEGIN TRY
SELECT * FROM Nonexistent;
END TRY
BEGIN CATCH
SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO

-- vidu17
IF OBJECT_ID (N'sp Example', N'P') IS NOT NULL
DROP PROCEDURE sp_Example;
GO
CREATE PROCEDURE sp_Example AS
SELECT * FROM Nonexistent;
GO
BEGIN TRY
EXECUTE sp_Example;
END TRY
BEGIN CATCH SELECT
ERROR_NUMBER() AS ErrorNumber,
ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- vidu18
USE tempdb;
GO
CREATE TABLE dbo.TestRethrow
(ID INT PRIMARY KEY ) ;
BEGIN TRY
INSERT dbo.TestRethrow (ID) VALUES (1) ;
INSERT dbo.TestRethrow (ID) VALUES (1) ;
END TRY
BEGIN CATCH
PRINT 'In catch block.';
THROW;
END CATCH;
GO
