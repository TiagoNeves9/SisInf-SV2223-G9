CREATE TRIGGER excluirVista
INSTEAD OF DELETE ON jogadorTotalInfo
FOR EACH ROW
EXECUTE FUNCTION excluirVista();

CREATE OR REPLACE FUNCTION excluirVista()
RETURNS TRIGGER AS $$

BEGIN
--Dar update na tabela de jogadores na coluna estado_player, colocando o valor 'Banido'
UPDATE jogadores
SET estado_player = 'Banido'
WHERE id_player IN (SELECT id_player FROM jogadorTotalInfo);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DELETE FROM jogadorTotalInfo;