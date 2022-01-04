Create Procedure [UTS_CAD.p_cons_produtos_comerciais].[test consulta] as

Begin 

	Declare
		@where								VARCHAR(8000)	= '',
		@eng_filtropadrao					VARCHAR(2000)	= null,
		@orderby							VARCHAR(8000)	= '',
		@id_pessoa							int				= 1,
		@id_pessoa_corretor					int				= 1,
		@cd_produto							int				= 1,
		@cd_usuario							VARCHAR(50)     = 'admin',
		@cd_retorno							INT,			
		@nm_retorno							VARCHAR(8000),
		@nr_versao_proc						VARCHAR(15)	
		
	SET @where = 'id_pessoa='+convert(varchar(10),@id_pessoa)+
				 ' id_pessoa_corretor='+convert(varchar(10),@id_pessoa_corretor) +
				 ' cd_produto='+convert(varchar(10),@cd_produto)

	/*Preparação das Tabelas*/
	Exec tsqlt.FakeTable @tablename = 'cad.t_pessoas_produtor'
	Exec tsqlt.FakeTable @tablename = 'dbo.corp_produto'

	Create Table uts_cad.resultado
	(
		id_produtor				int,
		id_pessoa				int,
		id_pessoa_corretor		int,
		cd_produto				int,
		pe_comercializacao		numeric(19,3),
		vl_comercializacao		numeric(19,2),
		id_produtor_corretor	int,
		dv_selecionado			bit,
		dv_produtor				bit
	)

	Create table uts_cad.resultado_fake
	(
		id_produtor				int,
		id_pessoa				int,
		id_pessoa_corretor		int,
		cd_produto				int,
		pe_comercializacao		numeric(19,3),
		vl_comercializacao		numeric(19,2),
		id_produtor_corretor	int,
		dv_selecionado			bit,
		dv_produtor				bit
	)

	/*Populando as Tabelas*/
	
	Insert into cad.t_pessoas_produtor
	(
		id_produtor,
		id_pessoa,
		cd_produto,
		pe_comercializacao,
		vl_comercializacao,
		dv_produtor
	)
	Values
	(
		1,
		@id_pessoa,
		@cd_produto,
		10.00,
		150.00,
		1
	)

	Insert into dbo.corp_produto
	(
		cd_produto
	)
	Values
	(
		@cd_produto
	)

	insert into uts_cad.resultado_fake
	(
		id_produtor,		
		id_pessoa,			
		id_pessoa_corretor,	
		cd_produto,			
		pe_comercializacao,	
		vl_comercializacao,	
		id_produtor_corretor,
		dv_selecionado,
		dv_produtor
	)
	Values
	(
		1,
		@id_pessoa,
		@id_pessoa_corretor,
		@cd_produto,
		10.00,
		150.00,
		null,
		0,
		1
	)

	/*Ação*/
	insert into uts_cad.resultado
	Exec [cad].[p_cons_produtos_comerciais]
	@where					= @where,					
	@eng_filtropadrao		= @eng_filtropadrao,		
	@orderby				= @orderby,
	@cd_retorno				= @cd_retorno		output,
	@nm_retorno				= @nm_retorno		output,	
	@nr_versao_proc			= @nr_versao_proc	output	

	/*Afirmação*/
	EXEC tSQLt.AssertEqualsTable 'uts_cad.resultado_fake','uts_cad.resultado'

	
End

--- Exec tsqlt.run '[UTS_CAD.p_cons_produtos_comerciais].[test consulta]'
