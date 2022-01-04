Create Procedure [UTS_CAD.p_alterar_tp_produtos].[test alterar] as 

begin 

	Declare 
		---VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA--
		@id_produtor_corretor	int				= 1, 		
		@cd_produto		        int				= 1,
		@id_pessoa   		    int				= 1,
		@pe_comercializacao		numeric(9,3) 	= 12.00,
		@vl_comercializacao		numeric(19,2)	= 1200.00,
		@id_pessoa_corretor     int           	= 12,
		@dv_selecionado         bit           	= 1,
		@dv_produtor            bit           	= 1,
		---VARIÁVEIS DE RETORNO PADRÃO---
		@cd_retorno					int,					 
		@nm_retorno					Varchar(255),			 
		@nr_versao_proc				varchar(15)

		/*Preparando a Afirmação*/
		exec tsqlt.faketable @tablename = 'cad.t_pessoas_produtor_corretor'

		Insert into cad.t_pessoas_produtor_corretor
		(
			id_produtor_corretor,
			cd_produto,
			id_pessoa_produtor,
			pe_comercializacao,
			vl_comercializacao,
			id_pessoa_corretor
		)
		Values
		(
			@id_produtor_corretor,
			@cd_produto,
			@id_pessoa,
			@pe_comercializacao,
			@vl_comercializacao,
			@id_pessoa_corretor
		)

		Create table uts_cad.t_pessoas_produtor_corretor
		(
			id_produtor_corretor	int,
			vl_comercializacao		numeric(19,2),
			pe_comercializacao		numeric(9,3),
			id_pessoa_produtor		int,
			id_pessoa_corretor		int,
			cd_produto				int
		)

		Insert into uts_cad.t_pessoas_produtor_corretor
		(
			id_produtor_corretor,
			cd_produto,
			id_pessoa_produtor,
			pe_comercializacao,
			vl_comercializacao,
			id_pessoa_corretor
		)
		Values
		(
			@id_produtor_corretor,
			@cd_produto,
			@id_pessoa,
			@pe_comercializacao,
			@vl_comercializacao,
			@id_pessoa_corretor
		)

		/*Ação*/
		Exec[cad].[p_alterar_tp_produtos]
		@id_produtor_corretor =	@id_produtor_corretor,
		@cd_produto			  =	@cd_produto,
		@id_pessoa			  =	@id_pessoa,
		@pe_comercializacao	  =	@pe_comercializacao,
		@vl_comercializacao	  =	@vl_comercializacao,
		@id_pessoa_corretor   =	@id_pessoa_corretor,
		---VARIÁVEIS DE RETORNO PADRÃO---
		@cd_retorno		= @cd_retorno		output,		
		@nm_retorno		= @nm_retorno		output,
		@nr_versao_proc	= @nr_versao_proc   output

	/* Afirmação */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.t_pessoas_produtor_corretor','cad.t_pessoas_produtor_corretor'
	-- exec tsqlt.run '[UTS_CAD.p_alterar_tp_produtos].[test alterar]'
end