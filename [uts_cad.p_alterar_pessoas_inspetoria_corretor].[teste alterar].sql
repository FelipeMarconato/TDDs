alter Procedure [uts_cad.p_alterar_pessoas_inspetoria_corretor].[teste alterar]
as

Begin 

	Declare 
	---VARIÁVEIS DE USO DA PROCEDURE A SER TESTADA---
	@id_inspetoria_corretor			int	= 1,
	@fl_ativo						bit = 1,
	---VARIÁVEIS DE RETORNO PADRÃO---
	@cd_retorno						int,
	@nm_retorno						Varchar(255),
	@nr_versao_proc					varchar(15)
	
	/*Preparação das tabelas*/
	Exec tsqlt.FakeTable @tablename = 'cad.t_pessoas_inspetoria_corretor'

	Insert into cad.t_pessoas_inspetoria_corretor
	(
		id_inspetoria_corretor,
		fl_ativo
	)
	values
	(
		@id_inspetoria_corretor,
		@fl_ativo
	)

	Create table uts_cad.t_pessoas_inspetoria_corretor
	(
		id_inspetoria_corretor	int,
		fl_ativo				bit
	)

	Insert into uts_cad.t_pessoas_inspetoria_corretor
	(
		id_inspetoria_corretor,
		fl_ativo
	)
	values
	(
		@id_inspetoria_corretor,
		@fl_ativo
	)

	/*Ação*/
	exec [cad].[p_alterar_pessoas_inspetoria_corretor]
	@id_inspetoria_corretor = @id_inspetoria_corretor,
	@fl_ativo				= @fl_ativo,
	@nm_retorno				= @nm_retorno		output,
	@cd_retorno				= @cd_retorno		output,
	@nr_versao_proc			= @nr_versao_proc	output

	/*Afirmação*/
	Exec tsqlt.AssertEqualsTable 'uts_cad.t_pessoas_inspetoria_corretor','cad.t_pessoas_inspetoria_corretor'
	-- exec tsqlt.run '[uts_cad.p_alterar_pessoas_inspetoria_corretor].[teste alterar]'
end