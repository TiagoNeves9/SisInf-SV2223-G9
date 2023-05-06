create type estado_player as enum ('Ativo', 'Inativo', 'Banido');
create type estado_partida as enum ('Por iniciar', 'A aguardar jogadores', 'Em curso', 'Terminada');


create table REGIAO(
	nome_regiao VARCHAR(40),
	primary key (nome_regiao)
);

create table JOGADORES(
	id_player INT GENERATED ALWAYS AS IDENTITY (START WITH 1000),
	email VARCHAR(40) unique not null,
	username VARCHAR(40) unique not null,
	estado_player estado_player not null,
	nome_regiao VARCHAR(40) not null,
	primary key (id_player),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table JOGOS(
	id_game CHAR(10) CONSTRAINT id_size_check CHECK (id_game ~* '^[A-Z0-9]+$'),
	nome_game VARCHAR(40),
	url VARCHAR(80) not null, -- check if is an URL
	primary key (id_game)
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
	nmr_seq_partida INT,
	estado_partida estado_partida not null,
	data_hora_inicio TIMESTAMP,
	data_hora_fim TIMESTAMP,
	pontuacao_n INT not null,
	id_player INT,
	grau_dificuldade INT not null check (grau_dificuldade between 1 and 5),
	primary key (nome_regiao, id_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game) references JOGOS(id_game),
	foreign key (id_player) references JOGADORES(id_player),
	
	constraint normal_datas
		check(
			(	
				(estado_partida = 'Por iniciar' or estado_partida = 'A aguardar jogadores')
			 	and data_hora_inicio is null and data_hora_fim is null
			)	
			or
			(	
				estado_partida = 'Em curso'
			 	and	data_hora_inicio is not null and data_hora_fim is null
			)	
			or
			(
			 	estado_partida = 'Terminada'
				and data_hora_inicio is not null and data_hora_fim is not null
				and data_hora_inicio < data_hora_fim
			)
		)
);

create table MULTIJOGADOR(
	nome_regiao VARCHAR(40),
	id_game CHAR(10),
	nmr_seq_partida INT,
	estado_partida estado_partida not null,
	data_hora_inicio TIMESTAMP,
	data_hora_fim TIMESTAMP,
	id_player INT,
	primary key (nome_regiao, id_game, nmr_seq_partida),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_game) references JOGOS(id_game),
	foreign key (id_player) references JOGADORES(id_player),

	constraint multijogador_datas
		check(
			(	
				(estado_partida = 'Por iniciar' or estado_partida = 'A aguardar jogadores')
			 	and data_hora_inicio is null and data_hora_fim is null
			)	
			or
			(	
				estado_partida = 'Em curso'
			 	and	data_hora_inicio is not null and data_hora_fim is null
			)	
			or
			(
			 	estado_partida = 'Terminada'
				and data_hora_inicio is not null and data_hora_fim is not null
				and data_hora_inicio < data_hora_fim
			)
		)
);

create table JOGA_MJ(
	nmr_seq_partida INT,
	id_game CHAR(10),
	nome_regiao VARCHAR(40),
	id_player INT,
	pontuacao_mj INT not null,
	primary key (nmr_seq_partida, id_player, id_game, nome_regiao),
	foreign key (id_player) references JOGADORES(id_player),
	foreign key (nmr_seq_partida, id_game, nome_regiao) references MULTIJOGADOR(nmr_seq_partida, id_game, nome_regiao)
);

create table COMPRAR(
	id_game CHAR(10),
	id_player INT,
	nome_regiao VARCHAR(40),
	data_compra TIMESTAMP with TIME ZONE not null,
	preco real not null,
	primary key (id_game, id_player, nome_regiao),
	foreign key (id_player) references JOGADORES(id_player),
	foreign key (id_game) references JOGOS(id_game),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table ESTATISTICAS_JOGO(
	id_game CHAR(10),
	nmr_partidas_game INT not null,
	nmr_players INT not null,
	total_pontos_game INT not null,
	primary key (id_game),
	foreign key (id_game) references JOGOS(id_game)
);

create table ESTATISTICAS_JOGADORES(
	id_player INT,
	nmr_partidas_player INT not null,
	nmr_jogos INT not null,
	total_pontos_player INT not null,
	primary key (id_player),
	foreign key (id_player) references JOGADORES(id_player)
);

create table CRIAR(
	id_player INT,
	nome_regiao VARCHAR(40),
	id_conversa INT,
	primary key (id_player, nome_regiao, id_conversa),
	foreign key (id_player) references JOGADORES(id_player),
	foreign key (nome_regiao) references REGIAO(nome_regiao),
	foreign key (id_conversa) references CONVERSAS(id_conversa)
);

create table MENSAGENS(
	id_conversa INT,
	nmr_seq_msg INT,
	texto VARCHAR(500) not null,
	remetente INT not null,
	regiao_remetente VARCHAR(40) not null,
	data_hora_msg TIMESTAMP with TIME ZONE not null
		default timezone('Europe/Lisbon', current_timestamp),	
	primary key (id_conversa, nmr_seq_msg),
	foreign key (id_conversa) references CONVERSAS(id_conversa),
	foreign key (id_conversa, remetente, regiao_remetente) references CRIAR(id_conversa, id_player, nome_regiao)
);

create table CRACHAS(
	id_game CHAR(10),
	nome_cracha VARCHAR(40),
	url VARCHAR(80) not null,
	limite_pontos INT not null	,
	primary key (id_game, nome_cracha),
	foreign key (id_game) references JOGOS(id_game)
);

create table TEM(
	id_player INT,
	nome_cracha VARCHAR(40),
	id_game CHAR(10),
	nome_regiao VARCHAR(40),
    primary key (id_player, nome_cracha, id_game, nome_regiao),
	foreign key (id_player) references JOGADORES(id_player),
	foreign key (nome_cracha, id_game) references CRACHAS(nome_cracha, id_game),
	foreign key (nome_regiao) references REGIAO(nome_regiao)
);

create table AMIGO(
	id_player1 INT,
	nome_regiao1 VARCHAR(40),
	id_player2 INT,
	nome_regiao2 VARCHAR(40),
	primary key (id_player1, nome_regiao1, id_player2, nome_regiao2),
	foreign key (id_player1) references JOGADORES(id_player),
	foreign key (id_player2) references JOGADORES(id_player),
	foreign key (nome_regiao1) references REGIAO(nome_regiao),
	foreign key (nome_regiao2) references REGIAO(nome_regiao)
);
