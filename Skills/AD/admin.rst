=======================
Active Directory
=======================

**Criar objetos de usuários**
Todos usuários precisam ter contas no AD DS, elas são feitas para autenticação, hierarquização, administração e atribuição de permissões para que possam acessar recursos da rede.

Cada conta de usuário deve possuir: 
- `nome`
- `senha`
- `grupo`

Existem CONTAS DE SERVIÇOS GERENCIADOS, elas levam em consideração que muitos aplicativos contem serviços que instalamos no host e esses serviços hospedam os programas que precisamos utilizar. Como eles rodam em segundo plano e não requerem interção do usuário criam-se as contas de serviços. Algumas organizações preferem usar contas baseadas em dominios para proporcionar autenticação a esses serviços, mas isso acarreta em uma série de problemas como:
- `necessidade de reforço administrativo para gerenciar a senha da conta de forma segura`
- `necessidade de reforço administrativo para gerenciar o SPN (service principal name)`
- `dificuldade em determinar qual conta está sendo usada para cada serviço`

Seguindo o mesmo principio das contas de serviços gerenciados, temos o grupo de serviços gerenciados, que nada mais é do que um grupo onde podemos atribuir as regras para uma quantidade de usuários de forma organizada e hierárquica.

Para habilitar a presença de grupo no AD DS primeiro precisamos criar a raiz do KDS:

.. code-block:: text 
   Add-KdsRootKey –EffectiveImmediately

Podemos criar um grupo usando o comando abaixo:

.. code-block:: text
   New-ADServiceAccount -Name <nome da nova conta de serviço> -PrincipalsAllowedToRetrieveManagedPassword <conta de ativos MSA>, <grupo de ativos MSA>`

**TIPOS DE GRUPOS**
- Security: `são grupos usados para atribuir permissões para outros recursos, se pretendemos usar um grupo para gerenciar a segurança, este precisa ser um security group (eles também podem ser usados em ACLs para permitir acesso a recursos)`
- Distribution: `podem ser utilizados para ser atribuidos a aplicações de email, por exemplod`

**ESCOPOS DE GRUPO**
- Local: `Este tipo de grupo é mais utiizado para atribuirmos recursos a estações de trabalho e servidores autonomos ou então para usuários dos servidores que não sao controladores.
	-> refere-se apenas a ativos locais;
	-> podemos atribuir apenas permissões a recursos locais;
	-> membros podem ser provenientes de qualquer lugar da AD DS forest;
`	
- Domain-Local:	`Usado para gerenciar acesso aos recursos ou atribuir direitos de gerenciamento e reponsabilidades. Focado apenas em recursos locais
	-> podemos atribuir capacidade e permissões apenas em recursos do domain-local, que são os dispositivos no domínio local;
	-> membros podem ser provenientes apenas de recursos domínio local, o que significa que devem ser dispositivos no dominio local;
`	
- Global: `Para este caso estaremos garantindo que usuários de características semelhantes tenham as mesmas capacidades, por exemplo, usuários do mesmo setor ou localização geográfica.
	-> podemos atribuir capacidades e permissões em qualquer setor na forest
	-> membros podem ser provenientes apenas do domínio local assim como usuários, dispositivos e grupos globais;
`
- Universal: `Este caso é mais usado em situações de multiplos domínios, onde temos varias posições horizontalmente hierárqicas, este escopo combina atributos dos Domain-local e Global
	-> podemos atribuir capacidades e permissões em qualquer setor na forest
	-> membros podem ser provenientes de qualquer lugar da AD DS forest;
`

**Others**
Computadores/Dispositivos são equiparados aos usuários em critérios de configurações no AD. Algumas tarefas diárias que podemos encontrar com os dispositivos são:
	-> configurar as propriedades do dispositivo;
	-> mover os dispositivos entre as OU;
	-> gerenciar os dispositivos;
	-> renomear, resetar, disabilitar, habilitar e deletar o objeto


