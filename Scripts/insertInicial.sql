--Inserting on table "REGIAO"
insert into regiao values('Central/West Europe');
insert into regiao values('Africa');
insert into regiao values('Oceania');
insert into regiao values('North America');
insert into regiao values('South America');
insert into regiao values('West Europe');
insert into regiao values('Asia');

--Inserting on table "JOGADORES"
insert into jogadores(email, username, estado_player, nome_regiao) values('vascobranco13@gmail.com', 'Vascão', 'Ativo', 'Central/West Europe');
insert into jogadores(email, username, estado_player, nome_regiao) values('joao@gmail.com', 'Messi de Olhão', 'Ativo', 'West Europe');
insert into jogadores(email, username, estado_player, nome_regiao) values('Tiago@gmail.com', 'Cavani', 'Ativo', 'Asia');
insert into jogadores(email, username, estado_player, nome_regiao) values('José@gmail.com', 'Toras', 'Inativo', 'Africa');
insert into jogadores(email, username, estado_player, nome_regiao) values('Ricardo@gmail.com', 'Rodnocka', 'Banido', 'Oceania');
insert into jogadores(email, username, estado_player, nome_regiao) values('Batista@gmail.com', 'Tareko', 'Banido', 'North America');
insert into jogadores(email, username, estado_player, nome_regiao) values('Gonçalo@gmail.com', 'Gonguinhas', 'Inativo', 'South America');

--Inserting on table "JOGOS"
insert into jogos values( 'Call Of Duty', '0123456789', 'https://www.callofduty.com/pt');
insert into jogos values('Fifa 23', '9876543210', 'https://www.ea.com/pt-br/games/fifa/fifa-23');
insert into jogos values('Fortnite', '22222bbbbb', 'https://www.fortnite.com/?lang=pt-BR');
insert into jogos values('Counter-Strike: Global Offensive', 'abcdefghij', 'https://www.counter-strike.net/news');

--Inserting on table "CONVERSAS"
insert into conversas(nome_conversa) values('Grupo de cod');
insert into conversas(nome_conversa) values('Grupo de cs');
insert into conversas(nome_conversa) values('Grupo de fifa');
insert into conversas(nome_conversa) values('Grupo de fortnite');

--Inserting on table "NORMAL"
insert into normal values(
		'Oceania', '0123456789', 'Call Of Duty', 0, 'Por iniciar', 
		null, null, 100, 1000, 3
	);
insert into normal values(
		'Oceania', '0123456789', 'Call Of Duty', 1, 'Por iniciar',
		null, null, 150, 1000, 3
	);	
insert into normal values(
		'West Europe', '9876543210', 'Fifa 23', 0, 'Em curso', 
		'2023-04-17 03:02:57', null, 3, 1002, 5
	);
insert into normal values(
		'West Europe', '9876543210', 'Fifa 23', 1, 'Em curso', 
		'2023-04-17', null, 99999, 1002, 1
	);
insert into normal values(
		'West Europe', 'abcdefghij', 'Counter-Strike: Global Offensive', 0, 'Terminada', 
		'2023-04-11 23:58', '2023-04-12 01:02:14', 5000, 1001, 5
	);

--Inserting on table "MULTIJOGADOR"
insert into multijogador values(
		'Central/West Europe', '0123456789', 'Call Of Duty', 0, 'Em curso', 
		'2021-03-05 11:15', null, 1000
	);
insert into multijogador values(
		'West Europe', '9876543210', 'Fifa 23', 0, 'Em curso', 
		'2020-03-15 13:32:03', null, 1001
	);
insert into multijogador values(
		'Oceania', '22222bbbbb', 'Fortnite', 0, 'Terminada', 
		'2023-03-15', '2023-03-19 02:00:01', 1004
	);
insert into multijogador values(
		'North America', 'abcdefghij', 'Counter-Strike: Global Offensive', 0, 
		'A aguardar jogadores', null, null, 1006
	);
insert into multijogador values(
		'Central/West Europe', '0123456789', 'Call Of Duty', 1, 'Em curso', 
		'2021-03-21 19:45:07', null, 1000
	);
insert into multijogador values(
		'West Europe', '9876543210', 'Fifa 23', 1, 'Em curso', 
		'2020-03-15 13:32:03', null, 1002
	);	

--Inserting on table "JOGA_MJ"
insert into joga_mj values(
	0, 'abcdefghij', 'Counter-Strike: Global Offensive', 
	'North America', 1006, 403
);
insert into joga_mj values(
	0, '22222bbbbb', 'Fortnite', 
	'Oceania', 1004, 50001
);
insert into joga_mj values(
	0, '0123456789', 'Call Of Duty', 
	'Central/West Europe', 1000, 4321
);
insert into joga_mj values(
	1, '0123456789', 'Call Of Duty', 
	'Central/West Europe', 1000, 250
);
insert into joga_mj values(
	0, '9876543210', 'Fifa 23', 
	'West Europe', 1001, 59999
);
insert into joga_mj values(
	1, '9876543210', 'Fifa 23', 
	'West Europe', 1002, 40000
);

