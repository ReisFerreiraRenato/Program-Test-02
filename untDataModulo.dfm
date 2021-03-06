object DataModuloPrincipal: TDataModuloPrincipal
  OldCreateOrder = False
  Height = 299
  Width = 401
  object ConexaoPrincipal: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=TESTE;Data Source=DESKTOP-J' +
      'LGHN2M;Initial File Name="";Server SPN=""'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 64
    Top = 72
  end
  object qryBuscaCliente: TADOQuery
    Connection = ConexaoPrincipal
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'prmNome'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 8000
        Value = Null
      end>
    SQL.Strings = (
      'SELECT TOP 20 * FROM Cliente WHERE Nome LIKE :prmNome')
    Left = 64
    Top = 144
  end
  object qryContatos: TADOQuery
    Connection = ConexaoPrincipal
    Parameters = <
      item
        Name = 'prmIDCLiente'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
      end>
    SQL.Strings = (
      'SELECT * FROM Contato WHERE ID_CLIENTE = :prmIDCLiente')
    Left = 64
    Top = 208
  end
end
