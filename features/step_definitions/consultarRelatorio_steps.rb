require "httparty"
# Dado("que sou uma aplicação") do
#     pending # Write code here that turns the phrase above into concrete actions
#   end
  
Quando("envio uma requição POST sem dados") do
    response = HTTParty.post("https://api-v2.idwall.co/relatorios", :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd','content-type': 'application/json'}, 
        :body => {
            "matriz": "consultaPessoaDefault",
          "parametros": {
            "cpf_data_de_nascimento": "01/01/2000",
            "cpf_nome": "teste",
            "cpf_numero": "83026961027"
            }
        }.to_json
        )
    @idkey = response["result"]["numero"]
    puts @idkey
end
  
Então("recebo mensagem de erro") do
sleep 1
    responseget = HTTParty.get("https://api-v2.idwall.co/relatorios/#{@idkey}", :verify => false,
        :headers => {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd',
                    'content-type': 'application/json'}.to_json
        )
    puts responseget
end
  
Dado("que sou uma aplicação e envio uma requição POST com data diferente") do
    pending # Write code here that turns the phrase above into concrete actions
end
  
Quando("consulto o relatório usando o número da requisição") do
    pending # Write code here that turns the phrase above into concrete actions
end
  
Então("recebo o resultado {string} e mensagem de nome inválido") do |string|
    pending # Write code here that turns the phrase above into concrete actions
end
  
Dado("que sou uma aplicação e envio uma requição POST com nome diferente") do
    pending # Write code here that turns the phrase above into concrete actions
end
  
Dado("que solicito data de nascimento, nome e cpf") do
    pending # Write code here that turns the phrase above into concrete actions
end
  
Dado("faço uma requisição POST") do
    pending # Write code here that turns the phrase above into concrete actions
end