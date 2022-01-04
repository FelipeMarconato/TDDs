Create Procedure [UTS_CAD.p_alterar_produtor_comercial].[teste alterar]
as

Begin

	Declare
	@id_produtor				int                 = 1,                    
	@nm_fantasia				varchar(300)	    = 'batman',
	@id_pessoa					int				    = 1,
	@cd_produtor				varchar(100)	    = 1,
	@id_pessoa_parceiro			int				    = 1,
	@id_pessoa_produtor_pai		int				    = 1,
	@nm_cargo					varchar(300)	    = 'Heroi',
	@cd_produto 				int				    = 1,
	@vl_comercializacao			numeric(19,2)	    = 1000.00,
	@dv_produtor 				bit				    = 1,
	@cd_filial					int				    = 1,
	@dv_inibe_lmi				bit				    = 0,
	@dv_diluicao_oficina		bit				    = 0,
	@cd_tp_comissao				int				    = 1,
	@vl_minimo_parcela			numeric(19,2)	    = 100.00,
	@pe_comercializacao			numeric(19,2)	    = 10.00,
	@nr_maximo_parcela			int				    = 12,
	@id_tp_corretor				int				    = 1,
	---VARIÁVEIS DE RETORNO PADRÃO---
	@cd_retorno					int			,
	@nm_retorno					Varchar(255),
	@nr_versao_proc				varchar(15)	

	/* Preparação para Afirmação */
	Exec tsqlt.faketable @tablename = 'cad.t_pessoas_produtor'

	Insert into cad.t_pessoas_produtor
	(
		id_produtor				,				
		nm_fantasia				,
		id_pessoa				,
		cd_produtor				,
		id_pessoa_parceiro		,
		id_pessoa_produtor_pai	,
		nm_cargo				,
		cd_produto 				,
		vl_comercializacao		,
		dv_produtor 			,
		cd_filial				,
		dv_inibe_lmi			,
		dv_diluicao_oficina		,
		cd_tp_comissao			,
		vl_minimo_parcela		,
		pe_comercializacao		,
		nr_maximo_parcela		,
		id_tp_corretor					
	)
	Values
	(
		@id_produtor				,
		@nm_fantasia				,
		@id_pessoa					,
		@cd_produtor				,
		@id_pessoa_parceiro			,
		@id_pessoa_produtor_pai		,
		@nm_cargo					,
		@cd_produto 				,
		@vl_comercializacao			,
		@dv_produtor 				,
		@cd_filial					,
		@dv_inibe_lmi				,
		@dv_diluicao_oficina		,
		@cd_tp_comissao				,
		@vl_minimo_parcela			,
		@pe_comercializacao			,
		@nr_maximo_parcela			,
		@id_tp_corretor				
	)

	Create Table uts_cad.t_pessoas_produtor
	(
		id_produtor				int              ,				
		nm_fantasia				varchar(300)	 ,
		id_pessoa				int				 ,
		cd_produtor				varchar(100)	 ,
		id_pessoa_parceiro		int				 ,
		id_pessoa_produtor_pai	int				 ,
		nm_cargo				varchar(300)	 ,
		cd_produto 				int				 ,
		vl_comercializacao		numeric(19,2)	 ,
		dv_produtor 			bit				 ,
		cd_filial				int				 ,
		dv_inibe_lmi			bit				 ,
		dv_diluicao_oficina		bit				 ,
		cd_tp_comissao			int				 ,
		vl_minimo_parcela		numeric(19,2)	 ,
		pe_comercializacao		numeric(19,2)	 ,
		nr_maximo_parcela		int				 ,
		id_tp_corretor			int				 
	)

	insert into uts_cad.t_pessoas_produtor
		(
		id_produtor				,				
		nm_fantasia				,
		id_pessoa				,
		cd_produtor				,
		id_pessoa_parceiro		,
		id_pessoa_produtor_pai	,
		nm_cargo				,
		cd_produto 				,
		vl_comercializacao		,
		dv_produtor 			,
		cd_filial				,
		dv_inibe_lmi			,
		dv_diluicao_oficina		,
		cd_tp_comissao			,
		vl_minimo_parcela		,
		pe_comercializacao		,
		nr_maximo_parcela		,
		id_tp_corretor					
	)
	Values
	(
		@id_produtor				,
		@nm_fantasia				,
		@id_pessoa					,
		@cd_produtor				,
		@id_pessoa_parceiro			,
		@id_pessoa_produtor_pai		,
		@nm_cargo					,
		@cd_produto 				,
		@vl_comercializacao			,
		@dv_produtor 				,
		@cd_filial					,
		@dv_inibe_lmi				,
		@dv_diluicao_oficina		,
		@cd_tp_comissao				,
		@vl_minimo_parcela			,
		@pe_comercializacao			,
		@nr_maximo_parcela			,
		@id_tp_corretor				
	)

	/*Ação*/
	Exec [cad].[p_alterar_produtor_comercial]
	@id_produtor					= @id_produtor				,
	@nm_fantasia					= @nm_fantasia				,
	@id_pessoa						= @id_pessoa				,
	@cd_produtor					= @cd_produtor				,
	@id_pessoa_parceiro				= @id_pessoa_parceiro		,
	@id_pessoa_produtor_pai			= @id_pessoa_produtor_pai	,
	@nm_cargo						= @nm_cargo					,
	@cd_produto 					= @cd_produto 				,
	@vl_comercializacao				= @vl_comercializacao		,
	@dv_produtor 					= @dv_produtor 				,
	@cd_filial						= @cd_filial				,
	@dv_inibe_lmi					= @dv_inibe_lmi				,
	@dv_diluicao_oficina			= @dv_diluicao_oficina		,
	@cd_tp_comissao					= @cd_tp_comissao			,
	@vl_minimo_parcela				= @vl_minimo_parcela		,
	@pe_comercializacao				= @pe_comercializacao		,
	@nr_maximo_parcela				= @nr_maximo_parcela		,
	@id_tp_corretor					= @id_tp_corretor			,
	/*Retorno Padrão*/
	@cd_retorno						= @cd_retorno       output	,
	@nm_retorno						= @nm_retorno		output	,				
	@nr_versao_proc					= @nr_versao_proc 	output	

	/* Afirmação */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.t_pessoas_produtor','cad.t_pessoas_produtor'
	-- exec tsqlt.run '[UTS_CAD.p_alterar_produtor_comercial].[teste alterar]'
end