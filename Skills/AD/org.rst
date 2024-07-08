================
Active Directory
================

**Definição de forests e domínios**

FORESTS
===============
Florestas (forests) são o container de nível mais alto do AD DS.
uma coleção de um ou mais AD DS que contêm um ou mais domínio AD DS, estes domínios compartilham:
- `uma raiz (root) em comum`
- `um esquema em comum`
- `um catálogo global`

Dentro de uma forest delimitaresmos os domains também, por isso trataremos de algumas informações pertinentes aos domínios aqui.

Possuimos hierarquização entre os domínios podendo ser eles Forest root domain, Tree root domain e Child domain entre outros. 

Caracteristicas do que podemos encontrar no forest root domain:
- `O papel mestre do esquema.`
- `A função mestre de nomeação do domínio.`
- `O grupo de administradores da empresa.`
- `O grupo de administradores de esquema.`

Cada forest pode conter multiplos domains.

DOMAIN
=============
os domínios são um tipo de container com foco na adminstração lógica de uma parte do sistama, de forma que possamos administrar usuários, dispositivos, grupos e outros objetos.
O banco de dados do AD DS armazena todos os objetos do domínio, e cada controlador do domínio armazena uma copia deste database.
	Os atributos do domínio podem proporcionar atutenticação e autorição aos usuários, de forma a garantir que seus devidos logins possam acessar seus devidos recursos

Cada dominio possui:
- `usuários`
- `grupos`
- `dispositivos`

OU
================
As OUs são unidades como containers que podemos utilizar para consolidar usuários, dispositivos, grupos e outros objetos permitindo que apliquemos GPOs de forma coletiva, ou seja, a todo o grupo. Podemos criá-las usando:
- `Active Directory Administrative Center`
- `Active Directory Users and Computers`
- `Windows Admin Center`
- `Windows PowerShell with the Active Directory PowerShell module`

As OUs podem ser criadas de forma a representar a organização de uma empresa de acordo com seu organograma, por exemplo, podemos ter uma OU para cada setor distinto na empresa ou localização geográfica distinta.
