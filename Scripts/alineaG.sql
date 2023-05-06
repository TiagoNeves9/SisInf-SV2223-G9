--(g) 	Criar a função PontosJogoPorJogador que recebe como parâmetro a referência de um jogo
--		e devolve uma tabela com duas colunas (identificador de jogador, total de pontos) em que
--		cada linha contém o identificador de um jogador e o total de pontos que esse jogador teve
--		nesse jogo. Apenas devem ser devolvidos os jogadores que tenham jogado o jogo.


drop function PontosJogoPorJogador(id_g VARCHAR(10));

create or replace function PontosJogoPorJogador(id_g VARCHAR(10))
returns table(id_jogador int, pontos bigint)
as $$
	
	declare
		partidas int;
		players int;
		pontos_n int;
		pontos_mj int;
		pontos int;

begin
    --Verificar se o id passado como parâmetro existe na tabela de jogos.
    if not exists(select * from jogos where id_game = id_g) then
        raise exception 'O id passado como parâmetro não existe na tabela de jogos.';
    end if;

    create temporary table tabela_G as
        select id_player, sum(pontuacao_n) as totalpontos
        from(
            select n.id_player, n.pontuacao_n
            from normal n
            where n.id_game = id_g
            	union all
            select mj.id_player, mj.pontuacao_mj
            from joga_mj mj
            where mj.id_game = id_g
            ) as tabela_G
    	group by id_player;
		
	if not exists(
		select 1 
		from estatisticas_jogo ej
		where ej.id_game = id_g
	) then
		select into players 
			count(distinct id_player) from comprar where id_game = id_g;
			
		select into pontos_n coalesce(sum(pontuacao_n), 0) from normal where id_game = id_g;
		select into pontos_mj coalesce(sum(pontuacao_mj), 0) from joga_mj where id_game = id_g;
		pontos := pontos_n + pontos_mj;	
		
		select into partidas coalesce(count(*), 0) 
			from (
				select id_game from normal where id_game = id_g
					union all
				select id_game from joga_mj where id_game = id_g
			) as combined_count;
	
		insert into estatisticas_jogo values(id_g, partidas, players, pontos);
	end if;

	return query select id_player, totalpontos from tabela_G;
	drop table if exists tabela_g;
end;
$$ language plpgsql;


select * from PontosJogoPorJogador('9876543210');
select * from PontosJogoPorJogador('22222bbbbb');
select * from estatisticas_jogo;
select * from joga_mj;
select * from normal;