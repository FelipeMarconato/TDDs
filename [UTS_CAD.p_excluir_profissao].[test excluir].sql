Create Procedure [UTS_CAD.p_excluir_profissao].[test excluir] as

Begin

	Declare
		@cd_profissao				int				=	1,
		@cd_empresa					int				=	130,
		@cd_usuario					varchar(50)		=	'ADMIN',
		@cd_retorno					int				=	null,
		@nm_retorno					varchar(255)	=	null,
		@nr_versao_proc				varchar(15)		=	null


	/*Preparando Tabelas*/
	Exec tSQLt.FakeTable @tableName = 'dbo.corp_tp_profissao'

	Insert into dbo.corp_tp_profissao
	(
		cd_profissao
	)
	values 
	(
		@cd_profissao
	)

	/*ação*/
	Exec [cad].[p_excluir_profissao]
	@cd_profissao			= @cd_profissao,		
	@cd_empresa				= @cd_empresa,				
	@cd_usuario				= @cd_usuario,				
	@cd_retorno				= @cd_retorno		output,				
	@nm_retorno				= @nm_retorno		output,		
	@nr_versao_proc			= @nr_versao_proc	output		

	/*afirmação*/
	Exec tsqlt.AssertEmptyTable 'dbo.corp_tp_profissao'

end

--- exec tsqlt.run '[UTS_CAD.p_excluir_profissao].[test excluir]'