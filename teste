Como o desafio está dividido:

    Cenários conhecidos
    Cenário não conhecido

Cenários conhecidos

    Onde os dados de envio estão vazios e nossa API retorna erros controlados.

Massa de dados a ser utilizada:

POST https://api-v2.idwall.co/relatorios
{
    "matriz": "consultaPessoaDefault",
    "parametros": {
        "cpf_data_de_nascimento": "",
        "cpf_nome": "",
        "cpf_numero": ""
    }
}

Response: 
{
    "error": "Bad Request",
    "message": "É necessário enviar ao menos um parâmetro para criação do relatório.",
    "status_code": 400
}

    Onde os dados de envio estão inconsistentes e nossa API retorna validações controladas alertando as irregularidades. Considerar os dois cenários a seguir:

Cenário 1: Regra de data diferente

POST https://api-v2.idwall.co/relatorios
{
    "matriz": "consultaPessoaDefault",
    "parametros": {
        "cpf_data_de_nascimento": "28/09/1988",
        "cpf_nome": "Gabriel Oliveira",
        "cpf_numero": "07614917677"
    }
}

Response: 
{
    "result": {
        "numero": "XPTO-12341234141234",
        "status": "CONCLUIDO",
        "nome": "consultaPessoaDefault",
        "mensagem": "Inválido. [ERROR] Não foi possível validar: Data de nascimento informada está divergente da constante na base de dados da Secretaria da Receita Federal do Brasil.",
        "resultado": "INVALID",
        ...
    },
    "status_code": 200
}

Cenário 2: Regra de nome diferente

POST https://api-v2.idwall.co/relatorios
{
    "matriz": "consultaPessoaDefault",
    "parametros": {
        "cpf_data_de_nascimento": "25/05/1987",
        "cpf_nome": "Gabriel Oliveira",
        "cpf_numero": "07614917677"
    }
}

Response:
{
    "result": {
        "numero": "XPTO-12341234141234",
        "status": "CONCLUIDO",
        "nome": "consultaPessoaDefault",
        "mensagem": "Inválido. [INVALID] Nome diferente do cadastrado na Receita Federal.",
        "resultado": "INVALID",
        ...
    },
    "status_code": 200
}

Cenário não conhecido

O cenário não conhecido deve ser preparado para o caso onde o relatório possui os dados de input condizentes aos dados reais de uma pessoa. No caso, para não expor os dados verdadeiros de algum usuário, considere montar um cenário onde podemos validar o status como CONCLUIDO e o resultado como VALID. O sucesso deste cenário será validado com dados de um dos nossos integrates do time :)

Cenário 1: Regra de data diferente

POST https://api-v2.idwall.co/relatorios
{
    "matriz": "consultaPessoaDefault",
    "parametros": {
        "cpf_data_de_nascimento": "Data verdadeira",
        "cpf_nome": "Nome verdadeiro",
        "cpf_numero": "CPF verdadeiro"
    }
}

Response: 
{
    "result": {
        "numero": "XPTO-12341234141234",
        "status": "CONCLUIDO",
        "nome": "consultaPessoaDefault",
        "mensagem": "Válido.",
        "resultado": "VALID",
        ...
    },
    "status_code": 200
}