# INSS Discount

Aplicação básica para empresas controlarem o desconto de INSS dos colaboradores.

## Docker:
Para inicializar o docker basta executar os comandos:
Se não conseguir executar, tente rodar com o comando "sudo";

- docker-compose build 
- docker-compose run web yarn install --check-files
- docker-compose run web rake db:create
- docker-compose run web rake db:migrate
- docker-compose run web rake db:seed
- docker-compose up

O servidor estará rodando em localhost:3000.
Voce pode acessar o mailcacher em localhost:1080

## Admin de teste:
- email: test@redspark.com
- password: '123456'

## Tecnologias Utilizadas:

- Ruby: versão 2.7.5
- Rails: versão 6.0.0
- PostgreSQL: banco de dados relacional
- Redis: para gerenciar filas com Sidekiq
- Mailcatcher: para captura e visualização de e-mails em ambiente de desenvolvimento
- Bootstrap 5: para estilização da interface
- Chart.js: para visualização de gráficos
- Rubocop Rails: para padronização de código
- Kaminari: para paginação
- Sidekiq: para processamento de jobs em background

## Testes:

- TDD (Test-Driven Development) com:
- RSpec para testes automatizados
- Faker para geração de dados fictícios nos testes
- FactoryBot para criação de objetos de teste
- Shoulda Matchers para validações e associações
- DatabaseCleaner para garantir um banco de dados limpo entre execuções de testes

## Funcionalidades Principais

- Registro de novas contas e login utilizando email e senha.
- Cadastro e gerenciamento de colaboradores.
    - Envio de E-mail quando sálario do colaborador é atualizado
- Cálculo automático do INSS com base no salário do colaborador.

## Outras Funcionalidades:

- Docker e Docker Compose configurados para facilitar a instalação e execução do projeto.
- TDD com Rspec usando Faker, FactoryBot, Shoulda Matchers e DatabaseCleaner para:
    - Models
    - Rounting
    - Controllers
    - Services
    - Mailers
- Integração com CI/CD para automação de testes e deploy.

    
