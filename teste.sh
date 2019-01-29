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

# ------------------------------- VARIÁVEIS ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[! -x $(wich lynx)]&& apt install lynx -y
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #


infos="$( lynx -source http://download.dominiosistemas.com.br/atualizacao/contabil/101b01/atualizacoes/ | grep C101 )"
echo "$infos" | sed 's/<img.*exe">//;s/<.*\/a>//'


# ------------------------------------------------------------------------ #
