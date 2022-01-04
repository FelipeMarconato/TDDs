Create Procedure [UTS_CAD.p_alterar_profissao].[test alterar] as

Begin 

	Declare 
		@cd_profissao				varchar(40)     = 1,
		@nm_profissao				varchar(100)	= 'dev',
		@dv_ativo					bit				= 1,
		@dt_fim_vigencia			smalldatetime	= '20200101',
		@cd_profissao_bcp			varchar(20)		= 1,
		@cd_empresa					int				= 130,
		@cd_usuario					varchar(50)		= 'ADMIN',
		@cd_retorno					int				= null,
		@nm_retorno					varchar(255)	= null,
		@nr_versao_proc				varchar(15)		= null


	/*Preparando Tabelas*/
	Exec tsqlt.FakeTable @tableName = 'dbo.corp_tp_profissao'

	insert into dbo.corp_tp_profissao
	(
		cd_profissao,
		nm_profissao,
		dv_ativo,
		dt_fim_vigencia,
		cd_profissao_bcp
	)
	values
	(
		@cd_profissao,
		@nm_profissao,
		@dv_ativo,
		@dt_fim_vigencia,
		@cd_profissao_bcp
	)

	Create Table uts_cad.resultado_alterar_profissao
	(
		cd_profissao			varchar(40),
		nm_profissao			varchar(40),
		dv_ativo				bit,
		dt_fim_vigencia			smalldatetime,
		cd_profissao_bcp		varchar(40)
	)

	Insert into uts_cad.resultado_alterar_profissao
	(
		cd_profissao,
		nm_profissao,
		dv_ativo,
		dt_fim_vigencia,
		cd_profissao_bcp
	)
	values
	(
		@cd_profissao,
		@nm_profissao,
		@dv_ativo,
		@dt_fim_vigencia,
		@cd_profissao_bcp
	)

	exec [cad].[p_alterar_profissao]
	@cd_profissao		= @cd_profissao,	
	@nm_profissao		= @nm_profissao,		
	@dv_ativo			= @dv_ativo,		
	@dt_fim_vigencia	= @dt_fim_vigencia,	
	@cd_profissao_bcp	= @cd_profissao_bcp,
	@cd_empresa			= @cd_empresa,			
	@cd_usuario			= @cd_usuario,			
	@cd_retorno			= @cd_retorno		output,			
	@nm_retorno			= @nm_retorno		output,	
	@nr_versao_proc		= @nr_versao_proc	output	

	/*Afirmação*/
	EXEC tSQLt.AssertEqualsTable 'uts_cad.resultado_alterar_profissao', 'dbo.corp_tp_profissao'

end

--- exec tsqlt.run '[UTS_CAD.p_alterar_profissao].[test alterar]'