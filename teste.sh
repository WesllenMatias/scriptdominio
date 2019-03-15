#!/usr/bin/env bash
# teste.sh - Verificar se existe atualização do Dominio
#
# Site:       https://wesllenmatias.com.br
# Autor:      Wesllen Matias
# Manutenção: Wesllen Matias
#
# ------------------------------------------------------------------------ #
# Este programa vai checar se existe atualização do Dominio Sistemas no
# Repositório deles.
#
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 Metodo inicial
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #
# Importando API
source ShellBot.sh

# ------------------------------- VARIÁVEIS ----------------------------------------- #
bot_token=''
# ------------------------------------------------------------------------ #
# Inicializando o bot
ShellBot.init --token "$bot_token"
# ------------------------------- TESTES ----------------------------------------- #
[ ! -x $( which lynx ) ] && apt install lynx -y
[ ! -x $( which jq ) ] && apt install jq -y
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #


infos="$( lynx -source http://download.dominiosistemas.com.br/atualizacao/contabil/101b01/atualizacoes/ | grep C101 | sed 's/<img.*exe">//;s/<.*\/a>//')"
#echo "$infos" | sed 's/<img.*exe">//;s/<.*\/a>//'
# loop
while :
do
    # Obtendo atualizações
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30

    # Lista os índices das atualizações.
    for id in $(ShellBot.ListUpdates)
    do
    # Bloco de instruções
    (
        # Verifica se a mensagem é do tipo comando.
        if [[ ${message_entities_type[$id]} == bot_command ]]
        then
            # Remove o sufixo contendo o username do bot e o '@' inclusive, extraindo somente o comando.
            case ${message_text[$id]%%@*} in
                '/dominio')
                    # Envia mensagem ao remetente.
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                         --text "Olá *${message_from_first_name[$id]}*, seguem atualizações Disponiveis:
$infos" \
                                         --parse_mode markdown
             $infos=null
                ;;
            esac
         fi
    ) & # Thread
    done
done

# ------------------------------------------------------------------------ #
