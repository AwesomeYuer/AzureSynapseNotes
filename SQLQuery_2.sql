SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdventureWorksDWBuildVersion]
(
	[DBVersion] [nvarchar](50) NOT NULL,
	[VersionDate] [datetime] NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [DBVersion] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
