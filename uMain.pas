unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, System.Classes,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    IdHTTP1: TIdHTTP;
    idslhndlrscktpnsl1: TIdSSLIOHandlerSocketOpenSSL;
    Memo1: TMemo;
    pnl1: TPanel;
    btnGet: TButton;
    btn1: TButton;
    btnPutButton1: TButton;
    btnPut: TButton;
    Button1: TButton;
    procedure btnPutButton1Click(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnPutClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
	uTransifexAPI;

{$R *.dfm}

procedure TForm7.btnGetClick(Sender: TObject);
var
  Response: TStringStream;
begin
  Response := TStringStream.Create;

  IdHTTP1.Request.BasicAuthentication := True;
  IdHTTP1.Request.Username := 'rrezino';
  IdHTTP1.Request.Password := 'rodrigoteste';

  IdHTTP1.Get('https://www.transifex.com/api/2/projects', Response);

  Memo1.Text := Response.DataString;
end;

procedure TForm7.btn1Click(Sender: TObject);
var
  Transifex: TTransifexAPI;
begin
  Transifex := TTransifexAPI.Create;
  Transifex.UserName := 'rrezino';
  Transifex.UserPassword := 'rodrigoteste';

  Memo1.Lines.Text := Transifex.GetProjects;
  Transifex.Free;
end;

procedure TForm7.btnPutButton1Click(Sender: TObject);
var
  Params: TStringStream;
  Response: TStringStream;
begin
  Params := TStringStream.Create('{"slug":"testefora","name":"TesteFora","source_language_code":"en","description":"Description", "private": true}');
  Params := TStringStream.Create('{"slug":"rodrigofarias","name":"RodrigoFarias","source_language_code":"en","description":"Teste","private":true}');
  Response := TStringStream.Create;


  IdHTTP1.Request.BasicAuthentication := True;
  IdHTTP1.Request.Username := 'rrezino';
  IdHTTP1.Request.Password := 'rodrigoteste';


  IdHTTP1.Post('https://www.transifex.com/api/2/projects',Params, Response );
  Memo1.Text := Response.DataString;
end;

procedure TForm7.btnPutClick(Sender: TObject);
var
  Transifex: TTransifexAPI;
  Project: TTransifexProject;
begin
  Transifex := TTransifexAPI.Create;
  Transifex.UserName := 'rrezino';
  Transifex.UserPassword := 'rodrigoteste';


  Project := TTransifexProject.Create;
  Project.Slug := 'rodrigofarias3';
  Project.Name := 'RodrigoFariasRezino3';
  Project.Description := 'Teste';
  Project.SourceLanguageCode := 'en';


  Transifex.CreateNewProject(Project);

end;

procedure TForm7.Button1Click(Sender: TObject);
var
  Transifex: TTransifexAPI;
  Project: TTransifexProject;
  ProjectDetails: string;
begin
  Transifex := TTransifexAPI.Create;
  Transifex.UserName := 'rrezino';
  Transifex.UserPassword := 'rodrigoteste';

  Transifex.GetProject('traducao-de-musicas', ProjectDetails);
  Memo1.Lines.Text := ProjectDetails;


end;

end.
