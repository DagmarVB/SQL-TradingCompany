USE [TradingGmbH]
GO
/****** Object:  Table [dbo].[Aktie]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aktie](
	[AktienID] [bigint] IDENTITY(1,1) NOT NULL,
	[Bezeichnung] [nvarchar](50) NOT NULL,
	[Ticker] [char](10) NOT NULL,
 CONSTRAINT [PK_Aktie] PRIMARY KEY CLUSTERED 
(
	[AktienID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aktienkurs]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aktienkurs](
	[AktienkursID] [bigint] IDENTITY(1,1) NOT NULL,
	[Datum] [date] NOT NULL,
	[Kurs] [money] NOT NULL,
	[AktienID] [bigint] NOT NULL,
 CONSTRAINT [PK_Aktienkurs] PRIMARY KEY CLUSTERED 
(
	[AktienkursID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aktienkurs_Import_HYMTF]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aktienkurs_Import_HYMTF](
	[Datum] [date] NOT NULL,
	[Kurs] [money] NOT NULL,
	[AktienID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aktienkurs_Import_tsla]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aktienkurs_Import_tsla](
	[Datum] [date] NOT NULL,
	[Kurs] [money] NOT NULL,
	[AktienID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aktienkurs_Import_vw]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aktienkurs_Import_vw](
	[datum] [date] NOT NULL,
	[kurs] [money] NOT NULL,
	[AktienID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AktieTrader]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AktieTrader](
	[AktieTraderID] [bigint] IDENTITY(1,1) NOT NULL,
	[TraderID] [bigint] NOT NULL,
	[AktienID] [bigint] NOT NULL,
 CONSTRAINT [PK_AktieTrader] PRIMARY KEY CLUSTERED 
(
	[AktieTraderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Konto]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Konto](
	[KontoID] [bigint] IDENTITY(1,1) NOT NULL,
	[KundenID] [bigint] NOT NULL,
	[Kontostand] [money] NOT NULL,
 CONSTRAINT [PK_Konto] PRIMARY KEY CLUSTERED 
(
	[KontoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KontoLOG]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KontoLOG](
	[KontoLOGID] [bigint] IDENTITY(1,1) NOT NULL,
	[KontoID] [bigint] NULL,
	[Art] [char](1) NOT NULL,
	[Datum] [date] NOT NULL,
	[KontostandAlt] [money] NULL,
	[KontostandNeu] [money] NULL,
 CONSTRAINT [PK_KontoLOG] PRIMARY KEY CLUSTERED 
(
	[KontoLOGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kunde]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kunde](
	[KundenID] [bigint] IDENTITY(1,1) NOT NULL,
	[PersonID] [bigint] NOT NULL,
	[TraderID] [bigint] NOT NULL,
 CONSTRAINT [PK_Kunde] PRIMARY KEY CLUSTERED 
(
	[KundenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KundenTrade]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KundenTrade](
	[KundenTradeID] [bigint] IDENTITY(1,1) NOT NULL,
	[KundenID] [bigint] NOT NULL,
	[TradeID] [bigint] NOT NULL,
	[Positionsgroesse] [money] NOT NULL,
	[GewinnVerlust] [money] NULL,
 CONSTRAINT [PK_KundenTrade] PRIMARY KEY CLUSTERED 
(
	[KundenTradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Vorname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trade]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trade](
	[TradeID] [bigint] IDENTITY(1,1) NOT NULL,
	[TradetypID] [bigint] NOT NULL,
	[AktienkursID] [bigint] NOT NULL,
	[Erfolg] [bit] NULL,
	[Kursaenderung] [decimal](6, 2) NULL,
 CONSTRAINT [PK_Trade] PRIMARY KEY CLUSTERED 
(
	[TradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trader]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trader](
	[TraderID] [bigint] IDENTITY(1,1) NOT NULL,
	[PersonID] [bigint] NOT NULL,
	[Gehalt] [money] NOT NULL,
 CONSTRAINT [PK_Trader] PRIMARY KEY CLUSTERED 
(
	[TraderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tradetyp]    Script Date: 24.02.2023 14:16:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tradetyp](
	[TradetypID] [bigint] NOT NULL,
	[Bezeichnung] [nvarchar](50) NOT NULL,
	[Kauf] [bit] NOT NULL,
	[Einsatz] [decimal](4, 3) NOT NULL,
	[Mindestguthaben] [money] NOT NULL,
 CONSTRAINT [PK_Tradetyp] PRIMARY KEY CLUSTERED 
(
	[TradetypID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tradetyp] ADD  CONSTRAINT [DF_Tradetyp_Einsatz]  DEFAULT ((0.10)) FOR [Einsatz]
GO
ALTER TABLE [dbo].[Aktienkurs]  WITH CHECK ADD  CONSTRAINT [FK_Aktienkurs_Aktie] FOREIGN KEY([AktienID])
REFERENCES [dbo].[Aktie] ([AktienID])
GO
ALTER TABLE [dbo].[Aktienkurs] CHECK CONSTRAINT [FK_Aktienkurs_Aktie]
GO
ALTER TABLE [dbo].[AktieTrader]  WITH CHECK ADD  CONSTRAINT [FK_AktieTrader_Aktie] FOREIGN KEY([AktienID])
REFERENCES [dbo].[Aktie] ([AktienID])
GO
ALTER TABLE [dbo].[AktieTrader] CHECK CONSTRAINT [FK_AktieTrader_Aktie]
GO
ALTER TABLE [dbo].[AktieTrader]  WITH CHECK ADD  CONSTRAINT [FK_AktieTrader_Trader] FOREIGN KEY([TraderID])
REFERENCES [dbo].[Trader] ([TraderID])
GO
ALTER TABLE [dbo].[AktieTrader] CHECK CONSTRAINT [FK_AktieTrader_Trader]
GO
ALTER TABLE [dbo].[Konto]  WITH CHECK ADD  CONSTRAINT [FK_Konto_Kunde] FOREIGN KEY([KundenID])
REFERENCES [dbo].[Kunde] ([KundenID])
GO
ALTER TABLE [dbo].[Konto] CHECK CONSTRAINT [FK_Konto_Kunde]
GO
ALTER TABLE [dbo].[KontoLOG]  WITH CHECK ADD  CONSTRAINT [FK_KontoLOG_Konto] FOREIGN KEY([KontoID])
REFERENCES [dbo].[Konto] ([KontoID])
GO
ALTER TABLE [dbo].[KontoLOG] CHECK CONSTRAINT [FK_KontoLOG_Konto]
GO
ALTER TABLE [dbo].[Kunde]  WITH CHECK ADD  CONSTRAINT [FK_Kunde_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[Kunde] CHECK CONSTRAINT [FK_Kunde_Person]
GO
ALTER TABLE [dbo].[Kunde]  WITH CHECK ADD  CONSTRAINT [FK_Kunde_Trader] FOREIGN KEY([TraderID])
REFERENCES [dbo].[Trader] ([TraderID])
GO
ALTER TABLE [dbo].[Kunde] CHECK CONSTRAINT [FK_Kunde_Trader]
GO
ALTER TABLE [dbo].[KundenTrade]  WITH CHECK ADD  CONSTRAINT [FK_KundenTrade_Kunde] FOREIGN KEY([KundenID])
REFERENCES [dbo].[Kunde] ([KundenID])
GO
ALTER TABLE [dbo].[KundenTrade] CHECK CONSTRAINT [FK_KundenTrade_Kunde]
GO
ALTER TABLE [dbo].[KundenTrade]  WITH CHECK ADD  CONSTRAINT [FK_KundenTrade_Trade] FOREIGN KEY([TradeID])
REFERENCES [dbo].[Trade] ([TradeID])
GO
ALTER TABLE [dbo].[KundenTrade] CHECK CONSTRAINT [FK_KundenTrade_Trade]
GO
ALTER TABLE [dbo].[Trade]  WITH CHECK ADD  CONSTRAINT [FK_Trade_Aktienkurs] FOREIGN KEY([AktienkursID])
REFERENCES [dbo].[Aktienkurs] ([AktienkursID])
GO
ALTER TABLE [dbo].[Trade] CHECK CONSTRAINT [FK_Trade_Aktienkurs]
GO
ALTER TABLE [dbo].[Trade]  WITH CHECK ADD  CONSTRAINT [FK_Trade_Tradetyp] FOREIGN KEY([TradetypID])
REFERENCES [dbo].[Tradetyp] ([TradetypID])
GO
ALTER TABLE [dbo].[Trade] CHECK CONSTRAINT [FK_Trade_Tradetyp]
GO
ALTER TABLE [dbo].[Trader]  WITH CHECK ADD  CONSTRAINT [FK_Trader_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[Trader] CHECK CONSTRAINT [FK_Trader_Person]
GO
ALTER TABLE [dbo].[Aktie]  WITH CHECK ADD  CONSTRAINT [CK_Ticker] CHECK  ((len([Ticker])>=(3)))
GO
ALTER TABLE [dbo].[Aktie] CHECK CONSTRAINT [CK_Ticker]
GO
ALTER TABLE [dbo].[Aktienkurs]  WITH CHECK ADD  CONSTRAINT [CK_Datum] CHECK  (([Datum]<=getdate()))
GO
ALTER TABLE [dbo].[Aktienkurs] CHECK CONSTRAINT [CK_Datum]
GO
ALTER TABLE [dbo].[Aktienkurs]  WITH CHECK ADD  CONSTRAINT [CK_Kurs] CHECK  (([Kurs]>=(0)))
GO
ALTER TABLE [dbo].[Aktienkurs] CHECK CONSTRAINT [CK_Kurs]
GO
ALTER TABLE [dbo].[Konto]  WITH CHECK ADD  CONSTRAINT [CK_Kontostand] CHECK  (([Kontostand]>=(0)))
GO
ALTER TABLE [dbo].[Konto] CHECK CONSTRAINT [CK_Kontostand]
GO
