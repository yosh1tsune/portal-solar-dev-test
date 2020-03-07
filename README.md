# Portal Solar - Dev Test

## Teste para vagas de Desenvolvimento

### Utilizando Docker

Este projeto conta com um Dockerfile para facilitar sua utilização minimizando a necessidade da configuração do ambiente.

Para montar a imagem execute o comando a seguir na raiz do projeto

`$ docker-compose build`

Para iniciar o ambiente execute o comando a seguir na raiz do projeto

`$ docker-compose run web bash`

Já no ambiente de testes, execute os seguinte comandos, na ordem listada para instalar o rails, o node, e iniciar o banco de dados e populá-lo com as seeds existentes

`$ gem install rails:5.2`

`$ yarn install`

`$ rails g rspec:install`

`$ bundle exec rails db:create db:migrate db:seed`

Adicione a seguinte linha ao arquivo 'rails_helper'

```config.include FactoryBot::Syntax::Methods```

### Gems adicionais

``` gem 'rspec-rails' ```

``` gem 'factory_bot_rails' ```

``` gem 'rubocop' ```

``` gem 'rubocop-rails' ```

``` gem 'simplecov' ```

``` gem 'faraday' ```
