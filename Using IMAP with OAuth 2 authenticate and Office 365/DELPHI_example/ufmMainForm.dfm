object fmMainForm: TfmMainForm
  Left = 0
  Top = 0
  Caption = 'Using IMAP with OAuth 2 authenticate and Office 365'
  ClientHeight = 659
  ClientWidth = 945
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 153
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 17
      Width = 48
      Height = 13
      Caption = 'Tenant ID'
    end
    object Label2: TLabel
      Left = 15
      Top = 44
      Width = 41
      Height = 13
      Caption = 'Client ID'
    end
    object Label3: TLabel
      Left = 15
      Top = 71
      Width = 31
      Height = 13
      Caption = 'Secret'
    end
    object Label4: TLabel
      Left = 15
      Top = 98
      Width = 18
      Height = 13
      Caption = 'Mail'
    end
    object ED_TENANTID: TEdit
      Left = 69
      Top = 14
      Width = 279
      Height = 21
      TabOrder = 0
      Text = 'got from const'
    end
    object ED_CLIENTID: TEdit
      Left = 69
      Top = 41
      Width = 279
      Height = 21
      TabOrder = 1
      Text = 'got from const'
    end
    object ED_SECRET: TEdit
      Left = 69
      Top = 68
      Width = 279
      Height = 21
      TabOrder = 2
      Text = 'got from const'
    end
    object ED_MAIL: TEdit
      Left = 69
      Top = 95
      Width = 279
      Height = 21
      TabOrder = 3
      Text = 'got from const'
    end
    object BT_GETTOKEN: TButton
      Left = 400
      Top = 14
      Width = 153
      Height = 45
      Caption = '(1) Get TOKEN'
      TabOrder = 4
      OnClick = BT_GETTOKENClick
    end
    object BT_CONNECT: TButton
      Left = 568
      Top = 14
      Width = 153
      Height = 45
      Caption = '(2) Connect IMAP'
      TabOrder = 5
      OnClick = BT_CONNECTClick
    end
    object BT_LIST_IMAP: TButton
      Left = 736
      Top = 14
      Width = 153
      Height = 45
      Caption = '(4) List IMAP'
      TabOrder = 6
      OnClick = BT_LIST_IMAPClick
    end
  end
  object ME_LOG: TMemo
    Left = 0
    Top = 153
    Width = 945
    Height = 506
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
