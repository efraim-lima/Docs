**TEMAS**

========================
Processo de Forense no Linux
========================
Como coletar dados para iniciar uma investigação e perícia forense em ambientes Linux
------------------------


INTRO
#######################

Aqui veremos algumas ferramentas que podemos utilizar para fazer um processo de análise forense em máquinas Linux (ou seja, boa parte dos sistemas presentes em servidores ao redor do mundo). 
Agora, vamos começar o processo de aprendizado em ferramentas forenses para servidores Linux? 
Precisaremos coletar e compilar o máximo de informações sobre o sistema que precisa ser periciado. Para isso teremos alguns passos a seguir que trarão iformações diferentes.

LEVANTAMENTO DE INFORMAÇÕES
##########################

Primeiro vamos levantar os detalhes de nosso sistema operacional com o comando ``uname -a``. Com este commando vamos extrair alguns detalhes sobre o sistema que são cruciais
Continuando, agora vamos usar o comando ``cat /etc/os-release``, que trará apenas mais informmações sobe o hostame, com isso teremos o output abaixo:

.. code-block:: bash

   PRETTY_NAME="Zorin OS 17.1"
   NAME="Zorin OS"
   VERSION_ID="17"
   VERSION="17.1"
   VERSION_CODENAME=jammy
   ID=zorin
   ID_LIKE="ubuntu debian"
   HOME_URL="https://zorin.com/os/"
   SUPPORT_URL="https://help.zorin.com/"
   BUG_REPORT_URL="https://zorin.com/os/feedback/"
   PRIVACY_POLICY_URL="https://zorin.com/legal/privacy/"
   UBUNTU_CODENAME=jammy
   
Outros processos importantes a serem levantados no sistema operacional são os dados de BIOS, processador e memória. 
Para levantamento de dados do BIOS podemos usar o comando ``sudo dmidecode`` onde podemos coletar dados como Vendor, Versão, Data de Lançamento, Endereço na Memória, Características, Nome do Produto de acordo com o fabricante, numero de série entre outras informações que auxiliam na identificação do dispositivo.


USERS
###################

Agora vamos começar a coletar informações dos usuários do sistema para catalogar suas permissões e dados informativos, para tal começaremos com o comando ``w``, sim, apenas a letra "w" mesmo ou, caso queira uma versão mais enxuta do output pode usar o camando ``who``. Neste comando encontraremos o output:

.. code-block:: bash

    20:33:01 up  2:30,  3 users,  load average: 0.02, 0.03, 0.00
    USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
    user1    pts/0    192.168.0.101     20:00    1:30   0.02s  0.02s -bash
    user2    pts/1    192.168.0.102     20:10    2:00   0.01s  0.01s -bash
    user3    pts/2    192.168.0.103     20:20    0.00s  0.00s  0.00s w

* **20:33:01** - Sendo o horário atual.
* **up 2:30** - Sendo o tempo de atividade do sistema (uptime).
* **3 users** - Que é o nNúmero de usuários logados.
* **load average: 0.02, 0.03, 0.00** - Média de carga do sistema nos últimos 1, 5 e 15 minutos.

----------------------------------------------------------------------------------

* **USER** -  O nome do usuário.
* **TTY** - O terminal ao qual o usuário está conectado.
* **FROM** O endereço IP ou hostname de onde o usuário está logado.
* **LOGIN@** - A hora em que o usuário fez login.
* **IDLE** - Tempo de inatividade do usuário.
* **JCPU** - Tempo total de CPU utilizado por todos os processos associados ao terminal.
* **PCPU** - Tempo de CPU utilizado pelo processo em execução atualmente.
* **WHAT** - O comando ou processo que o usuário está executando atualmente.

----------------------------------------------------------------------------------


BEHAVIOR
#####################

Para termos maior acurácia neste momento, precisamos ter ferramentar para detectar o comportamento dos usuários no sistema (que podem até ser aduterados, por isso existe todo um processo a ser seguido antes que uma perícia seja intaurada).

Os comandos abaixo levantarão o comportamento do sistema atrelado a dados como IPs e usernames para que possamos triangular as ações efetuadas no sistema.

Tendo uma idéia do comportamento geral do usuário podemos agora buscar por pistas de seu comportamento perante execuções no sistema operacional, isso significa que iremos auditar suas ações em função de sessões de boot do sistema.

cat /etc/crontab
cat /etc/cron.hourly/
cat /etc/cron.daily/
cat /etc/cron.weekly/
cat /etc/cron.monthly/
cat /etc/cron.d/
crontab -u $USER -l
cat /var/log/cron
sudo grep cron /var/log/syslog

Outra abordagem que pode ser abordada para analisar os processos é através do diretório /proc, que organiza os processos de forma hierarquica; junto a isso podemos fazer uma analise dos processos e seus PIDs detectados para analisarmos o que cada processo tem feito no sistema através das ferramentas como ``top`` e ``htop`` para levantar qual seria o processo a ser analisado e seus PID.

1. **Identificando a sessão de boot correspondente ao incidente:**
Com a persistencia de logs agora conseguimos analisar os logs de acordo com o boot ID e seu timestamp, selecionando a data em que houve o incidente no sistema, para encontrar o boot ID já sabemos, basta usar o commando ``journalctl --boot-list`` e coletar o boot ID equivalente a data do incidennte (ou do evento que precisa analisar); tendo o Boot ID em mãos insira no comando ``journalctl -b <boot ID>``, com isso terá acesso a todos os logs gerados naquele dia de forma completa.
Mas mesmo tendo acesso aos logs pode ser difícil extrair dados no meio do volume de dados coletados, para isso podemmos usar comandos e prompts para facilitar na busca, segue abaixo alguns comandos que podem ser utilizados para encontrarmos dados que poderiam ser coerentes.

.. code-block:: bash

   journalctl -b <boot_id> | grep -i 'COMMAND'
   journalctl -b <boot_id> | grep -i 'USER'
   journalctl -b <boot_id> | grep -i 'net'
   journalctl -b <boot_id> | grep -i 'dhcp'
   journalctl -b <boot_id> | grep -i 'interface'
   journalctl -b <boot_id> | grep -i 'iptables'
   journalctl -b <boot_id> | grep -i 'socket'
   journalctl -b <boot_id> | grep -i 'Started\|Stopped\|Enabled\|Disabled'
   journalctl -b <boot_id> | grep -i 'modification\|changed\|updated'
   journalctl -b <boot_id> | grep -i 'warning\|err\|critial\|alert\|emerg'
   journalctl -b <boot_id> -p err
   
   #pequena pausa para informar que pra analisar serviços do sistema vale a pena ter uma idéia de quais são os serviços presentes no sistema
   systemctl list-unit-files --type=service
   journalctl -b <boot_id> -u <service_name>.service

DEPENDENCIES
####################

Pode ser imprescindível analizar o quê está instalado no sistema, se os apps são legí
timos ou podem estar comprometendo o sistema.

Para isso temos alguns comandos que podem ser emitidos no terminal para conseguirmos estes dados como informação.

Um primeiro comando que podemos emitir é o ``lsmod`` para verificarmos, na ordem do output, os módulos do Kernel, seu tamamho e quantidade em uso.

.. code-block:: bash

   Module                  Size  Used by
   vmnet                  73728  17
   parport_pc             53248  0
   vmmon                 167936  0

Também precisamos analisar todos pacotes instalados, pode haver algo no meio, pra isso podemos usar comandos como ``dpkg -l``, ``dpkg-query -l``, ``apt list --installed``, ``flatpak list`` e/ou ``snap list`` e verificar cada item e sua proveniência.

