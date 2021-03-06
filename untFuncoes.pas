unit untFuncoes;

interface

uses System.JSON, Data.DB, Data.Win.ADODB, System.SysUtils, vcl.StdCtrls, ActiveX,System.Classes;

  function BuscarUsuarioNome(prmNome: String): TStringlist;

  function MontarQuery(var prmQuery: TADOQuery; LocScript: String): Boolean;

  function RemoverAcentos(prmString: String): String;    //N?o deu tempo buscar uma solu??o
                                                         //para retornar-los com os acentos
implementation

uses untDataModulo, untClasses, Rest.Json;

function BuscarUsuarioNome(prmNome: String): TStringlist;
var
  LocScript: String;
  LocObjCliente: TCliente;
  LocArrayClientes: array of TCliente;
  LocContato: TContato;
  LocQuery: TADOQuery;
  LocContador: Integer;
  LocJson : TStringlist;
  DataModulo : TDataModuloPrincipal;
  LocObjetoJson: TJSONObject;
begin
  try
    CoInitialize(nil);

    DataModulo := TDataModuloPrincipal.Create(nil);

    DataModulo.qryBuscaCliente.Close;
    DataModulo.qryBuscaCliente.Parameters.ParamByName('prmNome').Value := '%'+prmNome+'%';
    DataModulo.qryBuscaCliente.Open;

    with DataModulo do
    begin
      if qryBuscaCliente.RecordCount > 0 then
      begin
        qryBuscaCliente.First;
        while not qryBuscaCliente.Eof do
        begin
          LocObjCliente := TCliente.Create;
          LocObjCliente.ID          := qryBuscaCliente.FieldByName('ID').Value;
          LocObjCliente.Nome        := RemoverAcentos(qryBuscaCliente.FieldByName('Nome').AsString);
          LocObjCliente.CEP         := qryBuscaCliente.FieldByName('CEP').Value;
          LocObjCliente.Logradouro  := qryBuscaCliente.FieldByName('Logradouro').Value;
          LocObjCliente.Numero      := qryBuscaCliente.FieldByName('Numero').Value;
          if not (qryBuscaCliente.FieldByName('Complemento').AsString = '') then
            LocObjCliente.Complemento := qryBuscaCliente.FieldByName('Complemento').Value;
          LocObjCliente.Cidade      := qryBuscaCliente.FieldByName('Cidade').Value;
          LocObjCliente.Sigla_UF    := qryBuscaCliente.FieldByName('Sigla_UF').Value;
          LocObjCliente.IBGE_Cidade := qryBuscaCliente.FieldByName('IBGE_Cidade').Value;
          LocObjCliente.IBGE_UF     := qryBuscaCliente.FieldByName('IBGE_UF').Value;

          qryContatos.Close;
          qryContatos.Parameters.ParamByName('prmIDCliente').Value := LocObjCliente.ID;
          qryContatos.Open;

          if qryContatos.RecordCount > 0 then
          begin
            qryContatos.First;
            while not qryContatos.Eof do
            begin
              LocContato           := TContato.Create(LocObjCliente.ID);
              LocContato.ID        := qryContatos.FieldByName('ID').AsInteger;
              LocContato.Nome      := RemoverAcentos(qryContatos.FieldByName('Nome').AsString);
              LocContato.Data_Nasc := qryContatos.FieldByName('Data_Nasc').Value;
              LocContato.Idade     := qryContatos.FieldByName('Idade').Value;
              LocContato.Telefone  := qryContatos.FieldByName('Telefone').Value;

              LocObjCliente.InserirContato(LocContato);
              qryContatos.Next;
            end;
          end;
          SetLength(LocArrayClientes, Length(LocArrayClientes)+1);
          LocArrayClientes[Length(LocArrayClientes)-1]:= LocObjCliente;
          qryBuscaCliente.Next;
        end;

        LocJson := TStringlist.Create;
        for LocContador := 0 to Length(LocArrayClientes)-1 do
        begin
          LocJson.Text := LocJson.Text + UTF8Decode((TJson.ObjectToJsonString( LocArrayClientes[LocContador])));
        end;

        Result := LocJson;
      end
      else
        Result:= nil;
    end;

  finally
    if Assigned(DataModulo) then
      FreeAndNil(DataModulo);
  end;

end;


//Fun??o para montar query
function MontarQuery(var prmQuery: TADOQuery; LocScript: String): Boolean;
begin
  try
    if LocScript = '' then
      Exit;

    prmQuery := TADOQuery.Create(nil);
    prmQuery.Connection := DataModuloPrincipal.ConexaoPrincipal;
    prmQuery.SQL.Clear;
    prmQuery.SQL.Add(LocScript);
    prmQuery.Open;
    Result := True;
  except
    result := False;
  end;
end;

function RemoverAcentos(prmString: String): String;
var
  LocString: String;
begin
  LocString := prmString.Replace('?','a');
  LocString := LocString.Replace('?','a');
  LocString := LocString.Replace('?','a');
  LocString := LocString.Replace('?','a');
  LocString := LocString.Replace('?','a');
  LocString := LocString.Replace('?','e');
  LocString := LocString.Replace('?','e');
  LocString := LocString.Replace('?','e');
  LocString := LocString.Replace('?','i');
  LocString := LocString.Replace('?','i');
  LocString := LocString.Replace('?','i');
  LocString := LocString.Replace('?','i');
  LocString := LocString.Replace('?','o');
  LocString := LocString.Replace('?','o');
  LocString := LocString.Replace('?','o');
  LocString := LocString.Replace('?','o');
  LocString := LocString.Replace('?','o');
  LocString := LocString.Replace('?','u');
  LocString := LocString.Replace('?','u');
  LocString := LocString.Replace('?','u');
  LocString := LocString.Replace('?','u');
  LocString := LocString.Replace('?','c');
  Result := LocString;
end;

end.
