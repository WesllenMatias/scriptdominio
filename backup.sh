#!/usr/bin/env bash

# backup.sh - Faz a copia de arquivos a serem backupeados e envia msg no
# telegram
#
# Site:       https://wesllenmatias.com.br
# Autor:      Wesllen Matias
# Manutenção: Wesllen Matias
#
#
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v3.2 - Versão inicial
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #
source ShellBot.sh

#Informando bot que será usado
bot_token='625744069:AAGTXbrysLdWXsapmqhI9SPYpgledYJWPa4'

# Inicializando o bot
ShellBot.init --token "$bot_token"
# ------------------------------- TESTES ----------------------------------------- #
[ ! -x $(which lynx) ] && apt install lynx -y
[ ! -x $(which jq) ] && apt install jq -y
[ ! -x $(which dialog) ] && apt install dialog -y

# ------------------------------- VARIAVEIS ----------------------------------------- #

id='-334711746'
erro="Erro durante o backup"
dir=/home/$USER/Documentos/
arq=teste.txt
list="$(ls -lh /home/$USER/Documentos/testes/ | tail -n 1)"

# ------------------------------------------------------------------------ #

backup="$(find "$dir" -name teste.txt )"

# ------------------------------------------------------------------------ #
[ "$backup" != 0 ] && cp /home/$USER/Documentos/teste.txt /home/$USER/Documentos/testes/ | \
ShellBot.sendMessage --chat_id $id \
                     --text "💾 O *Backup* `date +%d-%m-%Y` foi realizado com sucesso! ✅

📂 _$list _" \
                     --parse_mode markdown
