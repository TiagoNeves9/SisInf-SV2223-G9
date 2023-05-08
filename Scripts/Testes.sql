-- alinea D
do
$$
    declare email1 varchar(30) = 'test@test.com';
	declare email2 varchar(30) = 'joao@gmail.com';
    declare username varchar(30) = 'testD';
    declare regiao varchar(30) = 'West Europe';
    BEGIN
		RAISE NOTICE 'Começo dos 2 testes da alínea D:';
		RAISE NOTICE 'Teste criar_jogador com dados corretos: OK';
        call criar_jogador(email1, username, regiao);
		RAISE NOTICE 'Teste criar_jogador com dados incorretos: FAIL';
        call criar_jogador(email2, username, regiao);
    end;
$$;

-------------------------------------------------

--alinea E

do --dados corretos OK
$$
    declare id_j INT = 1000;
BEGIN
	RAISE NOTICE 'Teste 1/3 da alínea E:';
    if(id_j >= 1000) then
		perform totalPontosJogador(id_j);
        raise notice 'Teste totalPontosJogador com dados corretos: OK';
    else
		raise notice 'Should not reach this line!';
    end if;
ROLLBACK;
END;
$$;

do --dados corretos FAIL
$$
    declare id_j INT = -1005;
BEGIN
	RAISE NOTICE 'Teste 2/3 da alínea E:';
    if(id_j >= 1000) then
		raise notice 'Should not reach this line!';
    else
        raise notice 'Teste totalPontosJogador com dados corretos: FAIL';
		perform totalPontosJogador(id_j);
    end if;
ROLLBACK;
END;
$$;

do --dados incorretos
$$
    declare id_j varchar = 'aaaa';
BEGIN
	RAISE NOTICE 'Teste 3/3 da alínea E:';
    if pg_typeof(id_j)::text != 'integer' then
		raise notice 'Teste totalPontosJogador com dados incorretos: FAIL';
		perform totalPontosJogador(id_j);
    else
        raise notice 'Should not reach this line!';
    end if;
ROLLBACK;
END;
$$;

-------------------------------------------------

--alinea F

do
$$
    declare id_j INT = 1000;
BEGIN
	RAISE NOTICE 'Teste 1/3 da alínea F:';
    if pg_typeof(id_j)::text != 'integer' then
		raise notice 'Should not reach this line!';
    end if;
    if(id_j < 1000) then
		raise notice 'Should not reach this line!';
    else
		perform totalJogosJogador(id_j);
        raise notice 'Teste totalJogosJogador com dados corretos: OK';
    end if;
ROLLBACK;
END;
$$;

do
$$
    declare id_j INT = 1005;
BEGIN
	RAISE NOTICE 'Teste 2/3 da alínea F:';
    if pg_typeof(id_j)::text != 'integer' then
	raise notice 'Should not reach this line!';
    end if;
    if(id_j < 1000) then
		raise notice 'Should not reach this line!';
    else
		perform totalJogosJogador(id_j);
        raise notice 'Teste totalJogosJogador com dados corretos: OK';
    end if;
ROLLBACK;
END;
$$;

do
$$
    declare id_j varchar = 'aaaa';
BEGIN
	RAISE NOTICE 'Teste 3/3 da alínea F:';
    if pg_typeof(id_j)::text != 'integer' then
		raise notice 'Teste totalJogosJogador com dados incorretos: FAIL';
		perform totalJogosJogador(id_j);
    else
        raise notice 'Should not reach this line!';
    end if;
ROLLBACK;
END;
$$;

-------------------------------------------------

--alinea G

do
$$
    declare id_g_valid varchar = '9876543210';
    declare id_g_invalid varchar = '9876543210';
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea G:';
	if((select count(id_jogador) from pontosJogoPorJogador(id_g_valid)) > 0) then
		raise notice 'Teste pontosJogoPorJogador com dados corretos: OK';
	else
   		raise notice 'Should not reach this line!';
	end if;
	if((select count(id_jogador) from pontosJogoPorJogador(id_g_invalid)) != 0) then
		raise notice 'Teste pontosJogoPorJogador com dados incorretos: FAIL';
	else
   		raise notice 'Should not reach this line!';
	end if;
ROLLBACK;
end;
$$;

-------------------------------------------------

--alinea H

do
$$
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea G:';
    --Eliminação da tabela atual e preenchimento da tabela com informação nova
	delete from tem;
    call associarCracha(1004, '22222bbbbb', 'Some Sort of Rocket');
    call associarCracha(1004, '22222bbbbb', 'Gunsmith');

    if((select count(*) from tem where id_player = 1004) = 2) then
        raise notice 'Teste associarCracha com dados corretos: OK';
    else
   		raise notice 'Should not reach this line!';
	end if;
   	
	call associarCracha(1000, '22222bbbbb', 'Some Sort of Rocket');
	
	if((select count(*) from tem where id_player = 1000) = 0) then
    	raise notice 'Teste associarCracha com dados incorretos: FAIL';
    else
   		raise notice 'Should not reach this line!';
	end if;
    ROLLBACK;
END;
$$;

-------------------------------------------------

--alinea I

-------------------------------------------------

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

-------------------------------------------------

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

-------------------------------------------------