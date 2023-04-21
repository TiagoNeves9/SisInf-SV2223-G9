--g) Criar a função PontosJogoPorJogador que recebe como parâmetro a referência de um jogo
-- 	e devolve uma tabela com duas colunas (identificador de jogador, total de pontos) em que
--	cada linha contém o identificador de um jogador e o total de pontos que esse jogador teve
--	nesse jogo. Apenas devem ser devolvidos os jogadores que tenham jogado o jogo.


drop function PontosJogoPorJogador(id_g VARCHAR(10))
create or replace function PontosJogoPorJogador(id_g VARCHAR(10))

returns table(id_player int, totalpontos int ) 
as $$
begin
	--Vericar se o id passado como parâmetro existe na tabela de jogos.

	if not exists(select * from jogos where id_game = id_g) then
		raise exception 'o id passado como parâmetro não existe na tabela de jogador.';
	end if;
	
return query select id_jogador, SUM(pontuacao)
		from(
			select id_player as id_jogador, id_game, pontuacao_mj as pontuacao, nmr_seq_partida from joga_mj where id_game = '9876543210'
			union 
			select id_player, id_game, pontuacao_n, nmr_seq_partida from normal where id_game = '9876543210'
		) as TODOSJOGOS;
end;
$$ 	language plpgsql;

select PontosJogoPorJogador('9876543210')
	