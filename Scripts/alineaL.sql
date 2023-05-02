/*(l) Criar a vista jogadorTotalInfo que permita aceder à informação sobre identificador, estado,
email, username, número total de jogos em que participou, número total de partidas em que
participou e número total de pontos que já obteve de todos os jogadores cujo estado seja
diferente de “Banido”. Deve implementar na vista os cálculos sem aceder às tabelas de
estatísticas.*/


create or replace view jogadorTotalInfo as

    select j.id_player,j.username,j.email,estado_player,jogos,partidas, totalpontos
    from (select id_player,
                 username,
                 email,
                 sum(jogos)       as jogos,                                                 -- feito mas temos de avaliar a questao do jogos,
                 sum(partidas)    as partidas,                                              -- penso q contagem ta mal.
                 sum(totalpontos) as totalpontos
          from (select n.id_player,
                       n.username,
                       n.email,
                       count(distinct n.nome_game)     as jogos,
                       count(distinct nmr_seq_partida) as partidas,
                       sum(n.pontuacao_n)              as totalpontos
                from normal n
                group by n.id_player, n.username, n.nome_game, n.email
                UNION ALL
                select mj.id_player,
                       mj.username,
                       mj.email,
                       count(distinct mj.nome_game),
                       count(distinct nmr_seq_partida),
                       sum(mj.pontuacao_mj)
                from joga_mj mj
                group by mj.id_player, mj.username, mj.nome_game, mj.email) as tabela
          group by id_player, username, email
    ) as sample join jogadores j on sample.id_player = j.id_player
    where j.estado_player != 'Banido';

select * from jogadorTotalInfo;


