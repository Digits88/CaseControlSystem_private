USE master
GO
 -- CREATE DATABASE USER
CREATE LOGIN [admin] WITH PASSWORD=N'admin', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF 
GO

EXEC sys.sp_addsrvrolemember @loginame = N'admin', @rolename = N'sysadmin'
GO

ALTER LOGIN [admin] ENABLE
GO

-- CREATE DATABASE
IF EXISTS(select * from sys.databases where name='CaseControlDB')
DROP DATABASE CaseControlDB
GO
CREATE DATABASE CaseControlDB
GO
USE CaseControlDB
GO

/****** Object:  Table [dbo].[ClientEvidences]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientEvidences](
	[FileID] [int] NULL,
	[Evidence] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientEmployerDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientEmployerDetails](
	[FileID] [bigint] NULL,
	[Occupation] [nvarchar](100) NULL,
	[Employer] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientCourtDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientCourtDetails](
	[FileID] [bigint] NULL,
	[CaseNumber] [nvarchar](100) NULL,
	[Court] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientBasicDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientBasicDetails](
	[FileID] [bigint] NULL,
	[Address] [nvarchar](200) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[HomePhone] [nvarchar](20) NULL,
	[CellPhone] [nvarchar](20) NULL,
	[LicenseNumber] [nvarchar](30) NULL,
	[DateOfBirth] [datetime] NULL,
	[SSN] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[SuiteAddress] [nvarchar](100) NULL,
	[WorkPhone] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientAutoDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientAutoDetails](
	[FileID] [bigint] NULL,
	[InsuranceCompany] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](100) NULL,
	[Adjuster] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CaseInformation]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseInformation](
	[FileID] [bigint] NULL,
	[InitialInformation] [nvarchar](300) NULL,
	[DefendantName] [nvarchar](100) NULL,
	[OriginatingAttorny] [nvarchar](100) NULL,
	[AssignedAttorny] [nvarchar](100) NULL,
	[Referral] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserName] [nvarchar](100) NULL,
	[IsAdmin] [bit] NULL,
	[Password] [nvarchar](100) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Users] ([UserName], [IsAdmin], [Password]) VALUES (N'admin', 1, N'admin')
/****** Object:  Table [dbo].[StatuteInformation]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatuteInformation](
	[FileID] [bigint] NULL,
	[AccidentDate] [datetime] NULL,
	[AccDateAfter1yr] [datetime] NULL,
	[AccDateAfter2yr] [datetime] NULL,
	[ComplaintFileDate] [datetime] NULL,
	[ComplaintAfter60days] [datetime] NULL,
	[ComplaintAfter2yrs] [datetime] NULL,
	[ComplaintAfter3yrs] [datetime] NULL,
	[ComplaintAfter5yrs] [datetime] NULL,
	[IsGovtClaim] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherCaseType]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherCaseType](
	[CaseTypeID] [int] NULL,
	[CaseType] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LuCaseType]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LuCaseType](
	[CaseType] [nvarchar](150) NULL,
	[CaseTypeID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LuCaseType] ON
INSERT [dbo].[LuCaseType] ([CaseType], [CaseTypeID]) VALUES (N'Injury', 1)
INSERT [dbo].[LuCaseType] ([CaseType], [CaseTypeID]) VALUES (N'Illness', 2)
INSERT [dbo].[LuCaseType] ([CaseType], [CaseTypeID]) VALUES (N'Death', 3)
SET IDENTITY_INSERT [dbo].[LuCaseType] OFF
/****** Object:  Table [dbo].[LuBillingType]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LuBillingType](
	[Id] [int] NULL,
	[Type] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[LuBillingType] ([Id], [Type]) VALUES (1, N'General Account Debit')
INSERT [dbo].[LuBillingType] ([Id], [Type]) VALUES (2, N'General Account Credit')
INSERT [dbo].[LuBillingType] ([Id], [Type]) VALUES (3, N'Trust Account Debit')
INSERT [dbo].[LuBillingType] ([Id], [Type]) VALUES (4, N'Trust Account Credit')
/****** Object:  Table [dbo].[DefendantInsuranceDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefendantInsuranceDetails](
	[FileID] [bigint] NULL,
	[NameOfInsured] [nvarchar](100) NULL,
	[InsuranceCompany] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](100) NULL,
	[Adjuster] [nvarchar](100) NULL,
	[ClaimNumber] [nvarchar](100) NULL,
	[PolicyLimits] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DefendantInformation]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefendantInformation](
	[FileID] [bigint] NULL,
	[LastName] [nvarchar](100) NULL,
	[FirstName] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](100) NULL,
	[HomePhone] [nvarchar](20) NULL,
	[BusinessPhone] [nvarchar](20) NULL,
	[DateOfBirth] [datetime] NULL,
	[LicenseNumber] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DefendantAttorneyDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefendantAttorneyDetails](
	[FileID] [bigint] NULL,
	[Firm] [nvarchar](100) NULL,
	[Attorney] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientTransactionDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientTransactionDetails](
	[FileID] [int] NULL,
	[TransactionID] [int] NULL,
	[TransactionDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL,
	[BillingType] [nvarchar](50) NULL,
	[GeneralFund] [float] NULL,
	[TrustFund] [float] NULL,
	[CheckNo] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSpouseDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSpouseDetails](
	[FileID] [bigint] NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Occupation] [nvarchar](100) NULL,
	[Employer] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientPolicyDetails]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientPolicyDetails](
	[FileID] [bigint] NULL,
	[PolicyNumber] [nvarchar](100) NULL,
	[EffectiveStartDate] [datetime] NULL,
	[Amount] [float] NULL,
	[EffectiveEndDate] [datetime] NULL,
	[LiabilityMinCoverage] [float] NULL,
	[LiabilityMaxCoverage] [float] NULL,
	[UMIMinValue] [float] NULL,
	[UMIMaxValue] [float] NULL,
	[Notes] [nvarchar](300) NULL,
	[MedPayAvailable] [nvarchar](1) NULL,
	[Reimbursable] [nvarchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientMiscNotes]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientMiscNotes](
	[FileID] [bigint] NULL,
	[NoteNumber] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientMedicalInsurance]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientMedicalInsurance](
	[FileID] [bigint] NULL,
	[NamedInsured] [nvarchar](100) NULL,
	[InsuranceCompany] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [nvarchar](20) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[PolicyNumber] [nvarchar](100) NULL,
	[MediCalNumber] [nvarchar](100) NULL,
	[MediCareNumber] [nvarchar](100) NULL,
	[ClaimNumber] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientMaster]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientMaster](
	[ClientID] [bigint] NOT NULL,
	[FirstName] [nvarchar](150) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ClientCreatedOn] [nvarchar](100) NULL,
 CONSTRAINT [PK_ClientMaster] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientInjuries]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientInjuries](
	[FileID] [int] NULL,
	[InjuryNoteNumber] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[LastModifiedDate] [datetime] NULL,
	[Description] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientGovtClaims-State]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientGovtClaims-State](
	[FileID] [bigint] NULL,
	[DeniedDate] [datetime] NULL,
	[DeniedDateAfter180Days] [datetime] NULL,
	[FiledDate] [datetime] NULL,
	[FiledDateAfter60Days] [datetime] NULL,
	[FiledDateAfter2yrs] [datetime] NULL,
	[FiledDateAfter3yrs] [datetime] NULL,
	[FiledDateAfter5yrs] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientGovtClaims-Other]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientGovtClaims-Other](
	[FileID] [bigint] NULL,
	[DeniedDate] [datetime] NULL,
	[DeniedDateAfter180Days] [datetime] NULL,
	[FiledDate] [datetime] NULL,
	[FiledDateAfter60Days] [datetime] NULL,
	[FiledDateAfter2yrs] [datetime] NULL,
	[FiledDateAfter3yrs] [datetime] NULL,
	[FiledDateAfter5yrs] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientGovtClaims-Country]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientGovtClaims-Country](
	[FileID] [bigint] NULL,
	[DeniedDate] [datetime] NULL,
	[DeniedDateAfter180Days] [datetime] NULL,
	[FiledDate] [datetime] NULL,
	[FiledDateAfter60Days] [datetime] NULL,
	[FiledDateAfter2yrs] [datetime] NULL,
	[FiledDateAfter3yrs] [datetime] NULL,
	[FiledDateAfter5yrs] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientGovtClaims-City]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientGovtClaims-City](
	[FileID] [bigint] NULL,
	[DeniedDate] [datetime] NULL,
	[DeniedDateAfter180days] [datetime] NULL,
	[ClaimDueDate] [datetime] NULL,
	[ClaimDueDateAfter60Days] [datetime] NULL,
	[ClaimDueDateAfter2yrs] [datetime] NULL,
	[ClaimDueDateAfter3yrs] [datetime] NULL,
	[ClaimDueDateAfter5yrs] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientFileMaster]    Script Date: 12/21/2013 09:18:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientFileMaster](
	[ClientID] [bigint] NULL,
	[CaseTypeID] [int] NULL,
	[AccidentDate] [datetime] NULL,
	[CaseStatus] [nvarchar](100) NULL,
	[FileID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_ClientFileMaster_ClientMaster1]    Script Date: 12/21/2013 09:18:21 ******/
ALTER TABLE [dbo].[ClientFileMaster]  WITH CHECK ADD  CONSTRAINT [FK_ClientFileMaster_ClientMaster1] FOREIGN KEY([ClientID])
REFERENCES [dbo].[ClientMaster] ([ClientID])
GO
ALTER TABLE [dbo].[ClientFileMaster] CHECK CONSTRAINT [FK_ClientFileMaster_ClientMaster1]
GO

USE [CaseControlDB]
GO

/****** Object:  Table [dbo].[DBBackupStatus]    Script Date: 01/10/2014 22:24:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DBBackupStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastBackupTakenOn] [nvarchar](50) NULL,
 CONSTRAINT [PK_DBBackupStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE procedure BackupDatabase
@databaseName nvarchar(50)
,@backupPath nvarchar(200)
,@backupDate nvarchar(50)
AS
BEGIN
	declare @sql as nvarchar(1000)
	set @sql='BACKUP DATABASE ' + @databaseName + ' TO DISK = ' +@backupPath
	exec sp_executesql @sql
	
	INSERT INTO DBBackupStatus Values(@backupDate)
	
END