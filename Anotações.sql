Delimiter $

Create Procedure BuscaVendas()
Begin

	Select  IdVenda, DadosCliente,
			ValorTotal, DescontoProduto/Total, Impostos,
			NumeroNF, ChaveXML, ProtocoloNF,
			NomeProduto, NCM, GrupoProduto
	From OrcamentoBalcao O
	Inner Join ItemOrcamentoBalcao I
	On O.IdCliente = I.Id_Cliente
	Inner Join ParcelaOrcamentoBalcao P
	On O.IdCliente = P.Id_Cliente;

End
$

Delimiter ;

Call BuscaVendas();

Dorp Procedure BuscaVendas;


SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE;


