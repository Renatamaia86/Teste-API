#lenguage:pt

Funcionalidade: Consultar relatório

    Cenário: Consultar relatório com resultado válido e mensagem válida
        Dado que sou uma aplicação e envio uma requição POST com dados válidos
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "VALID" e mensagem "Válido."

    Cenário: Consultar relatório com resultado inválido e mensagem de nome inválido
        Dado que sou uma aplicação e envio uma requição POST com nome inválido
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "INVALID" e mensagem de nome inválido

    Cenário: Consultar relrelatório com resultado inválido e mensagem de 


    Cenário: Regra de data diferente


    Cenário: Regra de nome diferente
