Create Procedure [UTS_CAD.p_alterar_pessoa_prestador].[teste alterar] as

Begin try
	
	Declare
	/*VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA*/
	@id_pessoa						int				= 1,
	@id_pessoa_prestador			int				= 1,
	@dv_nao_gera_nfts				bit				= 1,
	@cd_servico_prestado			int				= 1,
	@cd_subitem						int				= 2,
	@dv_opta_simples_nacional		bit				= 1,
	@dv_mei							bit				= 0,
	@id_tp_meio_pagamento			int				= 1,
	@nr_chave_externa				char(30)		= 123,
	@cd_filial						int				= 1,
	@cd_susep_vida					int				= 345,
	/*VARIÁVEIS DE RETORNO PADRÃO*/
	@cd_usuario						varchar(50)		= NULL	,
	@cd_retorno						int						,
	@nm_retorno						Varchar(255)			,
	@nr_versao_proc					varchar(15)

	Exec tSQLt.FakeTable @tablename = 'cad.t_pessoas_prestador'
	Exec tsqlt.FakeTable @tablename = 'cad.t_pessoas'

	insert into cad.t_pessoas_prestador
	(
		id_pessoa_prestador,	
		id_tp_meio_pagamento,	
		dv_opta_simples_nacional,
		id_pessoa,			
		dv_mei,					
		cd_servico_prestado,	
		dv_nao_gera_nfts,		
		cd_subitem				
	)
	select
		id_pessoa_prestador			= @id_pessoa_prestador,
		id_tp_meio_pagamento		= @id_tp_meio_pagamento,
		dv_opta_simples_nacional	= @dv_opta_simples_nacional,
		id_pessoa					= @id_pessoa,
		dv_mei						= @dv_mei,
		cd_servico_prestado			= @cd_servico_prestado,
		dv_nao_gera_nfts			= @dv_nao_gera_nfts,
		cd_subitem					= @cd_subitem

	Create table uts_cad.t_pessoas_prestador
	(
		id_pessoa_prestador			int,
		id_tp_meio_pagamento		int,
		dv_opta_simples_nacional	bit,
		id_pessoa					int,
		dv_mei						bit,
		cd_servico_prestado			int,
		dv_nao_gera_nfts			bit,
		cd_subitem					int
	)

	insert into uts_cad.t_pessoas_prestador
	(
		id_pessoa_prestador,	
		id_tp_meio_pagamento,	
		dv_opta_simples_nacional,
		id_pessoa,			
		dv_mei,					
		cd_servico_prestado,	
		dv_nao_gera_nfts,		
		cd_subitem				
	)
	select
		id_pessoa_prestador			= @id_pessoa_prestador,
		id_tp_meio_pagamento		= @id_tp_meio_pagamento,
		dv_opta_simples_nacional	= @dv_opta_simples_nacional,
		id_pessoa					= @id_pessoa,
		dv_mei						= @dv_mei,
		cd_servico_prestado			= @cd_servico_prestado,
		dv_nao_gera_nfts			= @dv_nao_gera_nfts,
		cd_subitem					= @cd_subitem


	/*AÇÃO*/
	exec [cad].[p_alterar_pessoa_prestador]
	@id_pessoa_prestador		= @id_pessoa_prestador,
	@id_tp_meio_pagamento		= @id_tp_meio_pagamento,
	@dv_opta_simples_nacional	= @dv_opta_simples_nacional,
	@id_pessoa					= @id_pessoa,
	@dv_mei						= @dv_mei,
	@cd_servico_prestado		= @cd_servico_prestado,
	@dv_nao_gera_nfts			= @dv_nao_gera_nfts,
	@cd_subitem					= @cd_subitem,
	@nr_chave_externa			= @nr_chave_externa,
	@cd_filial					= @cd_filial,
	@cd_susep_vida				= @cd_susep_vida,
	@cd_retorno					= @cd_retorno output,
	@nm_retorno					= @nm_retorno output 

	/* Assert */
	EXEC tSQLt.AssertEqualsTable 'uts_cad.t_pessoas_prestador','cad.t_pessoas_prestador'

	-- exec tsqlt.run'[UTS_CAD.p_alterar_pessoa_prestador].[teste alterar]'

end try
begin catch

	if isnull(error_message(),'') <> ''
	begin
		select
			@cd_retorno	= case when isnull(@cd_retorno,0) < 1 then 1 else @cd_retorno end,
			@nm_retorno =
				'Procedure: ' + isnull(object_name(@@procid),'') + 
				' - Versão ' + isnull(convert(varchar(20), @nr_versao_proc),'0') + 
				case when object_name(@@procid) <> isnull(error_procedure(),object_name(@@procid)) then 
					' - Erro na Proc: ' + isnull(convert(varchar(100), error_procedure()), '') 
				else 
					'' 
				end + 
				' - Erro: '	 + isnull(convert(varchar(300), error_message()), '') +
				case when isnull(error_line(), 0) <> 1 then 
					+ ' - linha: ' + convert(varchar(5),error_line()) 
				else 
					'' 
				end
	end

	raiserror(@nm_retorno,16,0)

end catch