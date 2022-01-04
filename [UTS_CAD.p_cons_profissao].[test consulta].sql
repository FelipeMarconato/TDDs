Create Procedure [UTS_CAD.p_cons_profissao].[test consulta] as

Begin

	Declare
		@cd_profissao						varchar(40) = '1',
		@where								varchar(8000) = '',	
		@orderby							varchar(8000) = '',
		@cd_empresa							int			  = 1,
		@cd_usuario							varchar(50)   = 'admin',
		@cd_retorno							int,			
		@nm_retorno							varchar(8000),	
		@nr_versao_proc						varchar(15)		

	set @where = 'cd_profissao='+convert(varchar(40),@cd_profissao)

	/*Preparando tabelas*/
	exec tsqlt.FakeTable @tablename = 'dbo.corp_tp_profissao'

	create table uts_cad.resultado_profissao
	(
		cd_profissao			int,
		cd_profissao_mostra		int,
		nm_profissao			varchar(30),
		dt_fim_vigencia			smalldatetime,
		dv_tipo_ocupacao		varchar(2),
		dv_ativo				bit,
		nr_chave_externa		varchar(30),
		cd_profissao_bcp		int,
		cd_empresa				int
	)

	create table uts_cad.resultado_profissao_fake
	(
		cd_profissao			int,
		cd_profissao_mostra		int,
		nm_profissao			varchar(30),
		dt_fim_vigencia			smalldatetime,
		dv_tipo_ocupacao		varchar(2),
		dv_ativo				bit,
		nr_chave_externa		varchar(30),
		cd_profissao_bcp		int,
		cd_empresa				int
	)


	insert into dbo.corp_tp_profissao
	(
		cd_profissao,
		nm_profissao,
		dt_fim_vigencia,
		dv_tipo_ocupacao,
		dv_ativo,
		nr_chave_externa,
		cd_profissao_bcp
	)
	Values
	(
		@cd_profissao,
		'Dev',
		'20200101',
		'1',
		1,
		null,
		null
	)

	insert into uts_cad.resultado_profissao
	(
		cd_profissao,		
		cd_profissao_mostra	,
		nm_profissao,		
		dt_fim_vigencia	,	
		dv_tipo_ocupacao,	
		dv_ativo	,		
		nr_chave_externa,	
		cd_profissao_bcp,	
		cd_empresa			
	)
	values
	(
		@cd_profissao,
		@cd_profissao,
		'dev',
		'20200101',
		'1',
		1,
		null,
		null,
		null
	)

	/*AÇÂO*/
	Insert into uts_cad.resultado_profissao_fake
	Exec [cad].[p_cons_profissao]
	---VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA---
	@where			= @where,			
	@orderby		= @orderby,
	---VARIÁVEIS DE RETORNO PADRÃO---
	@cd_retorno     = @cd_retorno		output,
	@nm_retorno		= @nm_retorno		output,				
	@nr_versao_proc = @nr_versao_proc 	output		

	/* Afirmação */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.resultado_profissao','uts_cad.resultado_profissao_fake'

end

--- exec tsqlt.run '[UTS_CAD.p_cons_profissao].[test consulta]'