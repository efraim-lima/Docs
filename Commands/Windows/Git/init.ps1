# Antes de iniciar este script precisamos dar as devidas permissões ao arquivo udando o comando:
#
# `Set-ExecutionPolicy RemoteSigned`
#
# Primeiro tentamos instalar o Git usando Chocolatey, caso não esteja instalado
choco install git -y

# Configurar Git
Write-Host "Digite seu nome de usuário:"
$Nome = Read-Host

Write-Host "Digite seu email do GitHub [email@email.com]:"
$Email = Read-Host

git config --global user.name "$Nome"
git config --global user.email "$Email"

# Cria uma pasta para o projeto
$projectPath = "$HOME\PastaDoProjeto"
New-Item -ItemType Directory -Path $projectPath
Set-Location -Path $projectPath

# Inicializa um repositório Git
git init

# Cria um arquivo README.md
"Meu Projeto" | Out-File -FilePath "$projectPath\README.md"

# Adiciona e comita os arquivos
git add .
git commit -m "Primeiro commit"

Write-Host "Digite a URL do seu projeto [https://github.com/usuario/projeto.git]:"
$URL = Read-Host

# Adiciona o repositório remoto e faz o push
git remote add origin $URL
git push -u origin master

# Para alterações subsequentes, use:
# git add .
# git commit -m "Mensagem"
# git push

