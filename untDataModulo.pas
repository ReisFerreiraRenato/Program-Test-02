unit untDataModulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModuloPrincipal = class(TDataModule)
    ConexaoPrincipal: TADOConnection;
    qryBuscaCliente: TADOQuery;
    qryContatos: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuloPrincipal: TDataModuloPrincipal;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
