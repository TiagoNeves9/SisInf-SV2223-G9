--d)

--Criar um jogador
create or replace FUNCTION criar_jogador(email_ VARCHAR(30) , username_ VARCHAR(30) , nome_regiao VARCHAR(30))
returns void as $$
begin
--Verificar se email ou o username existem na tabela de jogadores.
	if exists(select 1 from jogadores where email = email_ or username = username_ ) then
	raise exception 'O email ou o username já existem na tabela de jogadores.';
	end if;
--Inserir o novo jogador na tabela de jogadores.
	insert into jogadores(email , username , estado_player , nome_regiao ) values( $1 , $2 , 'Ativo' , $3 );
END;
$$ LANGUAGE plpgsql;


--Desativar um jogador
create or replace function desativar_jogador(id_p integer)
returns void as $$
begin
--Vericar se o id passado como parâmetro existe na tabela de jogador.
	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
--Modificar o estado do jogador em questão para "Inativo".
	update jogadores set estado_player = 'Inativo'
	where id_player = id_p;
end;
$$ language plpgsql;

--Banir um jogador
create or replace function banir_jogador(id_p integer)
returns void as $$
begin
--Vericar se o id passado como parâmetro existe na tabela de jogador.
	if not exists(select * from jogadores where id_player = id_p) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
--Modificar o estado do jogador em questão para "Inativo".
	update jogadores set estado_player = 'Banido'
	where id_player = id_p;
end;
$$ language plpgsql;

drop function banir_jogador;

select banir_jogador(1000);
