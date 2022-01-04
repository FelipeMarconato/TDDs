create Procedure [UTS_CAD.p_insere_assessor_corretor].[test codigo erro 130001592] as

Begin 

	Declare
		@id_pessoa_assessor_corretor	int			  = 1,
		@id_pessoa_assessor				int			  = 1,														
		@id_pessoa						int			  = 1,
		@pe_percentual_participacao		numeric(19,3) = 0,
		@dt_inicio_assessoria			smalldatetime = null,
		@cd_usuario						varchar(100)  = 'admin',
		@cd_empresa						int			  = 1,
		@nr_versao_proc					varchar(15), 
		@cd_retorno						int,
		@nm_retorno						varchar(255)

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
		 @expected		=  130001592
		,@actual		=  @cd_retorno
		,@message		=  @nm_retorno

end

-- exec tsqlt.run'[UTS_CAD.p_insere_assessor_corretor].[test codigo erro 130001592]'