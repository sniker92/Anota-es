IF OBJECT_ID ('DBA.procVenda') IS NOT NULL //VERIFICA SE EXISTE PROC
	DROP PROCEDURE DBA.procVenda //DELETA PROC EXISTENTE SE TIVER
GO //DELIMITER

create procedure DBA.procVenda(in pCodempresa varchar(20),in pDataInicial DATETIME,in pDataFinal DATETIME,in pCodConfirmacaoNegocio integer default null,in pSomenteDevolucao varchar(1) default 'N') //CRIAÇÃO DE PROC COM PARÂMETROS
BEGIN //INÍCIO
  declare local temporary table Dados( //DECLARA LOCAL TEMPORÁRIO ONDE DADOS UTILIZADOS SERÃO ARMAZENADOS (TABELA TEMPORÁRIA)
    Codempresa varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodOrcamento integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodConfirmacaoNegocio integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NumeroContratoVenda varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    TipoOperacaoFiscal varchar(3) null default 'OU', //DECLARAÇÃO DE DADO COM SEU TIPO
    ChaveNFe varchar(46) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NumeroNF integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    Origem varchar(3) null default 'OB', //DECLARAÇÃO DE DADO COM SEU TIPO
    CFOP integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    Data datetime null, //DECLARAÇÃO DE DADO COM SEU TIPO
    UFDestino varchar(2) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodMunicipio integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    ForadoEstado varchar(1) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    TemNotaFiscal varchar(1) null default 'N', //DECLARAÇÃO DE DADO COM SEU TIPO
    DataAprovacao dateTime null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NfeNumeroProtocolo varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NfeNumeroProtocoloCancelamento varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NfePosicaoFinal varchar(60) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    TipoMovimentoFiscal varchar(2) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeTipoMovimentoFiscal varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    FinalidadeNFE integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeFinalidadeNFE varchar(30) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    Aprovado varchar(20) null default 'N', //DECLARAÇÃO DE DADO COM SEU TIPO
    Status varchar(3) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodTipoOperacaoSaida integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeTipoOperacaoSaida varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CalculaImposto varchar(1) null default 'N', //DECLARAÇÃO DE DADO COM SEU TIPO
    GrupoLucroReal varchar(3) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CalculaLucroReal varchar(1) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeOperacaoFiscal varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    OpGeraFinanceiro varchar(2) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    OpMovimentaEstoque varchar(2) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodVendedor integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeVendedor varchar(60) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodCliente integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeCliente varchar(200) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodProduto varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeProduto varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    Quantidade numeric(19,5) null DEFAULT 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorUnitario numeric(19,10) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorTotal numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorTotalNfe numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorNfePorContrato numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodTransportadora integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeTransportadora varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    PlacaTransportadora varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    UFPlacaTransportadora varchar(2) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorFrete numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    BaseICMS numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorICM numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    AliquotaICMS numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorICMS_SUBSTITUTO numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    AliquotaICMS_SUBSTITUTO numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    BaseICMS_SUBSTITUTO numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorFacs numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorFethab numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorSenar numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorFunrural numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodSimuladorLucroReal integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodConfirmacaoNegocioCompra integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodLiberacaoEmbarque integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodLocalArmazenagemEmbarque integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodLocalArmazenagemEmbarqueCtrCompra integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeLocalArmazenagemEmbarque varchar(100) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeConfirmacaoNegocioCompra varchar(100) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorTotalFrete numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodCstPis integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodCstCofins integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodCSTICMS varchar(4) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    BasePis numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    BaseCofins numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorPis numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorCofins numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    AliquotaPis numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    AliquotaCofins numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeUsuario varchar(50) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    ValorContrato numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    QuantidadeContrato numeric(19,5) null default 0, //DECLARAÇÃO DE DADO COM SEU TIPO
    PlacaVeiculoTransporte varchar(20) null, //DECLARAÇÃO DE DADO COM SEU TIPO
    TemCCe varchar(1) null default 'N', //DECLARAÇÃO DE DADO COM SEU TIPO
    NomeTemCCe varchar(1) null default null, //DECLARAÇÃO DE DADO COM SEU TIPO
    CodOrcamentoReferenciado integer null, //DECLARAÇÃO DE DADO COM SEU TIPO
    ) on commit delete rows; //FINALIZA DECLARAÇÃO DOS DADOS 
  declare vListaGrupoLucroReal varchar(100);
  if pSomenteDevolucao = 'S' then
    set vListaGrupoLucroReal='DE'
  else
    select list(GrupoLucroReal) into vListaGrupoLucroReal from TipoOperacaoSaida
  end if;
  if pDataInicial is null then
    set pDataInicial='2000-01-01'
  end if;
  if pDataFinal is null then
    set pDataFinal='2099-12-31'
  end if;
  if pCodConfirmacaoNegocio is not null then
    insert into Dados with auto name
      select O.CodEmpresa,
        O.CodOrcamento,
        (case when O.DataAprovacaoNFe is not null then O.DataAprovacaoNFe
        else O.DataDigitacao
        end) as Data,
        O.DataAprovacaoNFE as DataAprovacao,
        O.NfeNumeroProtocolo,
        O.CodLiberacaoEmbarque,
        O.TextoLivre1 as NumeroContratoVenda,
        O.NfeNumeroProtocoloCancelamento,
        O.NumeroNF as NumeroNF,
        O.NfePosicaoFinal,
        O.VendaEfetuada as Status,
        O.CodTipoOperacaoSaida,
        O.CodVendedor,
        O.CodCliente,
        O.PesquisaPadraoIntegerLivre1 as CodConfirmacaoNegocio,
        isnull(V.CodConfirmacaoNegocioCompra,O.PesquisaPadraoIntegerLivre2) as CodConfirmacaoNegocioCompra,
        I.BasePIS,
        I.BaseCOFINS,
        I.ValorPIS,
        I.ValorCOFINS,
        I.CodCSTPIS,
        I.CodCSTCOFINS,
        I.SituacaoTributaria as CodCSTICMS,
        I.AliquotaPIS,
        I.AliquotaCOFINS,
        I.CodProduto,
        I.CodFiscal as CFOP,
        isnull(v.Quantidade,I.Quantidade) as Quantidade,
        I.PrecoUnitario as ValorUnitario,
        (O.ValorFrete+O.ValorTotalBruto+O.ValorAcrescimoCliente-O.ValorDesconto) as ValorTotalNFe,
        I.NomeProduto,
        O.ChaveNFe,
        T.Descricao as NomeTipoOperacaoSaida,
        T.Descricao as NomeOperacaoFiscal,
        T.GeraFinanceiro as OpGeraFinanceiro,
        T.MovimentaEstoque as OpMovimentaEstoque,
        (case when NumeroNF is not null and O.NfeNumeroProtocoloCancelamento is null then 'A' when O.NfeNumeroProtocoloCancelamento is not null then 'C' else 'N'
        end) as TemNotaFiscal,T.TipoMovimento as TipoMovimentoFiscal,
        (case when T.TipoMovimento = 'E' then 'ENTRADA' else '*SAÍDA' end) as NomeTipoMovimentoFiscal,
        T.FinalidadeNFE,
        (case when T.FinalidadeNFE = 2 then '2-COMPLENTAR'
        when T.FinalidadeNFE = 3 then '3-AJUSTE'
        when T.FinalidadeNFE = 4 then '4-DEVOLUÇÃO' else '1-NORMAL'
        end) as NomeFinalidadeNFE,T.GrupoLucroReal,
        T.CalculaLucroReal,
        O.CodTransportadora,
        O.PlacaVeiculoTransporte as PlacaTransportadora,
        O.UFPlacaVeiculoTransporte as UFPlacaTransportadora,
        I.BaseICMS,
        I.ValorICM,
        I.AliquotaICMS,
        I.ValorICMS_SUBSTITUTO,
        I.AliquotaICMS_SUBSTITUTO,
        I.BaseICMS_SUBSTITUTO,
        (isnull(v.Quantidade,I.Quantidade)*I.PrecoUnitario) as ValorTotal from
        OrcamentoBalcao as O key join
        ItemOrcamentoBalcao as I join
        TipoOperacaoSaida as T on(T.CodTipoOperacaoSaida = O.CodTipoOperacaoSaida) left outer join
        OrcamentoBalcaoCNVinculadaVenda as V on(v.CodEmpresa = i.CodEmpresa and v.CodOrcamento = i.CodOrcamento and V.Quantidade <> 0 and V.Status = 'S') where
        O.CodEmpresa = pCodEmpresa and
        Data between pDataInicial and pDataFinal and
        O.VendaEfetuada <> 'N' and O.PesquisaPadraoIntegerLivre1 = pCodConfirmacaoNegocio
  else
    insert into Dados with auto name
      select O.CodEmpresa,
        O.CodOrcamento,
        (case when O.DataAprovacaoNFe is not null then O.DataAprovacaoNFe
        else O.DataDigitacao
        end) as Data,
        O.DataAprovacaoNFE as DataAprovacao,
        O.NfeNumeroProtocolo,
        O.CodLiberacaoEmbarque,
        O.TextoLivre1 as NumeroContratoVenda,
        O.NfeNumeroProtocoloCancelamento,
        O.NumeroNF as NumeroNF,
        O.NfePosicaoFinal,
        O.VendaEfetuada as Status,
        O.CodTipoOperacaoSaida,
        O.CodVendedor,
        O.CodCliente,
        O.PesquisaPadraoIntegerLivre1 as CodConfirmacaoNegocio,
        isnull(V.CodConfirmacaoNegocioCompra,O.PesquisaPadraoIntegerLivre2) as CodConfirmacaoNegocioCompra,
        I.BasePIS,
        I.BaseCOFINS,
        I.ValorPIS,
        I.ValorCOFINS,
        I.CodCSTPIS,
        I.CodCSTCOFINS,
        I.SituacaoTributaria as CodCSTICMS,
        I.AliquotaPIS,
        I.AliquotaCOFINS,
        I.CodProduto,
        I.CodFiscal as CFOP,
        isnull(v.Quantidade,I.Quantidade) as Quantidade,
        I.PrecoUnitario as ValorUnitario,
        (O.ValorFrete+O.ValorTotalBruto+O.ValorAcrescimoCliente-O.ValorDesconto) as ValorTotalNFe,
        I.NomeProduto,
        O.ChaveNFe,
        T.Descricao as NomeTipoOperacaoSaida,
        T.Descricao as NomeOperacaoFiscal,
        T.GeraFinanceiro as OpGeraFinanceiro,
        T.MovimentaEstoque as OpMovimentaEstoque,
        (case when NumeroNF is not null and O.NfeNumeroProtocoloCancelamento is null then 'A' when O.NfeNumeroProtocoloCancelamento is not null then 'C' else 'N'
        end) as TemNotaFiscal,T.TipoMovimento as TipoMovimentoFiscal,
        (case when T.TipoMovimento = 'E' then 'ENTRADA' else '*SAÍDA' end) as NomeTipoMovimentoFiscal,
        T.FinalidadeNFE,
        (case when T.FinalidadeNFE = 2 then '2-COMPLENTAR'
        when T.FinalidadeNFE = 3 then '3-AJUSTE'
        when T.FinalidadeNFE = 4 then '4-DEVOLUÇÃO' else '1-NORMAL'
        end) as NomeFinalidadeNFE,T.GrupoLucroReal,
        T.CalculaLucroReal,
        O.CodTransportadora,
        O.PlacaVeiculoTransporte as PlacaTransportadora,
        O.UFPlacaVeiculoTransporte as UFPlacaTransportadora,
        I.BaseICMS,
        I.ValorICM,
        I.AliquotaICMS,
        I.ValorICMS_SUBSTITUTO,
        I.AliquotaICMS_SUBSTITUTO,
        I.BaseICMS_SUBSTITUTO,
        (isnull(v.Quantidade,I.Quantidade)*I.PrecoUnitario) as ValorTotal from
        OrcamentoBalcao as O key join
        ItemOrcamentoBalcao as I join
        TipoOperacaoSaida as T on(T.CodTipoOperacaoSaida = O.CodTipoOperacaoSaida) left outer join
        OrcamentoBalcaoCNVinculadaVenda as V on(v.CodEmpresa = i.CodEmpresa and v.CodOrcamento = i.CodOrcamento and V.Quantidade <> 0 and V.Status = 'S') where
        O.CodEmpresa = pCodEmpresa and
        Data between pDataInicial and pDataFinal and
        O.VendaEfetuada <> 'N'
  end if;
  if pSomenteDevolucao = 'S' then
    delete from Dados where GrupoLucroReal <> 'DE'
  end if;
  update Dados as d set NomeProduto = upper(NomeProduto);
  update Dados as D join Municipio as M on(M.CodMunicipio = D.CodMunicipio) set D.UFDestino = M.UF,D.ForaDoEstado = (case when M.UF <> 'MT' then 'S' else 'N' end);
  update Dados as D join Vendedor as V on(V.CodVendedor = D.CodVendedor) set D.NomeVendedor = V.Nome;
  update Dados as D join Cliente as C on(C.CodCliente = D.CodCliente) set D.NomeCliente = C.Nome;
  update Dados as D join LiberacaoEmbarque as L on(D.CodEmpresa = L.CodEmpresa and D.CodLiberacaoEmbarque = L.CodLiberacaoEmbarque) set D.CodTransportadora = L.CodTransportadora,D.ValorFrete = (case L.CodUnidadeMedida when 'KG' then L.ValorFrete*1000 else L.ValorFrete end),D.CodLocalArmazenagemEmbarque = L.CodLocalArmazenagemEmbarque;
  update Dados as D join Transportadora as T on(T.CodTransportadora = D.CodTransportadora) set D.NomeTransportadora = T.Nome;
  update Dados as D join LocalArmazenagem as L on(D.CodLocalArmazenagemEmbarque = L.CodLocalArmazenagem) set D.NomeLocalArmazenagemEmbarque = L.Nome;
  update Dados as D join ConfirmacaodeNegocio as C on D.CodEmpresa = C.CodEmpresa and D.CodConfirmacaoNegocioCompra = C.Codconfirmacaonegocio join dba.LocalArmazenagemConfirmacaoNegocio as LA on C.Codconfirmacaonegocio = LA.CodConfirmacaoNegocio and C.CodEmpresa = LA.CodEmpresa set D.NomeConfirmacaoNegocioCompra = C.Nome,D.QuantidadeContrato = C.Quantidade,D.ValorContrato = C.ValorTotalVendedor,D.CodLocalArmazenagemEmbarqueCtrCompra = LA.CodLocalArmazenagem;
  update Dados as D join LocalArmazenagemConfirmacaoNegocio as L on(D.CodEmpresa = L.CodEmpresa and D.CodConfirmacaoNegocio = l.CodConfirmacaoNegocio) set D.CodLocalArmazenagemEMbarque = L.CodLocalArmazenagem;
  update Dados as D set D.ValorFrete = 0 where D.ValorFrete = .01;
  update Dados as D set D.ValorTotalFrete = D.ValorFrete*(D.Quantidade/1000) where D.ValorFrete > .01;
  update Dados as D set Quantidade = Quantidade*-1,ValorTotal = ValorTotal*-1 where cfop like '1%';
  update Dados as D set Quantidade = Quantidade*-1,ValorTotal = ValorTotal*-1 where cfop like '2%';
  update Dados set ValorTotalFrete = ValorTotalFrete*-1 where FinalidadeNFE = 4;
  update Dados set CodConfirmacaoNegocioCompra = CodConfirmacaoNegocio where GrupoLucroReal = 'DC';
  update Dados set Quantidade = 0 where Quantidade = 1 and CodConfirmacaoNegocio is not null;
  update Dados set Aprovado = 'S' where NumeroNF > 0;
  update Dados set NomeUsuario = getNomeUsuario(*);
  select Codempresa,CodOrcamento,CodOrigem,Origem,cast(null as varchar(20)) as NumeroNFOrigem into #NFReferenciada from OrcamentoBalcaoReferenciado;
  update #NFReferenciada as N join OrcamentoBalcao as D on N.CodEmpresa = D.CodEmpresa and N.CodOrigem = D.CodOrcamento and N.Origem = 'OB' set N.NumeroNFOrigem = D.NumeroNF;
  update #NFReferenciada as N join EntradaProduto as D on N.CodEmpresa = D.CodEmpresa and N.CodOrigem = D.CodEntradaProduto and N.Origem = 'EP' set N.NumeroNFOrigem = D.NumeroNF;
  update Dados as D join #NFReferenciada as N on D.Codempresa = N.CodEmpresa and D.CodOrcamento = N.CodOrcamento set D.NomeTipoOperacaoSaida = '[REF:' || N.NumeroNFOrigem || ']' || NomeTipoOperacaoSaida;
  select CodOrcamento,count(CodOrcamento) as Count into #Dados2 from Dados group by CodOrcamento;
  update Dados as D1 join #Dados2 as D2 on D1.CodOrcamento = D2.CodOrcamento set D1.ValorNFePorContrato = D1.ValorTotalNFe/D2.Count;
  select CodOrcamento,NumeroContratoVenda,min(CodConfirmacaoNegocioCompra) as CodConfirmacaoNegocioCompra into #Dup from Dados group by CodOrcamento,NumeroContratoVenda having count(CodOrcamento) > 1;
  update Dados as D join #Dup as D2 on D.CodOrcamento = D2.CodOrcamento and D.NumeroContratoVenda = D2.NumeroContratoVenda and D.CodConfirmacaoNegocioCompra <> D2.CodConfirmacaoNegocioCompra set BaseICMS = 0,ValorICM = 0,AliquotaICMS = 0;
  update DADOS as D join TipoOperacaoSaida as t on D.CodTipoOperacaoSaida = T.CodTipoOperacaoSaida set Quantidade = 0 where t.FinalidadeNFe = 2 and t.Complemento = 'V';
  update DADOS as D join TipoOperacaoSaida as t on D.CodTipoOperacaoSaida = T.CodTipoOperacaoSaida set ValorTotal = 0 where t.FinalidadeNFe = 2 and t.Complemento = 'Q';
  select * from Dados
  SELECT
end
GO

