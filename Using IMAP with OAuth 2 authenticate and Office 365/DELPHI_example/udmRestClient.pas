unit udmRestClient;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Types, System.DateUtils;

type
  TdmRestClient = class(TDataModule)
    ClientAccessToken: TRESTClient;
    RequestAccessToken: TRESTRequest;
    ResponseAccessToken: TRESTResponse;
  private
    { Private declarations }
    function RequestAccessTokenGraph: String;
    procedure setRequestParameters;

  public
    { Public declarations }
    function GetAccessToken: String;
  end;

var
  dmRestClient: TdmRestClient;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ufmMainForm, constant;

{$R *.dfm}

{ TdmRestClient }

function TdmRestClient.GetAccessToken: String;
begin
  ClientAccessToken.BaseURL := C_ACCESSTOKENENDPOINT.Replace('*YOUR_TENANT_ID*', fmMainForm.ED_TENANTID.Text);
  setRequestParameters;
  Result := RequestAccessTokenGraph;
end;


procedure TdmRestClient.setRequestParameters;
var
  param: TRESTRequestParameter;
begin
  param := RequestAccessToken.Params.AddItem;
  param.Name := 'scope';
  param.Value := C_SCOPES;
  param.Kind := pkREQUESTBODY;
  param.Options := [poDoNotEncode];

  param := RequestAccessToken.Params.AddItem;
  param.Name := 'grant_type';
  param.Value := 'client_credentials';
  param.Kind := pkREQUESTBODY;
  param.Options := [poDoNotEncode];

  param := RequestAccessToken.Params.AddItem;
  param.Name := 'client_id';
  param.Value := fmMainForm.ED_CLIENTID.Text;
  param.Kind := pkREQUESTBODY;
  param.Options := [poDoNotEncode];

  param := RequestAccessToken.Params.AddItem;
  param.Name := 'client_secret';
  param.Value := fmMainForm.ED_SECRET.Text;
  param.Kind := pkREQUESTBODY;
  param.Options := [poDoNotEncode];

end;


function TdmRestClient.RequestAccessTokenGraph: String;
var
  LToken: string;
  LIntValue: int64;
  AccessToken: String;
  RefreshToken: String;
  IDToken: String;
  AccessTokenExpiry: TDateTime;
begin
  dmRestClient.RequestAccessToken.Execute;
  if dmRestClient.ResponseAccessToken.GetSimpleValue('access_token', LToken) then
    AccessToken := LToken;
  if dmRestClient.ResponseAccessToken.GetSimpleValue('refresh_token', LToken) then
    RefreshToken := LToken;
  if dmRestClient.ResponseAccessToken.GetSimpleValue('id_token', LToken) then
    IDToken := LToken;
  // detect token-type. this is important for how using it later
  //if dmRestClient.ResponseAccessToken.GetSimpleValue('token_type', LToken) then
  //  TokenType := OAuth2TokenTypeFromString(LToken);
  // if provided by the service, the field "expires_in" contains
  // the number of seconds an access-token will be valid
  if dmRestClient.ResponseAccessToken.GetSimpleValue('expires_in', LToken) then
  begin
    LIntValue := StrToIntdef(LToken, -1);
    if (LIntValue > -1) then
      AccessTokenExpiry := IncSecond(Now, LIntValue)
    else
      AccessTokenExpiry := 0.0;
  end;

  Result := AccessToken;
end;



end.
