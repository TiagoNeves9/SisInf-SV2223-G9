--(l) 	Criar a vista jogadorTotalInfo que permita aceder à informação sobre identificador, estado,
--		email, username, número total de jogos em que participou, número total de partidas em que
--		participou e número total de pontos que já obteve de todos os jogadores cujo estado seja
--		diferente de “Banido”. Deve implementar na vista os cálculos sem aceder às tabelas de
--		estatísticas.


drop view if exists jogadorTotalInfo;

create or replace view jogadorTotalInfo as
    select
		j.id_player, j.estado_player, j.email, j.username, totalJogosJogador(j.id_player),
		count(distinct n.nmr_seq_partida) + count(distinct mj.nmr_seq_partida) as totalpartidas,
		totalPontosJogador(j.id_player)
	from jogadores j
	left join normal n on j.id_player = n.id_player
	left join multijogador mj on j.id_player = mj.id_player
	where j.estado_player != 'Banido'
	group by j.id_player;


select * from jogadorTotalInfo;