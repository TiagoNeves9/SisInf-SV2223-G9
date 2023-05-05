
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
        if pg_typeof(id_g)::text != 'varchar' then
        raise notice 'Dados Incorretos, Teste pontosJogoPorJogador: FAIL';
        end if;
        if(select count(id_jogador) from pontosjogoporjogador(id_g)) > 0 then
            raise notice 'Teste pontosJogoPorJogador: OK';
        end if;
ROLLBACK;
end;
$$


