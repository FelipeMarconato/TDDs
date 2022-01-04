alter Procedure [UTS_CAD.p_insere_assessor_corretor].[test codigo erro 130001593] as

Begin 

	Declare
		@id_pessoa_assessor_corretor	int			  = 1,
		@id_pessoa_assessor				int			  = 1,														
		@id_pessoa						int			  = 1,
		@pe_percentual_participacao		numeric(19,3) = 1,
		@dt_inicio_assessoria			smalldatetime = null,
		@cd_usuario						varchar(100)  = 'admin',
		@cd_empresa						int			  = 1,
		@nr_versao_proc					varchar(15), 
		@cd_retorno						int,
		@nm_retorno						varchar(255)

	/*Preparação das Tabelas*/
	exec tsqlt.faketable @tablename = 'cad.t_pessoas'
	exec tsqlt.faketable @tablename = 'cad.t_pessoas_assessor_corretor'
	exec tsqlt.faketable @tablename = 'cad.t_pessoas_produto'

	Insert into cad.t_pessoas
	(
		id_pessoa
	)
	Values
	(
		@id_pessoa_assessor
	)

	insert into cad.t_pessoas_produto
	(
		id_pessoa,
		pe_participacao_assessoria
	)
	Values
	(
		@id_pessoa_assessor,
		@pe_percentual_participacao
	)

	insert into cad.t_pessoas_assessor_corretor
	(
		id_pessoa_corretor,
		dt_fim_validade
	)
	Values
	(
		@id_pessoa,
		null
	)

	/*Ação*/
	Exec [cad].[p_insere_assessor_corretor]
	---VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA---
	@id_pessoa_assessor_corretor = @id_pessoa_assessor_corretor,
	@id_pessoa_assessor			 = @id_pessoa_assessor,			
	@id_pessoa					 = @id_pessoa,				
	@cd_usuario					 = @cd_usuario,				
	@cd_empresa					 = @cd_empresa,
	--- RETORNO PADRÃO ---
	@cd_retorno					 = @cd_retorno      output,
	@nm_retorno					 = @nm_retorno		output,
	@nr_versao_proc				 = @nr_versao_proc 	output		

		/* Afirmação */
	EXEC tSQLt.AssertEquals 
		 @expected		=  130001593
		,@actual		=  @cd_retorno
		,@message		=  @nm_retorno

end

-- exec tsqlt.run'[UTS_CAD.p_insere_assessor_corretor].[test codigo erro 130001593]'