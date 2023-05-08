--(m) 	Criar os mecanismos necessários para que, de forma automática, quando uma partida
--		termina, se proceda à atribuição de crachás do jogo a que ela pertence.


--	Para a tabela multijogador
drop function if exists associarCrachaMultijogador;

set transaction isolation level read uncommitted;
CREATE OR REPLACE FUNCTION associarCrachaMultijogador() 
RETURNS TRIGGER AS $$
declare
	id_game_ varchar(40);
	id_player_ int;
	total_pontos int;
	nome_regiao_ varchar(40);
	r record;
BEGIN
	-- Verificar se o update realizado foi na coluna estado_partida e se foi com o valor 'Terminada'
	if ( old.estado_partida != new.estado_partida and new.estado_partida  = 'Terminada') then
		-- Ir buscar o nome do jogo que acabou e o jogador que o estava a jogar
		select id_game , id_player, nome_regiao 
		into id_game_ , id_player_, nome_regiao_
		from multijogador
		where id_game = old.id_game and id_player = old.id_player and old.estado_partida != new.estado_partida and new.estado_partida  = 'Terminada';
		raise notice 'The value is %',id_player_;
		-- Ir ver quanto cada jogador pontuou no jogo passado como parâmetro
		select pontos into total_pontos from PontosJogoPorJogador(id_game_) where id_jogador = id_player_;
		-- Ir buscar os pontos necessários para obter cada cracha no jogo em questão e iterar por todos os crachas existentes, verificando a condição
		for r in select limite_pontos , nome_cracha from crachas where id_game = id_game_ loop
		--Se os pontos do jogador forem iguais ou superiores aos pontos que o cracha requer, colocamos o cracha na tabela tem associado ao jogador que a obteve e ao jogo onde foi obtido
			if( total_pontos >= r.limite_pontos) then
				insert into tem values( id_player_, r.nome_cracha, id_game_, nome_regiao_);
			end if;
		end loop;
		RETURN NEW;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER associarCrachaMultijogador
AFTER UPDATE ON multijogador
FOR EACH ROW
EXECUTE FUNCTION associarCrachaMultijogador();


--	Para a tabela normal
drop function if exists associarCrachaNormal;

set transaction isolation level read uncommitted;
CREATE OR REPLACE FUNCTION associarCrachaNormal() 
RETURNS TRIGGER AS $$
declare
	id_game_ varchar(40);
	id_player_ int;
	total_pontos int;
	nome_regiao_ varchar(40);
	r record;
BEGIN
	-- Verificar se o update realizado foi na coluna estado_partida e se foi com o valor 'Terminada'
	if ( old.estado_partida != new.estado_partida and new.estado_partida  = 'Terminada') then
		-- Ir buscar o nome do jogo que acabou e o jogador que o estava a jogar
		select id_game, id_player, nome_regiao 
		into id_game_, id_player_, nome_regiao_
		from normal
		where id_game = old.id_game and id_player = old.id_player and old.estado_partida != new.estado_partida and new.estado_partida  = 'Terminada';
		raise notice 'The value is %',id_player_;
		-- Ir ver quanto cada jogador pontuou no jogo passado como parâmetro
		select pontos into total_pontos from PontosJogoPorJogador(id_game_) where id_jogador = id_player_;
		-- Ir buscar os pontos necessários para obter cada cracha no jogo em questão e iterar por todos os crachas existentes, verificando a condição
		for r in select limite_pontos , nome_cracha from crachas where id_game = id_game_ loop
		--Se os pontos do jogador forem iguais ou superiores aos pontos que o cracha requer, colocamos o cracha na tabela tem associado ao jogador que a obteve e ao jogo onde foi obtido
			if( total_pontos >= r.limite_pontos) then
				insert into tem values(id_player_, r.nome_cracha, id_game_, nome_regiao_);
			end if;
		end loop;
		RETURN NEW;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER associarCrachaNormal
AFTER UPDATE ON normal
FOR EACH ROW
EXECUTE FUNCTION associarCrachaNormal();


--Exemplo de chamada
update normal set 
	estado_partida = 'Terminada', data_hora_inicio = '2023-04-05 00:00:00', 
	data_hora_fim = current_timestamp where nmr_seq_partida = 0 and id_game = '0123456789';

select * from tem;
select * from normal;