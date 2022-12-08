program ExampleIMAPwithOAuth2_Office365;

uses
  Vcl.Forms,
  ufmMainForm in 'ufmMainForm.pas' {FM_MAIN},
  udmRestClient in 'udmRestClient.pas' {dmRestClient: TDataModule},
  uTImapOutlookEmail in 'uTImapOutlookEmail.pas',
  constant in 'constant.pas',
  IdSASLXOAUTH in 'IdSASLXOAUTH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMainForm, fmMainForm);
  Application.CreateForm(TdmRestClient, dmRestClient);
  Application.Run;
end.
