--(f) 	Criar, sem usar as tabelas de estatísticas, a função totalJogosJogador que recebe como
--		parâmetro o identificador de um jogador e devolve o número total de jogos diferentes nos
--		quais o jogador participou.


drop function if exists totalJogosJogador;

create or replace function totalJogosJogador(id_j int)
returns int
as $$
    declare total int;
begin
       select count(distinct id_game) into total
        from(
            select id_game
            from normal n
            where n.id_player = id_j
            union all
            select mj.id_game
            from multijogador mj
            where mj.id_player = id_j
        )as sample;

       return total;
end;
$$ language plpgsql;


select * from totalJogosJogador(1000);
select * from totalJogosJogador(1001);
select * from totalJogosJogador(1002);
select * from totalJogosJogador(1003);