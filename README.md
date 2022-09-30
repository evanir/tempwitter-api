# Tempwitter-api

#### Bem-vindo ! ####

Esta API foi criada para a resolucao de um desafio técnico proposto pela Caiena. 

####  *** Não use em produção ***


## Instalação

Instale a gem executando:

    $ git clone https://github.com/evanir/tempwitter-api.git
    $ bundle install
    
## Requerimentos

É necessário criar uma conta e obter uma chave no https://home.openweathermap.org/api_keys!
É necessário criar uma conta com Twitter e habilita-la como Desenvolvedor!

Renomeie o arquivo .env_example para .env e informe a chave obtida pelo OpenWeatherMap e Twitter:

    OPENWEATHERMAP_KEY      =
    TWITTER_CONSUMER_KEY    =
    TWITTER_CONSUMER_SECRET =
    TWITTER_ACCESS_TOKEN    =
    TWITTER_ACCESS_SECRET   =


## Uso
 
    curl --data "city_name=Campinas" -X POST http://localhost:3000/api/v1/twitter_forecast/tweet 
  
ou

    curl --data "city_id=3448639" -X POST http://localhost:3000/api/v1/twitter_forecast/tweet
  

## Contribuições

Bug reports e pull requests são bemvindos em GitHub at https://github.com/evanir/openweathermap-sdk.

## TODO
  1. Criar resposta para city_id ou city_name não localizados.
  2. "Dockerizar" a api

