/*****************************************************************************************************************************
When       Who What
========== === ================================================================================================================
01/06/2019 JDJ Genesis


******************************************************************************************************************************/

USE [Interview]

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'tblPaymentSchedule')
	BEGIN

		CREATE TABLE [dbo].[tblPaymentSchedule](
			[ID] [bigint] IDENTITY(1,1) NOT NULL,
			[LoanNo] [int] NOT NULL,
			[DateInserted] [datetime] NOT NULL,
			[NumOfPmts] [int] NOT NULL,
			[PmtAmount] [money] NOT NULL,
			[StartDate] [datetime] NULL,
			[TotalAmount] [money] NOT NULL,
			[AccountNumber] [nvarchar](20) NOT NULL,
			[Address] [nvarchar](50) NOT NULL,
			[City] [nvarchar](50) NOT NULL,
			[Email] [nvarchar](30) NOT NULL,
			[Name] [nvarchar](30) NOT NULL,
			[Phone] [char](10) NOT NULL,
			[RoutingNumber] [nvarchar](20) NOT NULL,
			[State] [char](2) NOT NULL,
			[ZIP] [nchar](10) NOT NULL,
			[IsDeleted] [datetime] NULL,
			[WhenUpdated] [datetime] NULL
		 CONSTRAINT [PK_tblPaymentSchedule] PRIMARY KEY CLUSTERED 
		(
			[ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]


		CREATE UNIQUE NONCLUSTERED INDEX [IX_tblPaymentSchedule_LoanNo] ON [dbo].[tblPaymentSchedule]
		(
			[LoanNo] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


		CREATE NONCLUSTERED INDEX [IX_tblPaymentSchedule_IsDeleted] ON [dbo].[tblPaymentSchedule]
		(
			[IsDeleted] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_tblPaymentSchedule_WhenUpdated] ON [dbo].[tblPaymentSchedule]
		(
			[WhenUpdated] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_NumOfPmts]  DEFAULT ((0)) FOR [NumOfPmts]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_PmtAmount]  DEFAULT ((0)) FOR [PmtAmount]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_TotalAmount]  DEFAULT ((0)) FOR [TotalAmount]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_AccountNumber]  DEFAULT ('') FOR [AccountNumber]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_Address]  DEFAULT ('') FOR [Address]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_City]  DEFAULT ('') FOR [City]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_Email]  DEFAULT ('') FOR [Email]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_Name]  DEFAULT ('') FOR [Name]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_Phone]  DEFAULT ('') FOR [Phone]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_RoutingNumber]  DEFAULT ('') FOR [RoutingNumber]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_State]  DEFAULT ('') FOR [State]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_ZIP]  DEFAULT ('') FOR [ZIP]

		ALTER TABLE [dbo].[tblPaymentSchedule] ADD  CONSTRAINT [DF_tblPaymentSchedule_IsDeleted]  DEFAULT ((NULL)) FOR [IsDeleted]

	END

