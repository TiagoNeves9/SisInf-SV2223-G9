--(n) 	Criar os mecanismos necessários para que a execução da instrução DELETE sobre a vista
--		jogadorTotalInfo permita colocar os jogadores envolvidos no estado “Banido”.


set transaction isolation level read uncommitted;
CREATE TRIGGER excluirVista
INSTEAD OF DELETE ON jogadorTotalInfo
FOR EACH ROW
EXECUTE FUNCTION excluirVista();


CREATE OR REPLACE FUNCTION excluirVista()
RETURNS TRIGGER 
AS $$

BEGIN
	--Dar update na tabela de jogadores na coluna estado_player, colocando o valor 'Banido'
	UPDATE jogadores
	SET estado_player = 'Banido'
	WHERE id_player IN (SELECT id_player FROM jogadorTotalInfo);
		RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DELETE FROM jogadorTotalInfo;
select * from jogadores;