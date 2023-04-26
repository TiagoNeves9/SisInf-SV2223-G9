# SisInf-SV2223-G9

# PRIMEIRA FASE

Resultados pretendidos
Tendo em conta os objetivos de aprendizagem, deverão ser produzidos os seguintes resultados:
1. O modelo de dados (conceptual e relacional), incluindo todas as restrições de integridade;
2. O código PL/pgSQL que permite:

(f) Criar a função totalJogosJogador que recebe como parâmetro o identificador de um jogador e devolve o número total de jogos diferentes nos quais o jogador participou.<br>
(i) Criar o procedimento armazenado iniciarConversa que permite iniciar uma conversa (chat) dados o identificador de um jogador e o nome da conversa. O jogador deve ficar automaticamente associado à conversa e deve ser criada uma mensagem a informar que o jogador criou a conversa. O procedimento deve devolver num parâmetro de saída o identificador da conversa criada.<br>
(j) Criar o procedimento armazenado juntarConversa que recebe como parâmetros os identificadores de um jogador e de uma conversa e junta esse jogador a essa conversa. Deve ser criada uma mensagem a informar que o jogador entrou na conversa.<br>
(k) Criar o procedimento armazenado enviarMensagem que recebe como parâmetros os identificadores de um jogador e de uma conversa e o texto de uma mensagem e procede ao envio dessa mensagem para a conversa indicada, associando-a ao jogador também indicado.<br>
(l) Criar a vista jogadorTotalInfo que permita aceder à informação sobre identificador, estado, email, username, número total de jogos em que participou, número total de partidas em que participou e número total de pontos que já obteve de todos os jogadores cujo estado seja diferente de “Banido”. Deve implementar na vista os cálculos sem aceder às tabelas de estatísticas.<br>
(m) Criar os mecanismos necessários para que, de forma automática, quando uma partida termina, se proceda à atribuição de crachás do jogo a que ela pertence.<br>
(n) Criar os mecanismos necessários para que a execução da instrução DELETE sobre a vista jogadorTotalInfo permita colocar os jogadores envolvidos no estado “Banido”.<br>
(o) Criar um script autónomo com os testes das funcionalidades de 2d a 2n para cenários normais e de erro. Este script, ao ser executado, deve listar, para cada teste, o seu nome e indicação se ele correu ou não com sucesso;<br> Ex: “teste 1: Inserir jogador com dados bem passados: Resultado OK”<br>Ou caso falhe: “teste 1: Inserir Cliente com dados bem passados: Resultado FAIL”<br>
Nota:<br> Todos os procedimentos armazenados devem ter tratamento de erros e gestão transacional utilizando o nível de isolamento adequado.<br>