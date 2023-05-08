--(k) 	Criar o procedimento armazenado enviarMensagem que recebe como parâmetros os
--		identificadores de um jogador e de uma conversa e o texto de uma mensagem e procede ao
--		envio dessa mensagem para a conversa indicada, associando-a ao jogador também indicado.


drop procedure if exists enviarMensagem;

set transaction isolation level read committed;
create or replace procedure enviarMensagem(id_jogador int, id_conv int, msg varchar(500))
language plpgsql
as $$
    declare
        v_nome_regiao VARCHAR(40);
        nmr_msg INT;
begin
    --Verificar que o texto da mensagem a ser enviada não é null
    if msg is null then 
		raise exception 'A mensagem tem de ter texto!';
    end if;

     --Verificar se o id_jogador passado como parâmetro existe na tabela de jogadores.
    if not exists(select * from jogadores where id_player = id_jogador) then
        raise exception 'O id passado como parâmetro não existe na tabela JOGADORES.';
    end if;

    --Verificar se o id_conv passado como parâmetro existe na tabela de conversas.
    if not exists(select * from conversas where id_conversa = id_conv) then
        raise exception 'O id passado como parâmetro não existe na tabela CONVERSAS.';
    end if;

    create table tabelaK as
        select nome_regiao
        from jogadores
        where id_player = id_jogador;

    select nome_regiao into v_nome_regiao from tabelaK;
    select coalesce(max(nmr_seq_msg) + 1, 0) into nmr_msg from mensagens where id_conversa = id_conv;

	if not exists (select 1 from participar where id_jogador = id_player) then
    	insert into participar values(id_jogador, v_nome_regiao, id_conv);
	-- else não insere em PARTICIPAR porque a conversa já existe 
	end if;
	
    insert into mensagens values(id_conv, nmr_msg, msg, id_jogador, v_nome_regiao);
    
	drop table if exists tabelaK;
end
$$;


call enviarMensagem(1000, 100001, 'Vai um joguinho?');

select * from mensagens order by id_conversa, nmr_seq_msg;
select * from conversas;
select * from participar order by id_player;