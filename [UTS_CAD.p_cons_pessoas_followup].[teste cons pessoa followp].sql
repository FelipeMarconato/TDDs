Create procedure [UTS_CAD.p_cons_pessoas_followup].[teste cons pessoa followp] as

Begin

	Declare
	---VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA---
	@where					varchar(8000) = null,
	@orderby				varchar(8000) = '',
	@excel					bit			  = 0,
	@eng_filtropadrao		varchar(8000) = null,
	@eng_filtro				varchar(max)  = null,
	@id_pessoa				int = 1,
	@nm_email_destinatario	varchar(100) = 'i4pro@i4pro.com',
	@id_tp_followup			int = 1,
	@id_pessoa_papel		int = 0,
	@cd_papel				int = 0,
	@dt_followup			varchar(10) = '1/10/20',
	---VARIÁVEIS DE RETORNO PADRÃO---
	@cd_empresa				int = 1,
	@debug					bit	= null,
	@cd_usuario				varchar(50)	= 'admin',
	@cd_retorno				int,
	@nm_retorno				Varchar(max),
	@nr_versao_proc			varchar(15)		

	Set @where = 'cpf.id_pessoa='+convert(varchar(10),@id_pessoa) 

	--- Preparando tabelas ---
	EXEC tSQLt.FakeTable @tablename = 'cad.t_pessoas_followup'
	EXEC tSQLt.FakeTable @tablename = 'cad.t_pessoas'

	Create table uts_cad.p_cons_pessoas_followup
	(
		id_pessoa					int,
		id_followup					int,
		id_tp_followp				int,
		id_tp_followup_pesquisa		int,
		id_pessoa_papel				int,
		nm_tp_followup				varchar(30),
		id_pessoa_followup			int,
		ds_followup					varchar(50),
		dt_followup					smalldatetime,
		nm_email_destinatario		varchar(255),
		cd_usuario					varchar(50),
		cd_papel					varchar(5),
		cd_empresa					varchar(5),
		dv_regra111054				bit
	)

	Create table uts_cad.resultado
	(
		id_pessoa					int,
		id_followup					int,
		id_tp_followp				int,
		id_tp_followup_pesquisa		int,
		id_pessoa_papel				int,
		nm_tp_followup				varchar(30),
		id_pessoa_followup			int,
		ds_followup					varchar(50),
		dt_followup					smalldatetime,
		nm_email_destinatario		varchar(255),
		cd_usuario					varchar(50),
		cd_papel					varchar(5),
		cd_empresa					varchar(5),
		dv_regra111054				bit	
	)


	--- Popular Tabelas ---
	insert into cad.t_pessoas_followup
	(
		id_pessoa,
		id_followup,
		id_tp_followup,
		dt_followup,
		nm_email_destinatario,
		cd_usuario
	)
	values
	(
		@id_pessoa,
		1,
		@id_tp_followup,
		@dt_followup,
		@nm_email_destinatario,
		@cd_usuario
	)

	Insert into cad.t_pessoas
	(
		id_pessoa
	)
	values
	(
		@id_pessoa
	)

	insert into uts_cad.p_cons_pessoas_followup
	(
		id_pessoa,				
		id_followup,	
		id_tp_followp,
		id_tp_followup_pesquisa,
		id_pessoa_papel,	
		nm_tp_followup,
		id_pessoa_followup,
		ds_followup,
		dt_followup,				
		nm_email_destinatario,	
		cd_usuario,				
		cd_papel,				
		cd_empresa,
		dv_regra111054
	)
	values
	(
		@id_pessoa,
		1,
		@id_tp_followup,
		1,
		@id_pessoa_papel,
		'Investigação/Perícia',
		@id_pessoa,
		null,
		@dt_followup,
		@nm_email_destinatario,
		@cd_usuario,
		@cd_papel,
		@cd_empresa,
		0
	)

	/* Ação */
	insert into uts_cad.resultado
	exec [cad].[p_cons_pessoas_followup]
	--- variaveis de uso na proc ---
	@where		= @where,
	@orderby	= @orderby,

	---VARIÁVEIS DE RETORNO PADRÃO---
	@cd_usuario     = @cd_usuario,      
	@cd_retorno     = @cd_retorno		output,
	@nm_retorno		= @nm_retorno		output,					
	@nr_versao_proc = @nr_versao_proc 	output	

	/* Afirmação */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.resultado', 'uts_cad.p_cons_pessoas_followup'
	-- exec tsqlt.run '[UTS_CAD.p_cons_pessoas_followup].[teste cons pessoa followp]'
end