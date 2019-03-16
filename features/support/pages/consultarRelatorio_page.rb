
class Idwall
    # endereço do arquivo CSV:
        # Local:
        $path_CSV = "./features/input/"

    include HTTParty  
    # URL padrão da API:
    base_uri 'https://api-v2.idwall.co'
  
    # inicialização da estrutura do body
    def initialize(body)
        @auth = {'Authorization': '24074832-0feb-40cb-91d4-e1ac9cf56dcd','content-type': 'application/json'}
        
        # método POST, body recebe o body montado mais abaixo na leitura do CSV
        @sendDocument = {
            :verify => false,
            :headers => @auth,
            :body => body}
        
        # método GET, body segue vazio
        @getData = {
            :verify => false,
            :headers => @auth,
            :body => {}}    
      
    end

    def postDocument
        # método post do documento para receber a idkey
        self.class.post("/relatorios", @sendDocument)
    
    end

    def getStatus(idkey)
        # 
        self.class.get("/relatorios/#{idkey}", @getData)
        # STDOUT.puts "chave recebida: #{idkey}"
    end

end

def getStatusRelatorio(idkey)

    responseget = JSON.parse(@idwall.getStatus(idkey).body)

    status = responseget["result"]["status"]
    i=0
    STDOUT.puts ("    ----------------------------------------------------------------------------------------")
    while (status != "CONCLUIDO")

        printf("\r    ==> PROCESSANDO DOCUMENTO Nº #{idkey} : [%-1s", "=" * (i))
        i+=1
        responseget = JSON.parse(@idwall.getStatus(idkey).body)
        status = responseget["result"]["status"]
        if status == "CONCLUIDO"
            printf("\r    ==> PROCESSANDO DOCUMENTO Nº #{idkey} : [%-#{i}s] CONCLUÍDO.", "=" * (i))
            STDOUT.puts ("\n")
            STDOUT.puts ("    ----------------------------------------------------------------------------------------")
            STDOUT.puts ("\n")
            break
        end
        sleep 10
    end
    return responseget
end


def create_no_data_body
    body = {
        "matriz": "consultaPessoaDefault",
        "parametros": {
        "cpf_data_de_nascimento": "",
        "cpf_nome": "",
        "cpf_numero": ""
        }
    }
    
    @body = JSON.generate(body)
    @idwall = Idwall.new(@body)    
end

def create_wrong_data_body()
    body = {
        "matriz": "consultaPessoaDefault",
        "parametros": {
            "cpf_data_de_nascimento": "28/09/1988",
            "cpf_nome": "Gabriel Oliveira",
            "cpf_numero": "07614917677"
        }
    }

    @body = JSON.generate(body)
    @idwall = Idwall.new(@body)  
end

def create_wrong_name_body()
    body = {
        "matriz": "consultaPessoaDefault",
        "parametros": {
            "cpf_data_de_nascimento": "25/05/1987",
            "cpf_nome": "Gabriel Oliveira",
            "cpf_numero": "07614917677"
        }
    }

    @body = JSON.generate(body)
    @idwall = Idwall.new(@body)  
end

def create_csv_body(arquivo)
    arquivo = CSV.read("#{$path_CSV}#{arquivo}")

    data_nascimento = arquivo[0].join
    nome = arquivo[1].join
    cpf = arquivo[2].join

    body = {
        "matriz": "consultaPessoaDefault",
        "parametros": {
            "cpf_data_de_nascimento": "#{data_nascimento}",
            "cpf_nome": "#{nome}",
            "cpf_numero": "#{cpf}"
        }
    }
    
    @body = JSON.generate(body)
    @idwall = Idwall.new(@body)    
end