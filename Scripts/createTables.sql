create table REGIAO
(
	nome_regiao VARCHAR(10),
	primary key (nome_regiao)
);

create table JOGADORES
(
	id_player INT not null unique,
	email VARCHAR(30) not null unique,
	username VARCHAR(30) not null unique,
	estado_player VARCHAR(30),
	nome_regiao VARCHAR(10),
	primary key (id_player, username, email ),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table JOGOS
(
	nome_game VARCHAR(30) not null unique,
	id_game INT,
	url VARCHAR(30),
	primary key (nome_game, id_game)
);


create table CONVERSAS
(
	nome_conversa VARCHAR(30),
	id_conversa INT,
	primary key (id_conversa)
);

create table NORMAL
(
	nome_regiao VARCHAR(10),
	id_game INT,
	nome_game VARCHAR(30),
	nmr_seq_partida INT,
	estado_partida VARCHAR(30),
	data_hora_inicio DATE,
	data_hora_fim DATE,
	pontuacao_n INT,
	id_player INT,
	username VARCHAR(30),
	email VARCHAR(30),
	grau_dificuldade INT,
	primary key (nome_regiao, id_game, nome_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
	
);

create table MULTIJOGADOR
(
	nome_regiao VARCHAR(30),
	id_game INT,
	nome_game VARCHAR(30),
	nmr_seq_partida INT,
	estado_partida VARCHAR(30),
	data_hora_inicio DATE,
	data_hora_fim DATE,
	id_player INT,
	username VARCHAR(30),
	email VARCHAR(30),
	primary key (nome_regiao, id_game, nome_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
	
);


create table JOGA_MJ
(
	nmr_seq_partida INT,
	id_game INT,
	nome_regiao VARCHAR(30),
	nome_game VARCHAR(30),
	id_player INT,
	username VARCHAR(30),
	email VARCHAR(30),
	pontuacao_mj INT,
	primary key (nmr_seq_partida, id_player, username, email, id_game, nome_regiao, nome_game),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (nmr_seq_partida, id_game, nome_regiao, nome_game) references MULTIJOGADOR(nmr_seq_partida, id_game, nome_regiao, nome_game)
	
);

create table COMPRAR
(
	id_game INT,
	nome_game VARCHAR(30),
	id_player INT,
	username VARCHAR(30),
	email VARCHAR(30),
	data_compra DATE,
	preco INT,
	primary key (id_game, nome_game, id_player, username, email),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game)
	
); 

create table ESTATISTICAS_JOGO
(
	id_game INT,
	nome_game VARCHAR(30),
	total_pontos_game INT,
	nmr_players INT,
	nmr_partidas_game INT,
	primary key (id_game, nome_game),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game)
);


create table ESTATISTICAS_JOGADORES
(
	id_player INT,
	username VARCHAR(30),
	email VARCHAR(30),
	nmr_partidas_player INT,
	nmr_jogos INT,
	total_pontos_player INT,
	primary key (id_player, username, email),
	foreign key (id_player, username, email) references JOGADORES(id_player, username, email)
);

create table MENSAGENS
(
	id_conversa INT,
	nmr_seq_msg INT,
	texto VARCHAR(50),
	remetente VARCHAR(30),
	data_hora_msg DATE,
	primary key (id_conversa, nmr_seq_msg),
	foreign key (id_conversa) references CONVERSAS(id_conversa)
);

create table CRACHAS
(
	id_game INT,
	nome_game VARCHAR(30),
	nome_cracha VARCHAR(30),
	url VARCHAR(30),
	limite_pontos INT,
	primary key (id_game, nome_game, nome_cracha),
	foreign key (id_game, nome_game) references JOGOS(id_game, nome_game)
);
