--(h) 	Criar o procedimento armazenado associarCrachá que recebe como parâmetros o
--		identificador de um jogador, a referência de um jogo e o nome de um crachá desse jogo e
--		atribui o crachá a esse jogador se ele reunir as condições para o obter.


drop procedure if exists associarCracha;

create or replace procedure associarCracha(id_jogador int, id_g VARCHAR(50), crachaNome VARCHAR(50))
language plpgsql
as $$
DECLARE
    v_nome_game VARCHAR(40);
    v_nome_regiao VARCHAR(40);
BEGIN
    --Verificar se o id_jogador passado como parâmetro existe na tabela de jogadores.
    if not exists(select * from jogadores where id_player = id_jogador) then
        raise exception 'O id passado como parâmetro não existe na tabela JOGADORES.';
    end if;

    --Verificar se o id_g passado como parâmetro existe na tabela de jogos.
    if not exists(select * from jogos where id_game = id_g) then
        raise exception 'O id passado como parâmetro não existe na tabela JOGOS.';
    end if;

    --Verificar se o crachaNome passado como parâmetro existe na tabela de crachas.
    if not exists(select * from crachas where crachaNome = nome_cracha) then
        raise exception 'O nome passado como parâmetro não existe na tabela CRACHAS.';
    end if;

    create table nova_tabela as
        select id_player, nome_game, nome_regiao, sum(pontuacao_n) as totalpontos
        from(
            select n.id_player, n.nome_game, n.pontuacao_n, n.nome_regiao
            from normal n
            where n.id_player = id_jogador and n.id_game = id_g
				union all
            select mj.id_player, mj.nome_game, mj.pontuacao_mj, mj.nome_regiao
            from joga_mj mj
            where mj.id_player = id_jogador and mj.id_game = id_g
       	) as nova_tabela
			group by id_player, nome_game, nome_regiao;
	select nome_game, nome_regiao into v_nome_game, v_nome_regiao from nova_tabela;
	
    if exists( 
		select * from nova_tabela where totalpontos >= 
		(select limite_pontos from crachas where id_game = id_g and nome_cracha = crachaNome)
	)
        then insert into tem values (id_jogador, crachaNome, id_g, v_nome_game, v_nome_regiao);
   	end if;
	
    drop table nova_tabela;
end
$$;


call associarCracha(1000, '0123456789', 'Test Drive');
select * from crachas;