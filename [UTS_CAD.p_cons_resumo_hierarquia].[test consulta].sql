alter Procedure [UTS_CAD.p_cons_resumo_hierarquia].[test consulta] as

Begin 

	Declare 
		@where				varchar(8000)	= '',
		@orderby			varchar(8000)	= '',
		@excel				bit				= 0,
		@id_pessoa_papel	int				= 1,	
		@cd_empresa			int				= 1,
		@cd_usuario			varchar(255)	= 'admin',
		@nr_versao_proc		varchar(15)		= null,
		@cd_retorno			int				= null,    
		@nm_retorno			varchar(512)	= null


	set @where = 'id_pessoa_papel='+convert(varchar(10),@id_pessoa_papel)

	/*Preparando tabelas*/
	Exec tsqlt.FakeTable @tablename = 'cad.t_cadastro_hierarquia'
	Exec tsqlt.FakeTable @tablename = 'cad.t_pessoas_papel'
	Exec tsqlt.FakeTable @tablename = 'cad.t_pessoas'
	Exec tSQLt.FakeTable @tablename = 'cad.t_papel'
	
	Create Table uts_cad.resultado
	(
			id_resumo_hierarquia			int,
			nm_pessoa						varchar(100),
			nm_papel						varchar(40),
			vl_recebido						numeric(19,2),
			id_pessoa_papel_indicada		int,
			id_chave_pai					int
	)

	Create Table uts_cad.resultado_fake
	(
			id_resumo_hierarquia			int,
			nm_pessoa						varchar(100),
			nm_papel						varchar(40),
			vl_recebido						numeric(19,2),
			id_pessoa_papel_indicada		int,
			id_chave_pai					int
	)

	if object_id('tempdb..#ordenacao','u') is not null
	Begin
		drop table #ordenacao
	end

	Create table #ordenacao
	(
		cd_papel int,
		ordenacao int
	)
	insert	into #ordenacao
	(
		ordenacao,
		cd_papel
	)
	values	(	1	,	1	),
			(	2	,	89	),	
			(	3	,	44	),	
			(	4	,	88	),	
			(	5	,	87	),	
			(	6	,	86	)

	insert into cad.t_cadastro_hierarquia
	(
		id_pessoa_papel,
		id_pessoa_papel_indicada
	)
	Values
	(
		@id_pessoa_papel,
		1
	)

	Insert into cad.t_pessoas_papel
	(
		id_pessoa_papel,
		cd_papel		
	)
	values
	(
		1,
		1
	)

	Insert into cad.t_pessoas
	(
		id_pessoa,
		nm_pessoa
	)
	values
	(
		1,
		'Cristiano Ronaldo'
	)

	insert into cad.t_papel
	(
		cd_papel,
		nm_papel
	)
	values
	(
		1,
		'Corretor'
	)

	Insert into uts_cad.resultado_fake
	(	
			id_resumo_hierarquia,			
			nm_pessoa,						
			nm_papel,						
			vl_recebido,						
			id_pessoa_papel_indicada,		
			id_chave_pai	
	)
	values
	(
		null,
		null,
		'corretor',
		null,
		@id_pessoa_papel,
		null
	)

	/*Ação*/
	insert into uts_cad.resultado
	Exec [cad].[p_cons_resumo_hierarquia]
	@where				= @where,			
	@orderby			= @orderby,		
	@excel				= @excel,			
	@cd_empresa			= @cd_empresa,		
	@cd_usuario			= @cd_usuario,		
	@nr_versao_proc		= @nr_versao_proc	output,
	@cd_retorno			= @cd_retorno		output,
	@nm_retorno			= @nm_retorno		output

	select * from uts_cad.resultado 
	select * from uts_cad.resultado_fake return

	/* Afirmação */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.resultado','uts_cad.resultado_fake'

end

-- exec tsqlt.run '[UTS_CAD.p_cons_resumo_hierarquia].[test consulta]'