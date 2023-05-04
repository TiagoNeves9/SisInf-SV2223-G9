--(i) 	Criar o procedimento armazenado iniciarConversa iniciar uma conversa (chat) dados o
--		identificador de um jogador e o nome da conversa. O jogador deve ficar automaticamente
--		associado à conversa. O procedimento deve devolver num parâmetro de saída o identificador
--		da conversa criada.


drop procedure if exists iniciarConversa;

create or replace procedure iniciarConversa(id_jogador int, nome_chat varchar(30), out id_conv int)
language plpgsql
as $$
declare
    idpl int;
    nome_r varchar(30);
begin
    --Verificar se o id_jogador passado como parâmetro existe na tabela de jogadores.
	if not exists(select * from jogadores where id_player = id_jogador) then
    	raise exception 'O id passado como parâmetro não existe na tabela JOGADORES.';
    end if;
	
    --Criar a nova conversa passando nome_conversa como parâmetro.
    insert into conversas(nome_conversa) values(nome_chat);
    
	--Ir buscar o id da nova conversa e o seu nome e colocá-los nas variáveis.
    select id_conversa into id_conv from conversas where nome_conversa = nome_chat;
	--Ir buscar os dados do id_jogador passado como parâmetro.
    select id_player, nome_regiao into idpl, nome_r 
	from jogadores 
	where id_player = id_jogador;
	
	--Inserir o novo valor na tabela criar.
    insert into criar values(idpl, nome_r, id_conv);
    return;
END;
$$;


do $$
declare id_chat int;
begin
	--call iniciarConversa(1002, 'sera?', id_chat);
	call iniciarConversa(1001, 'chat_off_topic', id_chat);
	RAISE NOTICE 'id_conv = %', id_chat;
end $$;

select * from conversas;
select * from criar;