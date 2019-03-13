#language:pt

Funcionalidade: Consultar relatório

    @teste1
    Cenário: Onde os dados de envio estão vazios e nossa API retorna erros controlados.
        # Dado que sou uma aplicação 
        Quando envio uma requição POST sem dados
        Então recebo mensagem de erro

    Cenário: Regra de data diferente
        Dado que sou uma aplicação e envio uma requição POST com data diferente
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "INVALID" e mensagem de nome inválido

    Cenário: Regra de nome diferente
        Dado que sou uma aplicação e envio uma requição POST com nome diferente
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "INVALID" e mensagem de nome inválido

    Cenário: Cenário não conhecido
        Dado que solicito data de nascimento, nome e cpf
        E faço uma requisição POST 
        Quando consulto o relatório usando o número da requisição 
        Então recebo o resultado "VALID" e mensagem de nome inválido




