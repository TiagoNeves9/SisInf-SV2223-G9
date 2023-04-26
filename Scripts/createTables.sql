create type estado_player as enum ('Ativo', 'Inativo', 'Banido');
create type estado_partida as enum ('Por iniciar', 'A aguardar jogadores', 'Em curso', 'Terminada');


create table REGIAO(
	nome_regiao VARCHAR(40),
	primary key (nome_regiao)
);

create table JOGADORES(
	id_player INT GENERATED ALWAYS AS IDENTITY (START WITH 1000),
	email VARCHAR(40),
	username VARCHAR(40),
	estado_player estado_player not null,
	nome_regiao VARCHAR(40) not null,
	primary key (id_player, username, email),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table JOGOS(
	nome_game VARCHAR(40),
	id_game CHAR(10) CONSTRAINT id_size_check CHECK (id_game ~* '^[A-Z0-9]+$'),
	url VARCHAR(80) not null, -- check if is an URL
	primary key (nome_game, id_game)
);

create table CONVERSAS(
	id_conversa INT GENERATED ALWAYS AS IDENTITY (START WITH 100000),
	nome_conversa VARCHAR(40) not null,
	primary key (id_conversa)
	-- COMO É QUE VAMOS BUSCAR OS IDS DAS VÁRIAS PESSOAS ENVOLVIDAS
	-- EM CADA CONVERSA PARA NAS MENSAGENS METER O REMETENTE
);

create table NORMAL(
	nome_regiao VARCHAR(40),
	id_game CHAR(10),
	nome_game VARCHAR(40),
	nmr_seq_partida SERIAL,
	estado_partida estado_partida not null,
	data_hora_inicio DATE not null,		-- check if this is the correct type
	data_hora_fim DATE not null,		-- check if this is the correct type
	pontuacao_n INT not null,
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	grau_dificuldade INT not null check (grau_dificuldade between 1 and 5),
	primary key (nome_regiao, id_game, nome_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
);

create table MULTIJOGADOR(
	nome_regiao VARCHAR(40),
	id_game CHAR(10),
	nome_game VARCHAR(40),
	nmr_seq_partida SERIAL,
	estado_partida estado_partida not null,
	data_hora_inicio DATE not null,		-- check if this is the correct type
	data_hora_fim DATE not null,		-- check if this is the correct type
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	primary key (nome_regiao, id_game, nome_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
);

create table JOGA_MJ(
	nmr_seq_partida INT,
	id_game CHAR(10),
	nome_game VARCHAR(40),
	nome_regiao VARCHAR(40),
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	pontuacao_mj INT not null,
	primary key (nmr_seq_partida, id_player, username, email, id_game, nome_game, nome_regiao),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (nmr_seq_partida, id_game, nome_game, nome_regiao) references MULTIJOGADOR(nmr_seq_partida, id_game, nome_game, nome_regiao)
);

create table COMPRAR(
	id_game CHAR(10),
	nome_game VARCHAR(40),
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	nome_regiao VARCHAR(40),
	data_compra DATE not null,		-- check if this is the correct type
	preco real not null,
	primary key (id_game, nome_game, id_player, username, email, nome_regiao),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table ESTATISTICAS_JOGO(
	id_game CHAR(10),
	nome_game VARCHAR(40),
	total_pontos_game INT not null,		--ACHO que tem de ser uma função que calcula em vez de ser uma coluna
	nmr_players INT not null,
	nmr_partidas_game INT not null,
	primary key (id_game, nome_game),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game)
);

create table ESTATISTICAS_JOGADORES(
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	nome_regiao VARCHAR(40),
	total_pontos_player INT not null,	--ACHO que tem de ser uma função que calcula em vez de ser uma coluna
	nmr_jogos INT not null,
	nmr_partidas_player INT not null,
	primary key (id_player, username, email),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
);

create table MENSAGENS(
	id_conversa SERIAL,
	nmr_seq_msg INT,
	texto VARCHAR(500) not null,
	remetente INT not null,
	data_hora_msg DATE not null,		-- check if this is the correct type
	primary key (id_conversa, nmr_seq_msg),
	foreign key (id_conversa) references CONVERSAS(id_conversa)
);

create table CRACHAS(
	id_game CHAR(10),
	nome_game VARCHAR(40),
	nome_cracha VARCHAR(40),
	url VARCHAR(80) not null,
	limite_pontos INT not null	,
	primary key (id_game, nome_game, nome_cracha),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game)
);

create table CRIAR(
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	nome_regiao VARCHAR(40),
	id_conversa INT ,
	primary key (id_player, username, email, nome_regiao, id_conversa),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_conversa) references CONVERSAS(id_conversa)
);

create table TEM(
	id_player INT,
	username VARCHAR(40),
	email VARCHAR(40),
	nome_cracha VARCHAR(40),
	id_game CHAR(10),
	nome_game VARCHAR(40),
	nome_regiao VARCHAR(40),
    primary key (id_player, username, email, nome_cracha, id_game, nome_game, nome_regiao),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (nome_cracha, id_game, nome_game) references CRACHAS(nome_cracha, id_game, nome_game),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table AMIGO(
	id_player1 INT,
	username1 VARCHAR(40),
	email1 VARCHAR(40),
	nome_regiao1 VARCHAR(40),
	id_player2 INT,
	username2 VARCHAR(40),
	email2 VARCHAR(40),
	nome_regiao2 VARCHAR(40),
	primary key (id_player1, username1, email1, nome_regiao1, id_player2, username2, email2, nome_regiao2),
	foreign key (id_player1, username1, email1) references JOGADORES(id_player, username, email),
	foreign key (id_player2, username2, email2) references JOGADORES(id_player, username, email),
	foreign key (nome_regiao1) references REGIAO(nome_regiao),
	foreign key (nome_regiao2) references REGIAO(nome_regiao)
);
