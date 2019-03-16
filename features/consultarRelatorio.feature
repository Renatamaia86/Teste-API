#language:pt

Funcionalidade: Consultar relatório

    @teste1
    Cenário: Onde os dados de envio estão vazios e nossa API retorna erros controlados.
        Quando envio uma requição POST sem dados
        Então recebo o código de erro "400" e a mensagem de erro "É necessário enviar ao menos um parâmetro para criação do relatório."

    @teste2
    Cenário: Regra de data diferente
        Dado que sou uma aplicação e envio uma requição POST com data diferente
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "INVALID" e mensagem "Inválido. [ERROR] Não foi possível validar: Data de nascimento informada está divergente da constante na base de dados da Secretaria da Receita Federal do Brasil."

    @teste3
    Cenário: Regra de nome diferente
        Dado que sou uma aplicação e envio uma requição POST com nome diferente
        Quando consulto o relatório usando o número da requisição
        Então recebo o resultado "INVALID" e mensagem "Inválido. [INVALID] Nome diferente do cadastrado na Receita Federal."
    
    @teste4
    Cenário: Cenário não conhecido
        Dado que sou uma aplicação e envio uma requição POST com dados de um arquivo csv
        Quando consulto o relatório usando o número da requisição 
        Então recebo o resultado "VALID" e mensagem "Válido."




