CREATE PROCEDURE [dbo].[SP0]
AS
BEGIN
    -- SET NOCOUNT ON to stop the message indicating the number of rows affected.
    -- This is a good practice for performance and cleaner execution.
    SET NOCOUNT ON;

    DECLARE @newBatchId BIGINT;
    DECLARE @currentTime DATETIME;

    -- 1. Find the biggest BatchId from the CodeInc table and increase it by 1.
    --    Using ISNULL handles the case where the table is empty, starting with 1.
    
    SELECT @newBatchId = ISNULL(MAX(BatchId), 0) + 1
    FROM [dbo].[CodeInc];

    -- 2. Store the new BatchId in a variable (done above).

    -- 3. Store the current time in a variable.
    SET @currentTime = GETDATE();

    -- 4. Insert a new row with the new values.
    INSERT INTO [dbo].[CodeInc] (BatchId, DefectID, TimeStamp)
    VALUES (@newBatchId, 0, @currentTime);
END