create table JOGADORES
(
	id INT not null unique,
	email VARCHAR(30) not null unique,
	username VARCHAR(30) not null unique,
	primary key (id)
);

create table JOGOS
(
	nome VARCHAR(30) not null unique,
	ref_alfanumerica VARCHAR(10),
	url VARCHAR(30),
	primary key (nome)
);

create table PARTIDA
(
	nr_sequencial INT not null unique,
	/*dt / hr de inicio e de fim por definir o tipo*/
	primary key (nr_sequencial)
);

create table REGIAO
(
	nome VARCHAR(10)
);

create table CONVERSAS
(
	nome VARCHAR(30),
	identificador INT,
	primary key (identificador)
);

create table MENSAGENS
(
	nr_ordem INT,
	dat VARCHAR(30),
	hora INT,
	texto VARCHAR(50),
	id INT,
	primary key (nr_ordem),
	foreign key (id) references CONVERSAS(identificador)
);

create table NORMAL
(
	grau INT,
	pontucao INT,
	nrPartida INT,
	foreign key (nrPartida) references PARTIDA(nr_sequencial)
);

create table MULTIJOGADOR
(
	pontuações INT,
	nrPartida INT,
	foreign key (nrPartida) references PARTIDA(nr_sequencial)
);

create table CRACHAS
(
	nome VARCHAR(30),
	limite_pontos INT,
	url VARCHAR(30),
	nome_jogo VARCHAR(30),
	primary key (nome),
	foreign key (nome_jogo) references JOGOS(nome)
);