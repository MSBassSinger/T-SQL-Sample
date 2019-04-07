/*****************************************************************************************************************************
When       Who What
========== === ================================================================================================================
01/06/2019 JDJ Genesis


******************************************************************************************************************************/

SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

USE [Interview]

IF NOT EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'tblPaymentScheduleDetails')
	BEGIN

		CREATE TABLE [dbo].[tblPaymentScheduleDetails](
			[ID] [bigint] IDENTITY(1,1) NOT NULL,
			[PaymentNo] [int] NOT NULL,
			[DateInserted] [datetime] NOT NULL,
			[ParentID] [bigint] NOT NULL,
			[PaymentAmount] [money] NOT NULL,
			[PmtScheduleDate] [datetime] NULL,
			[IsDeleted] [datetime] NULL,
			[WhenUpdated] [datetime] NULL,
		 CONSTRAINT [PK_tblPaymentScheduleDetails] PRIMARY KEY CLUSTERED 
		(
			[ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_tblPaymentScheduleDetails_ParentID] ON [dbo].[tblPaymentScheduleDetails]
		(
			[ParentID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_tblPaymentScheduleDetails_PaymentNo] ON [dbo].[tblPaymentScheduleDetails]
		(
			[PaymentNo] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_tblPaymentScheduleDetails_IsDeleted] ON [dbo].[tblPaymentScheduleDetails]
		(
			[IsDeleted] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_tblPaymentScheduleDetails_WhenUpdated] ON [dbo].[tblPaymentScheduleDetails]
		(
			[WhenUpdated] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

		ALTER TABLE [dbo].[tblPaymentScheduleDetails] ADD  CONSTRAINT [DF_tblPaymentScheduleDetails_PaymentAmount]  DEFAULT ((0)) FOR [PaymentAmount]

		ALTER TABLE [dbo].[tblPaymentScheduleDetails] ADD  CONSTRAINT [DF_tblPaymentScheduleDetails_IsDeleted]  DEFAULT ((NULL)) FOR [IsDeleted]

		ALTER TABLE [dbo].[tblPaymentScheduleDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblPaymentScheduleDetails_tblPaymentSchedule] FOREIGN KEY([ParentID])
		REFERENCES [dbo].[tblPaymentSchedule] ([ID])

		ALTER TABLE [dbo].[tblPaymentScheduleDetails] CHECK CONSTRAINT [FK_tblPaymentScheduleDetails_tblPaymentSchedule]

    END



