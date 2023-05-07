--(f) 	Criar, sem usar as tabelas de estatísticas, a função totalJogosJogador que recebe como
--		parâmetro o identificador de um jogador e devolve o número total de jogos diferentes nos
--		quais o jogador participou.


drop function if exists totalJogosJogador;

set transaction isolation level read uncommitted;
create or replace function totalJogosJogador(id_p int)
returns int
as $$

	declare total int;
	
begin
   	select count(distinct id_game) into total
    from(
		select id_game, pontuacao_n
		from normal n
		where n.id_player = id_p
		union all
		select id_game, pontuacao_mj
		from joga_mj mj
		where mj.id_player = id_p
  	) as TODAS_PARTIDAS;	
		
	perform totalPontosJogador(id_p); --para povoar ESTATISTICAS_JOGADORES
		
	return total;
end;
$$ language plpgsql;


select * from totalJogosJogador(1000);
select * from totalJogosJogador(1001);
select * from totalJogosJogador(1002);
select * from totalJogosJogador(1003);

insert into normal values(						--testing if
		'Africa', '0123456789', 2, 'Em curso',	--stats table
		current_date, null, 500000, 1001, 2		--updates
	);											--dynamically
	
select * from estatisticas_jogadores;