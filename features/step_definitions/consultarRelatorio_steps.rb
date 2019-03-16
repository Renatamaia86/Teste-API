Quando("envio uma requição POST sem dados") do
    create_no_data_body()   
    @response = JSON.parse(@idwall.postDocument.body) 
end
  
Então("recebo o código de erro {string} e a mensagem de erro {string}") do |codigo, mensagem|
    expect(@response["message"]).to eql mensagem
    expect(@response["status_code"].to_s).to eql codigo
end

Dado("que sou uma aplicação e envio uma requição POST com data diferente") do
    create_wrong_data_body()
    @response = JSON.parse(@idwall.postDocument.body)
    # STDOUT.puts @response
    @idkey = @response["result"]["numero"]
    puts @idkey
end
  
Quando("consulto o relatório usando o número da requisição") do
    @responseget = getStatusRelatorio(@idkey)
end
  
Dado("que sou uma aplicação e envio uma requição POST com nome diferente") do
    create_wrong_name_body()
    response = JSON.parse(@idwall.postDocument.body)
    @idkey = response["result"]["numero"]
    puts @idkey
end

Dado("que sou uma aplicação e envio uma requição POST com dados de um arquivo csv") do
    arquivo = "file.csv" 
    create_csv_body(arquivo)
    response = JSON.parse(@idwall.postDocument.body)
    @idkey = response["result"]["numero"]
    puts @idkey

end
  
Então("recebo o resultado {string} e mensagem {string}") do |resultado, mensagem|
    expect(@responseget["result"]["resultado"]).to eql resultado
    expect(@responseget["result"]["mensagem"]).to eql mensagem
end 