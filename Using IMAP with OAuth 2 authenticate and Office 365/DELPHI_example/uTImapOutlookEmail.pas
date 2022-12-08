unit uTImapOutlookEmail;

interface

uses IdImap4, IdExplicitTLSClientServerBase, IdSASLCollection, IdSSLOpenSSL, SysUtils, IdIntercept, idGlobal;

type
  TImapOutlookEmail = class
  private
    FToken: String;
    FEmail_address: String;
    FImap: TIdIMAP4;
    FIdSSLIOHandlerSocketIMAP: TIdSSLIOHandlerSocketOpenSSL;
    FIdConnectionInterceptIMAP: TIdConnectionIntercept;
    procedure IdConnectionInterceptSend(ASender: TIdConnectionIntercept; var ABuffer: TIdBytes);
    procedure IdConnectionInterceptReceive(ASender: TIdConnectionIntercept; var ABuffer: TIdBytes);
  public
    constructor Create(const email_address,token: String);
    destructor Destroy; Override;
    procedure DoConnect;
    procedure DoListMailBoxes;

  end;

implementation

{ TImapOutlookEmail }

uses constant, IdSASLXOAUTH, System.Classes, ufmMainForm;

constructor TImapOutlookEmail.Create(const email_address,token: String);
begin
  inherited create;
  FImap := TIdIMAP4.Create;
  FIdSSLIOHandlerSocketIMAP := TIdSSLIOHandlerSocketOpenSSL.Create;
  FImap.IOHandler := FIdSSLIOHandlerSocketIMAP;

  // --> Optional, only in order to capturate communication messages
  FIdConnectionInterceptIMAP := TIdConnectionIntercept.Create;
  FImap.Intercept := FIdConnectionInterceptIMAP;
  FIdConnectionInterceptIMAP.OnSend := IdConnectionInterceptSend;
  FIdConnectionInterceptIMAP.OnReceive := IdConnectionInterceptReceive;
  // --> Final

  FToken := token;
  FEmail_address := email_address;
end;


destructor TImapOutlookEmail.Destroy;
begin
  FImap.Free;
  FIdSSLIOHandlerSocketIMAP.Free;
  FIdConnectionInterceptIMAP.Free;
  inherited;
end;

procedure TImapOutlookEmail.DoConnect;
var
  xoauthSASL : TIdSASLListEntry;
begin
  FImap.Host := C_IMAPHOST;
  FImap.Port := C_IMAPPORT;
  FImap.Username := C_MICROSOFT_CLIENTID;
  FImap.UseTLS := utUseImplicitTLS;
  FImap.RetrieveOnSelect := rsDisabled;
  FImap.AuthType := iatSASL;

  xoauthSASL := FImap.SASLMechanisms.Add;
  xoauthSASL.SASL := TIdSASLXOAuth.Create(nil);
  TIdSASLXOAuth(xoauthSASL.SASL).Token := FToken;
  TIdSASLXOAuth(xoauthSASL.SASL).User := C_MICROSOFT_MAIL;

  //FIdSSLIOHandlerSocketIMAP.SSLOptions.Method := TIdSSLVersion.sslvTLSv1_2;

  FImap.Connect;
  fmMainForm.ME_LOG.Lines.Add('********** IMAP IS CONNECTED');
end;

procedure TImapOutlookEmail.DoListMailBoxes;
var
  mailboxes: TStringList;
begin
  if Assigned(FImap) AND (FImap.Connected) then
  begin
    try
      // List Mailboxes
      mailboxes := TStringList.Create;
      try
        FImap.ListMailBoxes(mailboxes);
        fmMainForm.ME_LOG.Lines.Add(mailboxes.Text);
      finally
        mailboxes.Free;
      end;
      // Show number emails into "inbox"
      FImap.SelectMailBox('INBOX');
      fmMainForm.ME_LOG.Lines.Add('In "Inbox" there are ' + FImap.MailBox.TotalMsgs.ToString + ' emails');
    finally
      FImap.Disconnect;
    end;
  end
  else
    fmMainForm.ME_LOG.Lines.Add('Try connecting to IMAP first');
end;

procedure TImapOutlookEmail.IdConnectionInterceptReceive(ASender: TIdConnectionIntercept; var ABuffer: TIdBytes);
begin
  fmMainForm.ME_LOG.Lines.Add('Receive:' + TEncoding.ASCII.GetString(ABuffer));
end;

procedure TImapOutlookEmail.IdConnectionInterceptSend(ASender: TIdConnectionIntercept; var ABuffer: TIdBytes);
begin
  fmMainForm.ME_LOG.Lines.Add('Send:' + TEncoding.ASCII.GetString(ABuffer));
end;

end.
