//Unit created based on http://docs.transifex.com/api/
unit uTransifexAPI;

interface

uses
 System.SysUtils, IdSSLOpenSSL, IdHTTP, Data.DBXJSON;

type
  TransifexException = class(Exception);
  TransifexContent = string;

  TTransifexProject = class
  private
    FSlug: string;
    FName: string;
    FDescription: string;
    FSourceLanguageCode: string;
    FIsPrivate: Boolean;
    procedure SetName(const Value: string);
    procedure SetSlug(const Value: string);

    function RemoveUnavailableChars(Desc: string): string;
  public
    constructor Create;

    property Slug: string read FSlug write SetSlug;
    property Name: string read FName write SetName;
    property Description: string read FDescription write FDescription;
    property SourceLanguageCode: string read FSourceLanguageCode write FSourceLanguageCode;
    property IsPrivate: Boolean read FIsPrivate write FIsPrivate;

    function ConvertToJson: TJSONObject;
  end;

  TTransifexAPI = class(TObject)
  private
    FUserName: string;
    FUserPassword: string;

    FHttpComunication: TIdHTTP;
    FIOHandler: TIdSSLIOHandlerSocketOpenSSL;

    function ConfigureLogin: Boolean;

    procedure CreateHttpComunication;
    procedure DestroyHttpComunication;
  public
    constructor Create;
    destructor Destroy;

    function CreateNewProject(Project: TTransifexProject): string;
    function GetProjects: TransifexContent;
    function GetProject(Slug: string; out ProjectDetails: string): Boolean;

    property UserName: string read FUserName write FUserName;
    property UserPassword: string read FUserPassword write FUserPassword;
  end;


implementation

uses
	System.Classes, REST.Json;

const
  TRANSIFEX_API_ADDR = 'https://www.transifex.com/api/2/';
  COMUN_GET_PROJECTS = 'https://www.transifex.com/api/2/projects';
  COMUN_POST_CREATE_PROJECTS = 'https://www.transifex.com/api/2/projects/';
  COMUN_GET_PROJECT = 'https://www.transifex.com/api/2/project/%s/?details';

{ TTransifexAPI }

function TTransifexAPI.ConfigureLogin: Boolean;
begin
  Result := False;

  if FUserName = '' then
    raise TransifexException.Create('User name is not setted.');

  if FUserPassword = '' then
    raise TransifexException.Create('Password is not setted.');

  FHttpComunication.Request.Username := FUserName;
  FHttpComunication.Request.Password := FUserPassword;
  FHttpComunication.Request.BasicAuthentication := True;
  Result := True;
end;

constructor TTransifexAPI.Create;
begin
  CreateHttpComunication;
end;

procedure TTransifexAPI.CreateHttpComunication;
begin
  FHttpComunication := TIdHTTP.Create(nil);
  FIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  FHttpComunication.IOHandler := FIOHandler;

  FHttpComunication.Request.ContentType := 'application/json'
end;

function TTransifexAPI.CreateNewProject(Project: TTransifexProject): string;
var
  ContentToSend: TStringStream;
  Json: TJSONObject;
  Response: TStringStream;
begin
  if not ConfigureLogin then
    Exit;

  Json := Project.ConvertToJson;

  ContentToSend := TStringStream.Create(Json.ToString);
  Response := TStringStream.Create;
  try
    FHttpComunication.Post(COMUN_POST_CREATE_PROJECTS, ContentToSend, Response);
    Result := Response.DataString;
  finally
    ContentToSend.Free;
    Response.Free;
  end;
end;

destructor TTransifexAPI.Destroy;
begin
  DestroyHttpComunication;
end;

procedure TTransifexAPI.DestroyHttpComunication;
begin
  FIOHandler.Free;
  FHttpComunication.Free;
end;

function TTransifexAPI.GetProject(Slug: string; out ProjectDetails: string): Boolean;
var
  Response: TStringStream;
begin
  Result := False;

  if not ConfigureLogin then
    Exit;

  Response := TStringStream.Create;
  try
    FHttpComunication.Get(Format(COMUN_GET_PROJECT, [Slug]), Response);
    ProjectDetails := Response.DataString;
  finally
    Response.Free;
  end;
end;

function TTransifexAPI.GetProjects: TransifexContent;
var
  Response: TStringStream;
begin
  Result := '';

  if not ConfigureLogin then
    Exit;

  Response := TStringStream.Create;
  try
    FHttpComunication.Get(COMUN_GET_PROJECTS, Response);
    Result := Response.DataString;
  finally
    Response.Free;
  end;
end;

{ TTransifexProject }

function TTransifexProject.ConvertToJson: TJSONObject;
var
  TrueJson: TJSONTrue;
  FalseJson: TJSONFalse;
begin
  Result := TJSONObject.Create;
  Result.AddPair('slug', FSlug);
  Result.AddPair('name', FName);
  Result.AddPair('source_language_code', FSourceLanguageCode);
  Result.AddPair('description', FDescription);

  if FIsPrivate then
  begin
    TrueJson := TJSONTrue.Create;
    Result.AddPair('private',  TrueJson);
  end
  else
  begin
    FalseJson := TJSONFalse.Create;
    Result.AddPair('private', FalseJson);
  end;
end;

constructor TTransifexProject.Create;
begin
  FIsPrivate := True;
end;

function TTransifexProject.RemoveUnavailableChars(Desc: string): string;
begin
  Desc := Trim(Desc);
  Desc := StringReplace(Desc, ' ', '', [rfReplaceAll]);
end;

procedure TTransifexProject.SetName(const Value: string);
begin
  FName := RemoveUnavailableChars(Value);
end;

procedure TTransifexProject.SetSlug(const Value: string);
begin
  FSlug := RemoveUnavailableChars(Value);
end;

end.
