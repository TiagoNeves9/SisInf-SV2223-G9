-- D

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
ROLLBACK;	
end;
$$;

-------------------------------------------------

-- E

do --dados corretos OK
$$
    declare id_j INT = 1000;
BEGIN
	RAISE NOTICE 'Teste 1/3 da alínea E:';
    if (id_j >= 1000) then
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
    if (id_j >= 1000) then
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

-- F

do
$$
    declare id_j INT = 1000;
BEGIN
	RAISE NOTICE 'Teste 1/3 da alínea F:';
    if pg_typeof(id_j)::text != 'integer' then
		raise notice 'Should not reach this line!';
    end if;
    if (id_j < 1000) then
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
    if (id_j < 1000) then
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

-- G

do
$$
    declare id_g_valid varchar = '9876543210';
    declare id_g_invalid varchar = '9876543210';
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea G:';
	if ((select count(id_jogador) from pontosJogoPorJogador(id_g_valid)) > 0) then
		raise notice 'Teste pontosJogoPorJogador com dados corretos: OK';
	else
   		raise notice 'Should not reach this line!';
	end if;
	
	if ((select count(id_jogador) from pontosJogoPorJogador(id_g_invalid)) != 0) then
		raise notice 'Teste pontosJogoPorJogador com dados incorretos: FAIL';
	else
   		raise notice 'Should not reach this line!';
	end if;
ROLLBACK;
end;
$$;

-------------------------------------------------

-- H

do
$$
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea H:';
    --Eliminação da tabela atual e preenchimento da tabela com informação nova
	delete from tem;
    call associarCracha(1004, '22222bbbbb', 'Some Sort of Rocket');
    call associarCracha(1004, '22222bbbbb', 'Gunsmith');

    if ((select count(*) from tem where id_player = 1004) = 2) then
        raise notice 'Teste associarCracha com dados corretos: OK';
    else
   		raise notice 'Should not reach this line!';
	end if;
   	
	call associarCracha(1000, '22222bbbbb', 'Some Sort of Rocket');
	
	if ((select count(*) from tem where id_player = 1000) = 0) then
    	raise notice 'Teste associarCracha com dados incorretos: FAIL';
    else
   		raise notice 'Should not reach this line!';
	end if;
    ROLLBACK;
END;
$$;

-------------------------------------------------

-- I

do
$$
declare id_chat_valid int;
declare id_chat_invalid int;
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea I:';
    raise notice 'Teste iniciarConversa com dados corretos: OK';
	call iniciarConversa(1000, 'Test_I', id_chat_valid);
	RAISE NOTICE 'ID de Conversa retornado = %', id_chat_valid;
	
    raise notice 'Teste iniciarConversa com dados incorretos: FAIL';
	call iniciarConversa(1000, 'Test_I', id_chat_invalid);
    ROLLBACK;
END;
$$;

-------------------------------------------------

-- J

do
$$
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea J:';
    raise notice 'Teste juntarConversa com dados corretos: OK';
	delete from participar;
    call juntarConversa(1002, 100000);
    call juntarConversa(1003, 100000);
    
	raise notice 'Teste juntarConversa com dados incorretos: FAIL';
    call juntarConversa(1002, 100000);
    ROLLBACK;
END;
$$;

-------------------------------------------------

-- K

do
$$
	declare id_chat int;
    declare n_msg INT;
BEGIN
	RAISE NOTICE 'Começo dos 2 testes da alínea K:';
	delete from mensagens;
    select count(*) into n_msg from mensagens;
    raise notice 'Existem % mensagens', n_msg;

	delete from participar;
	delete from conversas;
	call iniciarConversa(1000, 'Test_I', id_chat);
	RAISE NOTICE 'ID de Conversa retornado = %', id_chat;
	
	call juntarConversa(1001, id_chat);
	
    call enviarMensagem(1000, id_chat, 'mekie mpts daqui quem fala é o Vascaao');
    call enviarMensagem(1001, id_chat, 'Tudo bem, Vasco?');
    call enviarMensagem(1000, id_chat, 'voces tao bem?');

    if (select count(*) from mensagens) = n_msg + 3 then
    	raise notice 'Teste enviarMensagem com dados corretos: OK';
    else
		raise notice 'Should not reach this line!';
    end if;
	
	raise notice 'Teste enviarMensagem com dados incorretos: FAIL';
	call juntarConversa(1001, id_chat - 1);
    ROLLBACK;
END;
$$;

-------------------------------------------------

-- L

--Nada a testar.
--É uma vista, mostra as informações de todos
--os jogadores não banidos:

do
$$
BEGIN
	RAISE NOTICE 'Alínea L:';
	perform * from jogadorTotalInfo;
    ROLLBACK;
END;
$$;

select * from jogadorTotalInfo;

-------------------------------------------------

-- M

do
$$
    declare nmr_crachas int;
	declare nmr_seq int;
BEGIN
	RAISE NOTICE 'Começo do teste da alínea M (trigger):';
    delete from tem;
	delete from crachas;
    select count(*) into nmr_crachas from tem;
	select count(*) into nmr_seq from normal where id_game = '0123456789';
    raise notice 'Existem % crachás', nmr_crachas;
	
	insert into crachas values('0123456789', 'Test M', 'https://www.trueachievements.com/a374283/testM', 10);
	insert into normal values(
		'Oceania', '0123456789', nmr_seq + 1, 'Em curso', 
		'2023-04-11 23:58', null, 100, 1000, 3
	);
	update normal set estado_partida = 'Terminada', data_hora_fim = current_timestamp 
		where id_player = 1000 and nmr_seq_partida = nmr_seq + 1 and id_game = '0123456789';

	if ((select count(*) from tem where id_player = 1000) >= nmr_crachas + 1) then
		raise notice 'Teste associarCracha com dados corretos: OK';
    else
   		raise notice 'Should not reach this line!';
	end if;
	
    ROLLBACK;
END;
$$;

-------------------------------------------------

-- N

--Nada a testar.
--É um trigger que bane todos os jogadores apenas.

do
$$
BEGIN
	RAISE NOTICE 'Alínea N:';
	DELETE FROM jogadorTotalInfo;
	perform * from jogadores;
    ROLLBACK;
END;
$$;

--Colocar o rollback em comentário para ver
--todos os jogadores banidos no select abaixo
select * from jogadores; 