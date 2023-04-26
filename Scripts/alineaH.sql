--h) Criar o procedimento armazenado associarCrachá que recebe como parâmetros o
--   identificador de um jogador, a referência de um jogo e o nome de um crachá desse jogo e
--   atribui o crachá a esse jogador se ele reunir as condições para o obter.




create or replace procedure associarCracha(id_jogador int, id_g VARCHAR(50), crachaNome VARCHAR(50))
language plpgsql
as $$
BEGIN
    --Verificar se o id_jogador passado como parâmetro existe na tabela de jogadores.
    if not exists(select * from jogadores where id_player = id_jogador) then
        raise exception 'O id passado como parâmetro não existe na tabela de jogos.';
    end if;

    --Verificar se o id_g passado como parâmetro existe na tabela de jogos.
    if not exists(select * from jogos where id_game = id_g) then
        raise exception 'O id passado como parâmetro não existe na tabela de jogos.';
    end if;

    --Verificar se o crachaNome passado como parâmetro existe na tabela de crachas.
    if not exists(select * from crachas where crachaNome = nome_cracha) then
        raise exception 'O id passado como parâmetro não existe na tabela de jogos.';
    end if;

    create table nova_tabela as
        select id_player, username, nome_game, sum(pontuacao_n) as totalpontos
        from(
            select n.id_player, n.username, n.nome_game, n.pontuacao_n
            from normal n
            where n.id_player = id_jogador and n.id_game = id_g
            union all
            select mj.id_player, mj.username, mj.nome_game, mj.pontuacao_mj
            from joga_mj mj
            where mj.id_player = id_jogador and mj.id_game = id_g
            ) as nova_tabela
        group by id_player, username, nome_game;

    if exists( select * from nova_tabela where totalpontos >= 1000)
        then insert into tem values (id_jogador, crachaNome);
    end if;
    drop table nova_tabela;
end
$$;

call associarCracha(1000,'0123456789','Test Drive');



