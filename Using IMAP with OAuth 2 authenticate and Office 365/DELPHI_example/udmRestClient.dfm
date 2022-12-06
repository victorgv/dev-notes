object dmRestClient: TdmRestClient
  OldCreateOrder = False
  Height = 236
  Width = 556
  object ClientAccessToken: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 48
    Top = 48
  end
  object RequestAccessToken: TRESTRequest
    Client = ClientAccessToken
    Method = rmPOST
    Params = <>
    Response = ResponseAccessToken
    SynchronizedEvents = False
    Left = 160
    Top = 48
  end
  object ResponseAccessToken: TRESTResponse
    ContentType = 'application/json'
    Left = 280
    Top = 48
  end
end
