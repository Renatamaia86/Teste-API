Quando("envio uma requição POST sem dados") do
    response = JSON.parse((HTTParty.post("https://api-v2.idwall.co/relatorios", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}, 
        :body => {
            "matriz": "consultaPessoaDefault",
            "parametros": {
            "cpf_data_de_nascimento": "",
            "cpf_nome": "",
            "cpf_numero": ""
            }
        }.to_json
        )).body)
    
    @message = response["message"]
    @status_code = response["status_code"]
    # puts @message
end
  
Então("recebo mensagem de erro") do
    expect(@message).to eql "É necessário enviar ao menos um parâmetro para criação do relatório."
    expect(@status_code).to eql 400
end
  
Dado("que sou uma aplicação e envio uma requição POST com data diferente") do
    response = JSON.parse((HTTParty.post("https://api-v2.idwall.co/relatorios", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}, 
        :body => {
            "matriz": "consultaPessoaDefault",
            "parametros": {
                "cpf_data_de_nascimento": "28/09/1988",
                "cpf_nome": "Gabriel Oliveira",
                "cpf_numero": "07614917677"
            }
        }.to_json
        )).body)
    
    
    @idkey = response["result"]["numero"]
    puts @idkey
end
  
Quando("consulto o relatório usando o número da requisição") do
    responseget = JSON.parse((HTTParty.get("https://api-v2.idwall.co/relatorios/#{@idkey}", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}
        )).body)
    # puts responseget
    # @status = responseget["result"]["status"]
    # puts @status
    while (@status != "CONCLUIDO")
    responseget = JSON.parse((HTTParty.get("https://api-v2.idwall.co/relatorios/#{@idkey}", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}
        )).body)
    
    @status = responseget["result"]["status"]
    @mensagem = responseget["result"]["mensagem"]
    @resultado = responseget["result"]["resultado"]
    STDOUT.puts @status
    sleep 10
    # puts responseget
    # puts responseget.class
    end

end
  
Então("recebo o resultado {string} e mensagem de data inválida") do |resultado|
    expect(@mensagem).to eql "Inválido. [ERROR] Não foi possível validar: Data de nascimento informada está divergente da constante na base de dados da Secretaria da Receita Federal do Brasil."
    expect(@resultado).to eql resultado
end
  
Dado("que sou uma aplicação e envio uma requição POST com nome diferente") do
    response = JSON.parse((HTTParty.post("https://api-v2.idwall.co/relatorios", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}, 
        :body => {
            "matriz": "consultaPessoaDefault",
            "parametros": {
                "cpf_data_de_nascimento": "25/05/1987",
                "cpf_nome": "Gabriel Oliveira",
                "cpf_numero": "07614917677"
            }
        }.to_json
        )).body)
    
    
    @idkey = response["result"]["numero"]
    puts @idkey
end

Então("recebo o resultado {string} e mensagem de nome inválido") do |resultado|
    expect(@mensagem).to eql "Inválido. [INVALID] Nome diferente do cadastrado na Receita Federal."
    expect(@resultado).to eql resultado
end
  
Dado("que solicito data de nascimento, nome e cpf") do
    puts "Digite sua data de nascimento:"
    @data_nascimento = gets.chomp
    puts "Digite seu nome:"
    @nome = gets.chomp
    puts "Digite seu cpf (apenas números):"
    @cpf = gets.chomp
end
  
Dado("faço uma requisição POST") do
    response = JSON.parse((HTTParty.post("https://api-v2.idwall.co/relatorios", 
        :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                     'content-type': 'application/json'}, 
        :body => {
            "matriz": "consultaPessoaDefault",
            "parametros": {
                "cpf_data_de_nascimento": "@data_nacimento",
                "cpf_nome": "@nome",
                "cpf_numero": "@cpf"
            }
        }.to_json
        )).body)
    
    
    @idkey = response["result"]["numero"]
    puts @idkey
end