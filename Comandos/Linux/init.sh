#!/bin/bash

#Primeiro precisamos atualizar a lista de pacotes no sistema e sua base de dados, além de instalar o git caso não exista no sistema

sudo apt update
sudo apt install git -y

echo "Digite seu nome de usuário:\n"
read Nome
echo "Digite seu email do GitHub [email@email.com]:\n"
read Email

git config --global user.name "$Nome"
git config --global user.email "$Email"

mkdir ~/PastaDoProjeto
cd ~/dPastaDoProjeto

git init

echo "# Meu Projeto" >> README.md

git add .
git commit -m "Primeiro commit"

echo "Digite a url de seu projeto [https://github.com/usuario/projeto.git]:\n"
read URL
git remote add origin $URL
git push -u origin master

# Para alterações subsequentes:
# git add .
# git commit -m "Mensagem"
# git push
