--(d)	Criar os mecanismos que permitam criar o jogador, dados os seus email, região e
--		username, desativar e banir o jogador;


--drop functions on the last lines of file

--Criar um jogador
set transaction isolation level read uncommitted;
create or replace procedure criar_jogador(email_ VARCHAR(30) , username_ VARCHAR(30) , nome_regiao VARCHAR(30))
language plpgsql 
as $$
begin
--Verificar se email ou o username existem na tabela de jogadores.
	if exists(select 1 from jogadores where email = email_ or username = username_ ) then
		raise exception 'O email ou o username já existem na tabela de jogadores.';
	end if;
--Inserir o novo jogador na tabela de jogadores.
	insert into jogadores(email , username , estado_player , nome_regiao ) values( $1 , $2 , 'Ativo' , $3 );
END
$$;


--Desativar um jogador
set transaction isolation level read uncommitted;
create or replace procedure desativar_jogador(id_p integer)
language plpgsql
as $$
begin
--Vericar se o id passado como parâmetro existe na tabela de jogador.
	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
--Modificar o estado do jogador em questão para "Inativo".
	update jogadores set estado_player = 'Inativo'
	where id_player = id_p;
end
$$;


--Banir um jogador
set transaction isolation level read uncommitted;
create or replace procedure banir_jogador(id_p integer)
language plpgsql
as $$
begin
--Vericar se o id passado como parâmetro existe na tabela de jogador.
	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
--Modificar o estado do jogador em questão para "Inativo".
	update jogadores set estado_player = 'Banido'
	where id_player = id_p;
end
$$;


--Test criar_jogador
call criar_jogador('alineaD@gmail.com', 'userAlineaD', 'Africa');
select * from jogadores order by id_player desc limit 1;

--Test desativar_jogador
call desativar_jogador(1000);
select * from JOGADORES where id_player = 1000;

--Test banir_jogador
call banir_jogador(1000);
select * from JOGADORES where id_player = 1000;


--Drop functions
drop procedure if exists banir_jogador;
drop procedure if exists desativar_jogador;
drop procedure if exists criar_jogador;