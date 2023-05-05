
-- alinea D
do
$$
    declare email varchar(30) = 'test@test.com';
    declare username varchar(30) = 'test1';
    declare regiao varchar(30) = 'Europa';
    BEGIN
        select criar_jogador(email,username,regiao);
        if(email not in (select jogadores.email from jogadores)) then
            RAISE NOTICE 'Teste criarJogador com dados corretos: FAIL';
        ELSE
            RAISE NOTICE 'Teste criarJogador com dados corretos: OK';
        end if;
    end;
$$;


--------------------------------------------

--alinea E

do  --dados corretos OK
$$
    declare id_j INT = 1000;
BEGIN
    /*if pg_typeof(id_j) != 'int' then
        raise notice 'Dados incorretos';
    end if;*/

    if(select totalPontosJogador(id_j)) >= 0 then
        raise notice 'Teste totalPontosJogador com dados corretos: OK';
    else
        raise notice 'Teste totalPontosJogador com dados corretos: FAIL';
    end if;
ROLLBACK;
END;
$$;

do --dados corretos FAIL
$$
    declare id_j INT = 1005;
BEGIN
    /*if pg_typeof(id_j) != 'integer' then
        raise notice 'Dado incorreto';
    end if;*/

    if(select totalPontosJogador(id_j)) >= 0 then
        raise notice 'Teste totalPontosJogador com dados corretos: OK';
    else
        raise notice 'Teste totalPontosJogador com dados corretos: FAIL';
    end if;
ROLLBACK;
END;
$$;

do  --dados incorretos
$$
    declare id_j varchar = 'aaaa';
BEGIN
    if pg_typeof(id_j)::text != 'int' then
        raise notice 'Dado incorreto';
    end if;

    if(select totalPontosJogador(id_j)) >= 0 then
        raise notice 'Teste totalPontosJogador com dados corretos: OK';
    else
        raise notice 'Teste totalPontosJogador com dados corretos: FAIL';
    end if;
ROLLBACK;
END;
$$;
--------------------------------------------

--alinea F

do
$$
    declare id_j INT = 1000;
BEGIN
    if pg_typeof(id_j)::text != 'int' then
        raise notice 'Dado Incorreto';
    end if;

    if(select totaljogosjogador(id_j)) <= 0 then
        raise notice 'Teste totalJogosJogador com dados corretos: FAIL';
    else
        raise notice 'Teste totalJogosJogador com dados corretos: OK';
    end if;
ROLLBACK;
END;
$$;

do
$$
    declare id_j INT = 1005;
BEGIN
    if pg_typeof(id_j)::text != 'int' then
        raise notice 'Dado Incorreto';
    end if;

    if(select totaljogosjogador(id_j)) <= 0 then
        raise notice 'Teste totalJogosJogador com dados corretos: FAIL';
    else
        raise notice 'Teste totalJogosJogador com dados corretos: OK';
    end if;
ROLLBACK;
END;
$$;

do
$$
    declare id_j varchar = 'aaaa';
BEGIN
    if pg_typeof(id_j)::text != 'int' then
        raise notice 'Dado Incorreto';
    end if;

    if(select totaljogosjogador(id_j)) <= 0 then
        raise notice 'Teste totalJogosJogador com dados corretos: FAIL';
    else
        raise notice 'Teste totalJogosJogador com dados corretos: OK';
    end if;
ROLLBACK;
END;
$$;

-----------------------------------
--alinea G

do
$$
    declare id_g varchar = '9876543210';
BEGIN
        /*if pg_typeof(id_g)::text = 'int' then
        raise notice 'Dados Incorretos, Teste pontosJogoPorJogador: FAIL';  --Ainda nao sei bem como utilizar isto de forma correta
        end if;*/
        if(select count(id_jogador) from pontosjogoporjogador(id_g)) > 0 then
            raise notice 'Teste pontosJogoPorJogador: OK';
        end if;
ROLLBACK;
end;
$$;

-------------------------------------
--alinea H

do
$$
BEGIN
    --preenchimento da tabela com informação nova
    call associarCracha(1004, '22222bbbbb', 'Some Sort of Rocket');
    call associarCracha(1004, '22222bbbbb', 'Gunsmith');

    if(select count(*) from  tem where id_player = 1004) = 2 then
        raise notice 'Teste associarCracha: OK';
    else
        raise notice 'Teste associarCracha: FAIL';
    end if;
    ROLLBACK;
END;
$$;

--------------------------------------
--alinea I

--------------------------------------
--alinea J

do
$$
    declare n_participants INT;
BEGIN
    select count(distinct id_player) into n_participants from criar where id_conversa = 100000;
    raise notice 'A conversa com id_conversa = 100000 tem % participantes',n_participants;

    call juntarConversa(1002, 100000);
    call juntarConversa(1003, 100000);

    select count(distinct id_player) into n_participants from criar where id_conversa = 100000;
    raise notice 'A conversa com id_conversa = 100000 tem % participantes',n_participants;

    if(select count(distinct id_player) from criar where id_conversa = 100000) = 4 then
        raise notice 'Teste juntarConversa: OK';
    else
        raise notice 'Test juntarConversa: FAIL';
    end if;

    ROLLBACK;
END;
$$;
------------------------------------------------------
--alinea K

do
$$
    declare n_msg INT;
BEGIN
    select count(*) into n_msg from mensagens;
    raise notice 'Existem % mensagens', n_msg;

    call enviarMensagem(1000, 100000, 'mekie mpts daqui quem fala é o Vascaao');
    call enviarMensagem(1001, 100000, 'Tudo bem, Vasco?');
    call enviarMensagem(1000, 100000, 'voces tao bem?');
    call enviarMensagem(1003, 100003, 'bora embora');
    call enviarMensagem(1003, 100003, 'bora embora'); --repeti propositalmente
    call enviarMensagem(1003, 100003, 'bora embora'); --estes 2 para testar
    call enviarMensagem(1001, 100002, 'Hoje não jogo, estou de viagem...');
    call enviarMensagem(1001, 100002, 'Amanhã jogo!');

    if(select count(*) from mensagens) != n_msg then
        raise notice 'Teste enviarMensagem -> mensagens adicionadas : OK';
    else
        raise notice 'Teste enviarMensagem -> mensagens adicionadas : FAIL';
    end if;

    if(select count(*) from mensagens) = n_msg + 8 then
        raise notice 'Teste enviarMensagem -> mensagens repetidas: OK';
    else
        raise notice 'Teste enviarMensagem -> mensagens repetidas: FAIL';
    end if;

    ROLLBACK;
END;
$$;
----------------------------------------------------------------

