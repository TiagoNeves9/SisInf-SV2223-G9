--(f) 	Criar, sem usar as tabelas de estatísticas, a função totalJogosJogador que recebe como
--		parâmetro o identificador de um jogador e devolve o número total de jogos diferentes nos
--		quais o jogador participou.


drop function if exists totalJogosJogador;

create or replace function totalJogosJogador(id_j int)
returns int
as $$
    declare total int;
begin
       select sum(jogos) into total
        from(
            select count(distinct n.id_game) as jogos
            from normal n
            where n.id_player = id_j
            union all
            select count(distinct mj.id_game) as jogos
            from joga_mj mj
            where mj.id_player = id_j
        )as sample;

       return total;
end;
$$language plpgsql;


select * from totalJogosJogador(1000);
select * from totalJogosJogador(1001);