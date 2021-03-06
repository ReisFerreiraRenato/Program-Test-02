program BackEnd;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  ActiveX,
  System.JSON,
  Horse.Jhonson,
  Rest.Json,
  System.Classes,
  Horse.Commons,
  untFuncoes in 'untFuncoes.pas',
  untDataModulo in 'untDataModulo.pas' {DataModuloPrincipal: TDataModule},
  untClasses in 'untClasses.pas';

var
  App : THorse;
  Users: TJSONArray;

begin
  CoInitialize(nil);
  App := THorse.Create(9000);

  App.Use(Jhonson);

  Users :=  TJSONArray.Create;

  App.Get('/users',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LocJson: TStringlist;
      LocParametro: String;
    begin
        LocParametro :=  Req.Headers['Nome'];  //Pegando a vari?vel para busca do nome
        LocJson := TStringlist.Create;
        LocJson := BuscarUsuarioNome(LocParametro);
        Res.Send(LocJson.Text);
    end);

  App.Start;
end.
