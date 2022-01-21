# Cross Commerce Challenge

## 🚦 Pré Requisitos

- [Docker](https://www.docker.com/products/docker-desktop)

## Para executar o projeto

Clone o projeto em sua pasta local

```bash
git clone https://github.com/mateus-sartori/cross_commerce_desafio
```

Após isso temos o ambiente `backend`

Para subir os containers em `backend(Phoenix)`:

## 🎲 Rodando o servidor

É necessário estar dentro da basta backend e rodar os seguintes comandos:

```bash
# Rode o comando build, para executar todos os requerimentos e configurações
docker-compose build
```

```bash
# Para levantar o container
docker-compose up
```

```bash
# Entre na bash do container api, e instale as libs
docker-compose exec api bash

# Dentro da bash do api
mix deps.get && mix ecto.setup

# Você pode compilar as libs separadamente basta rodar o comando
mix ou mix deps.compile 

# É preciso rodar o comando de migrations em seguida para criar as tabelas
mix phx.server ou iex -S mix phx.server

# Assim uma rota local será aberta em 
localhost:4000

# Você poderá consultar a seguinte rota para o teste
localhost:4000/api/numbers
```
