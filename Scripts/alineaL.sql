--(l) 	Criar a vista jogadorTotalInfo que permita aceder à informação sobre identificador, estado,
--		email, username, número total de jogos em que participou, número total de partidas em que
--		participou e número total de pontos que já obteve de todos os jogadores cujo estado seja
--		diferente de “Banido”. Deve implementar na vista os cálculos sem aceder às tabelas de
--		estatísticas.


drop view if exists jogadorTotalInfo;

create or replace view jogadorTotalInfo as
    select(
		id_player, estado, email, username, totalJogosJogador(id_player),
		count(distinct n.nmr_seq_partida) + count(distinct mj.nmr_seq_partida),
		totalPontosJogador(id_player)
		
	) where j.estado_player != 'Banido';


select * from jogadorTotalInfo;