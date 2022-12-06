unit ufmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfmMainForm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    ED_TENANTID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ED_CLIENTID: TEdit;
    Label3: TLabel;
    ED_SECRET: TEdit;
    Label4: TLabel;
    ED_MAIL: TEdit;
    BT_GETTOKEN: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BT_GETTOKENClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const


  c_microsoft_tenantid = '????????-????-????-????-????????????';
  c_microsoft_tenantid = '????????-????-????-????-????????????';
  c_microsoft_clientsecret = 'AAAA~BBBBBBBB.CCCCCCCCCCCCCCCCCC~DDDD';
  c_microsoft_mail = 'your_email@your_domain.xxx';


var
  fmMainForm: TfmMainForm;

implementation

{$R *.dfm}

uses udmRestClient;

procedure TfmMainForm.FormCreate(Sender: TObject);
begin
  ED_TENANTID.text := c_microsoft_tenantid;
  ED_CLIENTID.Text := c_microsoft_clientid;
  ED_SECRET.Text := c_microsoft_clientsecret;
  ED_MAIL.Text := c_microsoft_mail;
end;

procedure TfmMainForm.BT_GETTOKENClick(Sender: TObject);
var
  v_token: string;
begin
  memo1.Lines.Clear;
  v_token := dmRestClient.GetAccessToken;
  if v_token <> '' then
  begin
    memo1.Lines.Add('Access Token: ' + v_token);
  end;
end;


end.
