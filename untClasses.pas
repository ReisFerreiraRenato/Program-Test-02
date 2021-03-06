unit untClasses;


interface

uses Classes, SysUtils, System.Generics.Collections;

type TContato = class
  private
    FID: Integer;
    FNome: String;
    FData_Nasc: TDateTime;
    FIdade: Integer;
    FTelefone: String;
    FIDCLiente: Integer;

  public
    //propriedades, acessíveis externamente
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Data_Nasc: TDateTime read FData_Nasc write FData_Nasc;
    property Idade: Integer read FIdade write FIdade;
    property Telefone: String read FTelefone write FTelefone;
    property IDCLiente: Integer read FIDCLiente write FIDCLiente;

    //Construtor e destrutor
     constructor Create(prmIdCliente: Integer);
     Destructor Destroy; override;
end;

type TCliente = class
  private
    //Atributos da classe
    FID: Integer;
    FNome: String;
    FCEP: String;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FCidade: String;
    FSigla_UF: String;
    FIBGE_Cidade: String;
    FIBGE_UF: String;
    FContatos: Array of TContato;

  public
    //propriedades, acessíveis externamente
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property CEP: String read FCEP write FCEP;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Cidade: String read FCidade write FCidade;
    property Sigla_UF: String read FSigla_UF write FSigla_UF;
    property IBGE_Cidade: String read FIBGE_Cidade write FIBGE_Cidade;
    property IBGE_UF: String read FIBGE_UF write FIBGE_UF;

    //Construtor e destrutor
    constructor Create;
    Destructor Destroy; override;

    procedure InserirContato(prmContato: TContato);
  end;

Type
  TListaCliente = class
  private
    { private declarations }
    FListaClientes : TObjectList<TCliente>;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    procedure Adicionar(pCliente: TCliente);
    function Buscar(prmIndice: Integer): TCliente;
    procedure Clear;
    function Count: Integer;
  published
    { published declarations }
  end;

implementation

{ Cliente }

uses untFuncoes;

constructor TCliente.Create;
begin
  ID           := 0;
  Nome         := '';
  CEP          := '';
  Logradouro   := '';
  Numero       := '';
  Complemento  := '';
  Cidade       := '';
  Sigla_UF     := '';
  IBGE_Cidade  := '';
  IBGE_UF      := '';
  FContatos    := nil;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

procedure TCliente.InserirContato(prmContato: TContato);
begin
  SetLength(FContatos, Length(FContatos)+1);
  FContatos[Length(FContatos)-1] := prmContato;
end;

{ Contato }

constructor TContato.Create(prmIdCliente: Integer);
begin
  IDCliente := prmIdCliente;
  Nome      := '';
  Data_Nasc := 0;
  Idade     := 0;
  Telefone  := '';
end;

destructor TContato.Destroy;
begin
  inherited;
end;

{ TListaCliente }

procedure TListaCliente.Adicionar(pCliente: TCliente);
begin
  FListaClientes.Add(pCliente);
end;

function TListaCliente.Buscar(prmIndice: Integer): TCliente;
begin
  Result := FListaClientes.Items[prmIndice];
end;

procedure TListaCliente.Clear;
begin
  FListaClientes.Clear;
end;

function TListaCliente.Count: Integer;
begin
  Result := FListaClientes.Count;
end;

constructor TListaCliente.Create;
begin
  inherited Create;
  FListaClientes := TObjectList<TCliente>.Create;
end;

end.
