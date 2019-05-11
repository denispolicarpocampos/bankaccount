# Overview
Clone o projeto do github e rode os seguintes comandos na linha de comando para rodar o projeto:

É necessário ter docker e docker-compose instalados.

1. docker-compose build
2. docker-compose run --rm app bundle install
2. docker-compose run --rm app bundle exec rake db:create db:migrate db:seed
3. docker-compose up

Rodando db:seed dois usuários padrões serão criados:

usuario1: teste1@teste.com.br
senha: secret123
conta bancária: 1000
valor: R$ 50

usuario1: teste2@teste.com.br
senha: secret123
conta bancária: 1001
valor: R$ 50


# Authentication
Chame o endpoint /api/v1/user_token para adquirir o token jwt para autenticação.
