--Inserting on table "JOGOS"
insert into jogos values( 'Call Of Duty', '0123456789', 'https://www.callofduty.com/pt');
insert into jogos values('Fifa 23', '9876543210', 'https://www.ea.com/pt-br/games/fifa/fifa-23');
insert into jogos values('Fortnite', '22222bbbbb', 'https://www.fortnite.com/?lang=pt-BR');
insert into jogos values('Counter-Strike: Global Offensive', 'abcdefghij', 'https://www.counter-strike.net/news');

--Inserting on table "REGIAO"
insert into regiao values('Central/West Europe');
insert into regiao values('Africa');
insert into regiao values('Oceania');
insert into regiao values('North America');
insert into regiao values('South America');
insert into regiao values('West Europe');
insert into regiao values('Asia');

--Inserting on table "JOGADORES"
insert into jogadores(email, username, estado_player, nome_regiao) values('vascobranco13@gmail.com' , 'Vascão', 'Ativo' , 'Central/West Europe' );
insert into jogadores(email, username, estado_player, nome_regiao) values('joao@gmail.com' , 'Messi de Olhão', 'Ativo' , 'West Europe' );
insert into jogadores(email, username, estado_player, nome_regiao) values('Tiago@gmail.com' , 'Cavani', 'Ativo' , 'Asia' );
insert into jogadores(email, username, estado_player, nome_regiao) values('José@gmail.com' , 'Toras', 'Inativo' , 'Africa' );
insert into jogadores(email, username, estado_player, nome_regiao) values('Ricardo@gmail.com' , 'Rodnocka', 'Banido' , 'Oceania' );
insert into jogadores(email, username, estado_player, nome_regiao) values('Batista@gmail.com' , 'Tareko', 'Banido' , 'North America' );
insert into jogadores(email, username, estado_player, nome_regiao) values('Gonçalo@gmail.com' , 'Gonguinhas', 'Inativo' , 'South America' );

--Inserting on table "Crachas"
insert into crachas values('0123456789', 'Call Of Duty', 'Test Drive', 'https://www.trueachievements.com/a374283/test-drive-achievement' , 20 );
insert into crachas values('0123456789', 'Call Of Duty' , 'Gunless' , 'https://www.trueachievements.com/a374282/gunless-achievement' , 15 );
insert into crachas values('9876543210', 'Fifa 23' , 'Teamwork works' , 'https://www.trueachievements.com/a368522/teamwork-works-achievement' , 45 );
insert into crachas values('9876543210', 'Fifa 23' ,'Fresh fit' , 'https://www.trueachievements.com/a368523/fresh-fit-achievement' , 10 );
insert into crachas values('22222bbbbb', 'Fortnite' , 'Gunsmith' , 'https://www.trueachievements.com/a236827/gunsmith-achievement' , 20 );
insert into crachas values('22222bbbbb', 'Fortnite' , 'Some Sort of Rocket' , 'https://www.trueachievements.com/a236825/some-sort-of-rocket-achievement' , 15 );
insert into crachas values('abcdefghij', 'Counter-Strike: Global Offensive' , 'God of War' , 'https://www.trueachievements.com/a166964/god-of-war-achievement' , 22);
insert into crachas values('abcdefghij', 'Counter-Strike: Global Offensive' , 'Awardist' , 'https://www.trueachievements.com/a166965/awardist-achievementt' , 16);

--Inserting on table "CONVERSAS"
insert into conversas(nome_conversa) values('Grupo de cod');
insert into conversas(nome_conversa) values('Grupo de cs');
insert into conversas(nome_conversa) values('Grupo de fifa');
insert into conversas(nome_conversa) values('Grupo de fortnite');

--Inserting on table "COMPRAR"
insert into comprar values('0123456789', 'Call Of Duty', 1008, 'Vascão' , 'vascobranco13@gmail.com' , '2023-04-07', 79.99);
insert into comprar values('9876543210', 'Fifa 23', 1008, 'Vascão' , 'vascobranco13@gmail.com', '2023-04-07', 59.99);
insert into comprar values('22222bbbbb', 'Fortnite', 1009, 'Messi de Olhão' , 'joao@gmail.com', '2023-01-01', 0);
insert into comprar values('abcdefghij', 'Counter-Strike: Global Offensive', 1012, 'Rodnocka', 'Ricardo@gmail.com', '2022-05-05', 0);

--Inserting on table "MENSAGENS"
insert into mensagens values( 100000, 0 , 'Olá' , 0 , '2023-04-04');
insert into mensagens values( 100000, 1 , 'Tudo bem?' , 0 ,  '2023-04-04');
insert into mensagens values( 100002, 0 , 'querem jogar um ranked?' , 3 ,  '2022-07-09');
insert into mensagens values( 100003, 0 , 'ganhei 5 jogos seguidos!' ,2 ,  '2010-02-07');

--Inserting on table ""

select * from jogos