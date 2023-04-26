--e) Criar, sem usar as tabelas de estatísticas, a função totalPontosJogador que recebe como
--	parâmetro o identificador de um jogador e devolve o número total de pontos obtidos pelo
--	jogador.

drop function totalPontosJogador(id_p int);

create or replace function totalPontosJogador(id_p INT)
returns INT as $$
declare pontos INT;

begin
	
--Vericar se o id passado como parâmetro existe na tabela de jogador.

	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
	
	select SUM(pontuacao_n) INTO pontos
	from(
		select id_player, pontuacao_n
		from NORMAL
		where id_player = id_p
		UNION ALL
		select id_player, pontuacao_mj
		from JOGA_MJ
		where id_player = id_p
	) as TODAS_PARTIDAS;
	
	return pontos;
end;
$$ language plpgsql;

select totalPontosJogador(1000);