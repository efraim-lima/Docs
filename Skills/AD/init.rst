Active Directory
=====================

O AD (Active Directory) é uma ferramenta poderosa que possibilita a organização de ativos digitais de uma empresa de forma lógica e organizada, permitindo a aplicação de configurações seguras e objetivas para as empresas.

- Partition: `o AD consiste em um arquivo de nome ntds.dit (DS provavelmente de Data Server)`
- Domain: `funciona como um container lógio referente à parte de administração do sistema, interprete como ativos que podem ser atribuidos para usuários, grupos e afins`
- Damain Tree: `é uma coleção hierárquica de domínios, que compartilham o mesmo domínio raíz (domain root) e um DNS contíguo`
- Forest: `é uma coleção hierárquica de domínios, que compartilham o mesmo domínio  raizm mas dessa vez é um AD específico em comum`
- OU: `os OU (Organizational Unit) são containers para os usuários, grupos e dispositivos que possuem a capacidade de delegar seus direitos administrativos e administração linkando GPOs (Group Policy Objects)`
- Container: `um container é um objetoque proporciona um framework organizacional para ser usado no AD DS, podem ser usados os defaults ou customizados. Não podemos vincular GPOs a Containers`

**Physical Components**
São objects tangíveis ou descritos como objetos tangíveis no mundo real

- Domain Controller: `Possui uma cópia do AD database. Pode processar alterações e replicar essas alterações ára todos os outros Domain Controllers no domínio`
- Data store: `Existe uma copia dos dados armazenados em cada Domain Controller, proporcionado pelo Microsoft Jet database e armazenano no ntds.dit no path C:\Windows\NTDS por padrão`
- Global Catalog Server: `é um controlador de dominio que hospeda o catalogo global que é uma cópia de leitura de todos os objetos em uma forest`
- Read-only domain controller(RODC): `é uma instalação apenas de leitura do AD DS, ocorre em casos onde escritórios não possuem muitos recursos de TI (principalmente no critério de suporte)`
- Site: `é um container de objetos, assim como computadores e serviços que são específicos àquela localização física`
- Subnet: `é uma porção de endereçamento da rede da organização, atribuida a uma série de dispositivos naquela rede, podem haver várias subredes`

.. include:: admin.rst
