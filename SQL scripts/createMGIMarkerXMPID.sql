USE DissertationDB

/*
Create MGIMarkerXMammalianPheontype link table
CREATE TABLE tblMGIMarkerIDXMammalianPhenotypeID
cursor to grab MGIMarkerAccessionID
Use cursor to grab MammalianPhenotypeIDs into variable @line
Use patindex to grab individual MPIDs into variable @split

*/

DECLARE @MGIMarkerID NVARCHAR(50)
DECLARE @Line NVARCHAR(MAX)
DECLARE @Split NVARCHAR(255)
DECLARE @MPID NVARCHAR(50)

DECLARE myCursor CURSOR FOR ( SELECT MGIMarkerAccessionID FROM MRK_HumanMousePhenotype )

-- drop table
IF EXISTS ( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tblMGIMarkerIDXMammalianPhenotypeID' )
DROP TABLE tblMGIMarkerIDXMammalianPhenotypeID

-- create table
CREATE TABLE tblMGIMarkerIDXMammalianPhenotypeID (
MGIMarkerID nvarchar(255) NOT NULL,
MPID nvarchar(255) NOT NULL)

OPEN myCursor;

FETCH NEXT FROM myCursor INTO @MGIMarkerID;

WHILE @@FETCH_STATUS=0 BEGIN

	SET @Line = ( 
	SELECT MammalianPhenotypeID 
	FROM MRK_HumanMousePhenotype 
	WHERE MGIMarkerAccessionID = @MGIMarkerID
	)
	
	-- MP:0005391 MP:0010771 becomes MP:0005391MP:0010771
	SET @Line = REPLACE(@Line, ' ', '')
	
	WHILE @Line != '' BEGIN
		
		--PRINT 'Line: ' + @Line
		SET @Split = LTRIM(RTRIM(SUBSTRING(@Line, 1, 10)))
		--PRINT 'MPID: ' + @Split
		IF NOT EXISTS ( SELECT MGIMarkerID, MPID FROM tblMGIMarkerIDXMammalianPhenotypeID 
						WHERE MGIMarkerID = @MGIMarkerID AND MPID = @Split ) BEGIN
			INSERT INTO tblMGIMarkerIDXMammalianPhenotypeID VALUES (@MGIMarkerID, @Split)
			END;
			
			SET @line = REPLACE(@line, @split, '')
		END;
	
	FETCH NEXT FROM myCursor INTO @MGIMarkerID
	
	END;
	
CLOSE myCursor;
DEALLOCATE myCursor;