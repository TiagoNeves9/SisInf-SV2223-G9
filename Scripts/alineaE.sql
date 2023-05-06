--(e)	Criar, sem usar as tabelas de estatísticas, a função totalPontosJogador que recebe como
--		parâmetro o identificador de um jogador e devolve o número total de pontos obtidos pelo
--		jogador.


drop function totalPontosJogador(id_p int);

create or replace function totalPontosJogador(id_p INT)
returns INT as $$

	declare 
		total int;
		pontos int;

begin
	
--Vericar se o id passado como parâmetro existe na tabela de jogador.

	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
	
	select count(distinct id_game), coalesce(sum(pontuacao_n), 0) 
		into total, pontos
    from(
		select id_game, pontuacao_n
		from normal n
		where n.id_player = id_p
		union all
		select id_game, pontuacao_mj
		from joga_mj mj
		where mj.id_player = id_p
  	) as TODAS_PARTIDAS;
	
	if not exists(
		select 1 
		from estatisticas_jogadores ej
		where ej.id_player = id_p
	) then	
		insert into estatisticas_jogadores
				select id_p, count(distinct n.nmr_seq_partida) + count(distinct mj.nmr_seq_partida), 
				total, pontos
				from NORMAL n, JOGA_MJ mj
				where n.id_player = id_p and mj.id_player = id_p;
	end if;
	
	return pontos;
end;
$$ language plpgsql;


select totalPontosJogador(1000);
select totalPontosJogador(1001);
select totalPontosJogador(1002);
select totalPontosJogador(1003);
select * from estatisticas_jogadores;