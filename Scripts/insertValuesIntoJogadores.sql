
CREATE OR REPLACE FUNCTION insertJogador(id INT, email varchar(30), username varchar(30)) RETURNS void AS $$
           insert into jogadores  values (id , email , username);
$$ LANGUAGE SQL;

drop function if exists insertJogador;

select insertJogador(99, 'tiago@email.com', 'thiagolk');