-- Check to see if the SP exists.
IF EXISTS (SELECT name FROM dbo.sysobjects WHERE name = 'spInsertPaymentScheduleDetails')
	DROP PROCEDURE spInsertPaymentScheduleDetails
GO 

CREATE PROCEDURE [dbo].[spInsertPaymentScheduleDetails]
(
	@ID				    BIGINT OUTPUT,
	@DateInserted       DATETIME OUTPUT,
	@PaymentNo          INT,
	@ParentID           BIGINT,
    @PaymentAmount      MONEY, 
    @PmtScheduleDate    DATETIME, 
    @IsDeleted          DATETIME,
	@RowsAffected       INT = 0 OUTPUT,
	@ErrMessage         NVARCHAR(255) = '' OUTPUT
)
AS
BEGIN

	/*
	When SET NOCOUNT is ON, the count is not returned. When SET NOCOUNT is OFF, the count is returned.
	The @@ROWCOUNT function is updated even when SET NOCOUNT is ON.
	SET NOCOUNT ON prevents the sending of DONE_IN_PROC messages to the client for each statement 
	in a stored procedure. For stored procedures that contain several statements that do not return much 
	actual data, setting SET NOCOUNT to ON can provide a significant performance boost, because 
	network traffic is greatly reduced.
	The setting specified by SET NOCOUNT is in effect at execute or run time and not at parse time.
	*/
	SET NOCOUNT ON

	DECLARE @ErrNum	INT
	DECLARE @NumRows BIGINT
	DECLARE @throwMsg varchar(2048)
	SET @ErrNum = 0
	SET @ErrMessage = ''


	BEGIN TRY	

		SET @DateInserted = GETDATE();

		INSERT INTO [dbo].[tblPaymentScheduleDetails]
			([PaymentNo], 
			[DateInserted], 
			[ParentID], 
			[PaymentAmount], 
			[PmtScheduleDate], 
			[IsDeleted],
			[WhenUpdated])
		VALUES
			(@PaymentNo,
			@DateInserted,
			@ParentID,
			@PaymentAmount, 
			@PmtScheduleDate, 
			@IsDeleted, 
			NULL);
		
		SET @ID = SCOPE_IDENTITY();

		SET @NumRows = @@ROWCOUNT;

		SET @RowsAffected = @NumRows;

		IF @NumRows = 0 
			BEGIN;
				SET @ErrNum = 50004;
				SET @throwMsg = FORMATMESSAGE('The attempt to insert the detail record (PaymentNo=%i) failed. Either the record does not exist or you do not have access to that record.', @PaymentNo);
				THROW @ErrNum, @throwMsg, 1;
			END;

	END TRY
	BEGIN CATCH
		BEGIN
			-- Capture the error number.
			SET @ErrNum = @@ERROR;
			SET @ErrMessage = 'Error#=[' + CONVERT(nvarchar(255), @ErrNum) + ']::Line=[' + CONVERT(nvarchar(255), ERROR_LINE()) + ']::Message=[' + COALESCE(ERROR_MESSAGE(), 'N/A') + ']::=Procedure=[' + COALESCE(ERROR_PROCEDURE(), 'N/A') + ']::Severity=[' + CONVERT(nvarchar(255), ERROR_SEVERITY()) + ']::Application=[' + APP_NAME() + ']';
		END
	END CATCH

	RETURN @ErrNum

END

GO

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'1.0.0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spInsertPaymentScheduleDetails'
GO


