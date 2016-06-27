object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 680
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 1008
    Height = 639
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    ExplicitLeft = 264
    ExplicitTop = 45
    ExplicitWidth = 297
    ExplicitHeight = 247
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 232
    ExplicitTop = 152
    ExplicitWidth = 185
    object btnGet: TButton
      Left = 111
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Get'
      TabOrder = 0
      OnClick = btnGetClick
    end
    object btn1: TButton
      Left = 336
      Top = 6
      Width = 129
      Height = 25
      Caption = 'API Get Project'
      TabOrder = 1
      OnClick = btn1Click
    end
    object btnPutButton1: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Post'
      TabOrder = 2
      OnClick = btnPutButton1Click
    end
    object btnPut: TButton
      Left = 496
      Top = 6
      Width = 75
      Height = 25
      Caption = 'API POST '
      TabOrder = 3
      OnClick = btnPutClick
    end
    object Button1: TButton
      Left = 592
      Top = 6
      Width = 97
      Height = 25
      Caption = 'API Get Details'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  object IdHTTP1: TIdHTTP
    IOHandler = idslhndlrscktpnsl1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.ContentType = 'application/json'
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Username = 'rrezino'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 192
    Top = 152
  end
  object idslhndlrscktpnsl1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 520
    Top = 136
  end
end