--Inserting on table "COMPRAR"
insert into comprar values('0123456789', 'Call Of Duty', 1000, 'Central/West Europe', '2023-04-07', 79.99);
insert into comprar values('9876543210', 'Fifa 23', 1000, 'Central/West Europe', '2023-04-07', 59.99);
insert into comprar values('22222bbbbb', 'Fortnite', 1001, 'Africa', '2023-01-01', 0);
insert into comprar values('abcdefghij', 'Counter-Strike: Global Offensive', 1004, 'Oceania', '2022-05-05', 0);

--Inserting on table "ESTATISTICAS_JOGO"
insert into estatisticas_jogo values('0123456789', 'Call Of Duty', 10000, 32, 6);
insert into estatisticas_jogo values('9876543210', 'Fifa 23', 45322, 20, 10);
insert into estatisticas_jogo values('22222bbbbb', 'Fortnite', 99999, 32, 2);
insert into estatisticas_jogo values('abcdefghij', 'Counter-Strike: Global Offensive', 8000, 10, 1);

--Inserting on table "ESTATISTICAS_JOGADORES"
insert into estatisticas_jogadores values(1000, 'Central/West Europe', 100, 5, 2500);
insert into estatisticas_jogadores values(1001, 'Africa', 80, 2, 753);
insert into estatisticas_jogadores values(1002, 'Asia', 44, 8, 55000);
insert into estatisticas_jogadores values(1003, 'Africa', 33, 1, 2000);
insert into estatisticas_jogadores values(1004, 'Oceania', 400, 4, 3678);

--Inserting on table "CRIAR"
insert into criar values(1000, 'Central/West Europe', 100000);
insert into criar values(1001, 'West Europe', 100000);
insert into criar values(1000, 'Central/West Europe', 100001);
insert into criar values(1001, 'West Europe', 100002);
insert into criar values(1003, 'Africa', 100003);

--Inserting on table "MENSAGENS"
insert into mensagens values(100000, 0, 'Olá', 1000, 'Central/West Europe', '2023-04-04');
insert into mensagens values(100000, 1, 'Tudo bem?', 1000, 'Central/West Europe', '2023-04-04');
insert into mensagens values(100002, 0, 'querem jogar um ranked?', 1001, 'West Europe', '2022-07-09');
insert into mensagens values(100003, 0, 'ganhei 5 jogos seguidos!', 1003, 'Africa', '2010-02-07');
insert into mensagens values(100000, 2, 'Tudo', 1001, 'West Europe'); --Insert com a data passada por default (current_timestamp)

--Inserting on table "CRACHAS"
insert into crachas values('0123456789', 'Call Of Duty', 'Test Drive', 'https://www.trueachievements.com/a374283/test-drive-achievement' , 20 );
insert into crachas values('0123456789', 'Call Of Duty' , 'Gunless' , 'https://www.trueachievements.com/a374282/gunless-achievement' , 15 );
insert into crachas values('9876543210', 'Fifa 23' , 'Teamwork works' , 'https://www.trueachievements.com/a368522/teamwork-works-achievement' , 45 );
insert into crachas values('9876543210', 'Fifa 23' ,'Fresh fit' , 'https://www.trueachievements.com/a368523/fresh-fit-achievement' , 10 );
insert into crachas values('22222bbbbb', 'Fortnite' , 'Gunsmith' , 'https://www.trueachievements.com/a236827/gunsmith-achievement' , 20 );
insert into crachas values('22222bbbbb', 'Fortnite' , 'Some Sort of Rocket' , 'https://www.trueachievements.com/a236825/some-sort-of-rocket-achievement' , 15 );
insert into crachas values('abcdefghij', 'Counter-Strike: Global Offensive' , 'God of War' , 'https://www.trueachievements.com/a166964/god-of-war-achievement' , 22);
insert into crachas values('abcdefghij', 'Counter-Strike: Global Offensive' , 'Awardist' , 'https://www.trueachievements.com/a166965/awardist-achievementt' , 16);

--Inserting on table "TEM"
insert into tem values(1001, 'Test Drive', '0123456789', 'Call Of Duty', 'West Europe');
insert into tem values(1001, 'Gunless', '0123456789', 'Call Of Duty', 'West Europe');

--Inserting on table "AMIGO"
insert into amigo values(1001, 'Africa', 1000, 'Central/West Europe');
insert into amigo values(1001, 'Africa', 1003, 'Africa');