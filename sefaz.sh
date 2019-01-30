#!/usr/bin/env bash

# teste.sh - Verificar se existe atualização do Dominio
#
# Site:       https://wesllenmatias.com.br
# Autor:      Wesllen Matias
# Manutenção: Wesllen Matias
#
# ------------------------------------------------------------------------ #
# Este programa vai checar os status da página da sefaz e enviar via telegram
#
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 - Versão inicial
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
[ ! -x $( which lynx ) ] && apt install lynx -y
[ ! -x $( which jq ) ] && apt install jq -y



#status="$(lynx -source http://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=0.00 | \
#grep SVC-AN | sed 's/<td>/Status Sefaz RN: /;s/<\/td.*src="/ /;s/" \/>.*src="/ /;s/imagens.*\/td>/✅/')"

status="$(lynx -source http://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=0.00 | \
grep imagens/bola_ | sed 's/<td>/Status Sefaz: /;s/<\/td>.*src="/ /;s/".*//;s/<img.id=//' | \
sed -e 's,imagens/bola_verde_P.png,✅,g;s,imagens/bola_amarela_P.png,⚠️,g;s,imagens/bola_vermelho_P.png,❌,g')"


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
                '/sefaz')
                    # Envia mensagem ao remetente.
                    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                         --text "Olá *${message_from_first_name[$id]}*, abaixo Status NF-E:
$status" \
                                         --parse_mode markdown
                ;;
            esac
         fi
    ) & # Thread
    done
done