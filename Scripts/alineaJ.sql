--(j) 	Criar o procedimento armazenado juntarConversa que recebe como parâmetros os
--		identificadores de um jogador e de uma conversa e junta esse jogador a essa conversa.


drop procedure if exists juntarConversa;

create or replace procedure juntarConversa(id_jogador int, id_conv int)
language plpgsql
as $$
declare
	idpl int;
    nome_r varchar(30);
begin
	--Verificar se o id_conv está presente na tabela CONVERSAS.
    if not exists(select 1 from conversas where id_conversa = id_conv) then
		raise exception 'O ID da conversa não existe na tabela CONVERSAS.';
	end if;
	
	--Ir buscar os dados do id_jogador passado como parâmetro.
    select id_player, nome_regiao into idpl, nome_r 
	from jogadores 
	where id_player = id_jogador;
	
	--Inserir o novo valor na tabela criar.
    insert into criar values(idpl, nome_r, id_conv);
    return;
END;
$$;


call juntarConversa(1001, 100001);

select * from conversas;
select * from criar;