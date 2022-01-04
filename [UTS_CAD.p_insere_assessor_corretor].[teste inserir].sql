create Procedure [UTS_CAD.p_insere_assessor_corretor].[teste inserir] as

Begin 

	Declare
		@id_pessoa_assessor_corretor	int			  = 1,
		@id_pessoa_assessor				int			  = 1,														
		@id_pessoa						int			  = 1,
		@dt_movimento					smalldatetime = null,
		@dt_inicio_assessoria			smalldatetime = null,
		@cd_usuario						varchar(100)  = 'admin',
		@cd_empresa						int			  = 500,
		@nr_versao_proc					varchar(15), 
		@cd_retorno						int,
		@nm_retorno						varchar(255)

	/*Preparação das Tabelas*/
	EXEC tSQLt.FakeTable @tablename = 'cad.t_pessoas_assessor_corretor'

	alter table cad.t_pessoas_assessor_corretor
	drop column id_pessoa_assessor_corretor

	alter table cad.t_pessoas_assessor_corretor
	add id_pessoa_assessor_corretor int identity

	Create table uts_cad.t_pessoas_assessor_corretor_fake
	(
		id_pessoa_assessor_corretor	int,
		cd_usuario					varchar(200),
		dt_fim_validade				smalldatetime,
		id_pessoa_assessor			int,
		dt_log						smalldatetime,
		dt_inicio_assessoria		smalldatetime,
		dt_inicio_validade			smalldatetime,
		id_pessoa_corretor			int
	)

	insert into uts_cad.t_pessoas_assessor_corretor_fake
	(
		id_pessoa_assessor_corretor,
		cd_usuario,
		dt_fim_validade,
		id_pessoa_assessor,		
		dt_log,					
		dt_inicio_assessoria,	
		dt_inicio_validade,		
		id_pessoa_corretor		
	)
	values
	(
		@id_pessoa_assessor_corretor,
		@cd_usuario,
		null,
		@id_pessoa_assessor,
		getdate(),
		@dt_inicio_assessoria,
		@dt_movimento,
		@id_pessoa
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
	EXEC tSQLt.AssertEqualsTable 'uts_cad.t_pessoas_assessor_corretor_fake','cad.t_pessoas_assessor_corretor'

	--- EXEC TSQLT.RUN '[UTS_CAD.p_insere_assessor_corretor].[teste inserir]'

END

