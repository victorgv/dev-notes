unit ufmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uTImapOutlookEmail;

type
  TfmMainForm = class(TForm)
    Panel1: TPanel;
    ME_LOG: TMemo;
    ED_TENANTID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ED_CLIENTID: TEdit;
    Label3: TLabel;
    ED_SECRET: TEdit;
    Label4: TLabel;
    ED_MAIL: TEdit;
    BT_GETTOKEN: TButton;
    BT_CONNECT: TButton;
    BT_LIST_IMAP: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BT_GETTOKENClick(Sender: TObject);
    procedure BT_CONNECTClick(Sender: TObject);
    procedure BT_LIST_IMAPClick(Sender: TObject);
  private
    { Private declarations }
    FToken: String;
    InstanceTImapOutlookEmail: TImapOutlookEmail;
  public
    { Public declarations }
  end;



var
  fmMainForm: TfmMainForm;

implementation

{$R *.dfm}

uses udmRestClient, constant;

procedure TfmMainForm.FormCreate(Sender: TObject);
begin
  InstanceTImapOutlookEmail := NIL;
  ED_TENANTID.text := C_MICROSOFT_TENANTID;
  ED_CLIENTID.Text := C_MICROSOFT_CLIENTID;
  ED_SECRET.Text := C_MICROSOFT_CLIENTSECRET;
  ED_MAIL.Text := C_MICROSOFT_MAIL;
end;

procedure TfmMainForm.BT_GETTOKENClick(Sender: TObject);
begin
  ME_LOG.Lines.Clear;
  FToken := dmRestClient.GetAccessToken;
  if FToken <> '' then
  begin
    ME_LOG.Lines.Add('Access Token: ' + FToken);
  end
  else
  begin
    ME_LOG.Lines.Add('Authenticating Error');
  end;
end;

procedure TfmMainForm.BT_CONNECTClick(Sender: TObject);
begin
  if not Assigned(InstanceTImapOutlookEmail) then
    InstanceTImapOutlookEmail := TImapOutlookEmail.Create(ED_MAIL.Text, FToken);

  InstanceTImapOutlookEmail.DoConnect;
end;

procedure TfmMainForm.BT_LIST_IMAPClick(Sender: TObject);
begin
  InstanceTImapOutlookEmail.DoListMailBoxes;
end;


end.
