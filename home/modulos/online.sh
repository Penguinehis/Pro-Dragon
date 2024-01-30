#!/bin/bash

# Função para iniciar o loop
start_loop() {
    while true; do
        # Execute o comando 'ps aux | grep priv | grep Ss' no VPS e armazene a saída em $output
        output=$(ps aux | grep priv | grep Ss)

        # Divida a saída em linhas usando a função IFS
        IFS=$'\n' read -rd '' -a lines <<<"$output"

        # Inicializar uma variável para armazenar os usuários online
        user_list=""

        # Percorra as linhas da saída
        for line in "${lines[@]}"; do
            # Ignore a linha se ela não contiver o processo "priv"
            if [[ $line != *"priv"* ]]; then
                continue
            fi

            # Divida cada linha em colunas usando a função read
            read -ra columns <<<"$line"

            # Obtenha o nome de usuário da coluna 11
            username=${columns[11]}

            # Adicione o nome de usuário à lista separada por vírgulas
            if [[ -z "$user_list" ]]; then
                user_list="$username"
            else
                user_list="$user_list,$username"
            fi
        done

        # Enviar a lista de usuários para o servidor remoto via POST e capturar a saída em uma variável
        response=$(curl -s -X POST -d "users=$user_list" "https://%s/online.php")

        # Separar as respostas em duas variáveis
        limit_exceeded_response=$(echo "$response" | grep "Limite atingido")
        validity_expired_response=$(echo "$response" | grep "A validade expirou")

        # Verificar se o limite foi atingido
        if [[ -n "$limit_exceeded_response" ]]; then
            # Extrair os nomes de usuário da resposta
            limit_exceeded_users=$(echo "$limit_exceeded_response" | awk -F ": " '{print $2}')
            echo "Limite atingido para os seguintes usuários: $limit_exceeded_users"
            # Executar o comando para remover os usuários
            ./KillUser.sh "$limit_exceeded_users"
        fi

        # Verificar se a validade expirou
        if [[ -n "$validity_expired_response" ]]; then
            # Extrair os nomes de usuário da resposta
            validity_expired_users=$(echo "$validity_expired_response" | awk -F ": " '{print $2}')
            echo "A validade expirou para os seguintes usuários: $validity_expired_users"
            # Executar o script para lidar com a validade expirada
            ./ExcluirExpiradoApi.sh "$validity_expired_users"
        fi

        # Aguarde 3 segundos antes da próxima iteração
        sleep 3
    done
}

# Iniciar o loop diretamente sem verificar argumentos
start_loop
