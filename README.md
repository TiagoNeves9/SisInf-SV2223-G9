# SisInf-SV2223-G9

# PRIMEIRA FASE

Resultados pretendidos
Tendo em conta os objetivos de aprendizagem, deverão ser produzidos os seguintes resultados:
1. O modelo de dados (conceptual e relacional), incluindo todas as restrições de integridade;
2. O código PL/pgSQL que permite:

~(a) Criar o modelo físico (1 script autónomo);~
~(b) Remover o modelo físico (1 script autónomo);~<br>
(c) Preenchimento inicial da base de dados (1 script autónomo);<br>
(d) Criar os mecanismos que permitam criar o jogador, dados os seus email e username, desativar e banir o jogador;<br>
# (e) Criar a função totalPontosJogador que recebe como parâmetro o identificador de um jogador e devolve o número total de pontos obtidos pelo jogador.
# (f) Criar a função totalJogosJogador que recebe como parâmetro o identificador de um jogador e devolve o número total de jogos diferentes nos quais o jogador participou.
# (g) Criar a função PontosJogoPorJogador que recebe como parâmetro a referência de um jogo<br> e devolve uma tabela com duas colunas (identificador de jogador, total de pontos) em que cada linha contém<br> o identificador de um jogador e o total de pontos que esse jogador teve nesse jogo.<br> Apenas devem ser devolvidos os jogadores que tenham jogado o jogo.
# (h) Criar o procedimento armazenado associarCrachá que recebe como parâmetros<br> o identificador de um jogador, a referência de um jogo e o nome de um crachá desse jogo e<br> atribui o crachá a esse jogador se ele reunir as condições para o obter.
# (i) Criar o procedimento armazenado iniciarConversa que permite iniciar uma conversa (chat) dados o identificador de um jogador e o nome da conversa. O jogador deve ficar automaticamente associado à conversa e deve ser criada uma mensagem a informar que o jogador criou a conversa. O procedimento deve devolver num parâmetro de saída o identificador da conversa criada.
# (j) Criar o procedimento armazenado juntarConversa que recebe como parâmetros os identificadores de um jogador e de uma conversa e junta esse jogador a essa conversa. Deve ser criada uma mensagem a informar que o jogador entrou na conversa.
# (k) Criar o procedimento armazenado enviarMensagem que recebe como parâmetros os identificadores de um jogador e de uma conversa e o texto de uma mensagem e procede ao envio dessa mensagem para a conversa indicada, associando-a ao jogador também indicado.
# (l) Criar a vista jogadorTotalInfo que permita aceder à informação sobre identificador, estado, email, username, número total de jogos em que participou, número total de partidas em que participou e número total de pontos que já obteve de todos os jogadores cujo estado seja diferente de “Banido”. Deve implementar na vista os cálculos sem aceder às tabelas de estatísticas.
# (m) Criar os mecanismos necessários para que, de forma automática, quando uma partida termina, se proceda à atribuição de crachás do jogo a que ela pertence.
# (n) Criar os mecanismos necessários para que a execução da instrução DELETE sobre a vista jogadorTotalInfo permita colocar os jogadores envolvidos no estado “Banido”.
# (o) Criar um script autónomo com os testes das funcionalidades de 2d a 2n para cenários normais e de erro. Este script, ao ser executado, deve listar, para cada teste, o seu nome e indicação se ele correu ou não com sucesso;<br> Ex: “teste 1: Inserir jogador com dados bem passados: Resultado OK”<br>Ou caso falhe: “teste 1: Inserir Cliente com dados bem passados: Resultado FAIL”
# Nota:<br> Todos os procedimentos armazenados devem ter tratamento de erros e gestão transacional utilizando o nível de isolamento adequado.