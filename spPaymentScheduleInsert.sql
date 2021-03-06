-- Check to see if the SP exists.
IF EXISTS (SELECT name FROM dbo.sysobjects WHERE name = 'spPaymentScheduleInsert')
	DROP PROCEDURE spPaymentScheduleInsert
GO 


CREATE PROCEDURE [dbo].[spPaymentScheduleInsert]
(
	@ID				 BIGINT OUTPUT,
	@DateInserted    DATETIME OUTPUT,
	@LoanNo			 INT,
	@AccountNumber   NVARCHAR(20),
	@Address         NVARCHAR(50),
	@City            NVARCHAR(50),
	@Code            NVARCHAR(20),
	@CommMethodId    INT,
	@CompanyGuid     UNIQUEIDENTIFIER,
	@Email           NVARCHAR(30),
	@IsDeleted       DATETIME,
	@Name            NVARCHAR(20),
	@NumOfPmts       INT,
	@Phone           CHAR(10),
	@PmtAmount       MONEY,
	@RoutingNumber   NVARCHAR(20),
	@StartDate       DATETIME,
	@State           CHAR(2),
	@TotalAmount     MONEY,
	@Zip             NCHAR(10),
	@RowsAffecxted   INT = 0 OUTPUT,
	@ErrMessage      NVARCHAR(255) = '' OUTPUT
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

		INSERT INTO [dbo].[tblPaymentSchedule]
			([LoanNo], 
			[DateInserted], 
			[NumOfPmts], 
			[PmtAmount], 
			[StartDate], 
			[TotalAmount], 
			[AccountNumber], 
			[Address], 
			[City], 
			[Email], 
			[Name], 
			[Phone], 
			[RoutingNumber], 
			[State], 
			[ZIP], 
			[IsDeleted],
			[WhenUpdated])
		VALUES
			(@LoanNo,
			@DateInserted,
			@NumOfPmts,
			@PmtAmount,
			@StartDate,
			@TotalAmount,
			@AccountNumber,
			@Address,
			@City,
			@Email,
			@Name,
			@Phone,
			@RoutingNumber,
			@State,
			@Zip,
			@IsDeleted,
			NULL);
		
		SET @ID = SCOPE_IDENTITY();

		SET @NumRows = @@ROWCOUNT;

		SET @RowsAffecxted = @NumRows;

		IF @NumRows = 0 
			BEGIN;
				SET @ErrNum = 50004;
				SET @throwMsg = FORMATMESSAGE('The attempt to insert the payment record (LoanNo=%i) failed. Either the record does not exist or you do not have access to that record.', @LoanNo);
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

EXEC sys.sp_addextendedproperty @name=N'Version', @value=N'1.0.0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'spPaymentScheduleInsert'
GO


