class ApiVersionConstraint
    #recebe o parametro options, pega a versão e guarda
    def initialize(options)
        @version = options[:version]
        @default = options[:default]
    end
    # pega a requisição, vai verificar no cabeçalho acccept se tem o conteúdo do include (futuramente descobriremos o que é)
    # os defaults era para verificar a versão defaults
    def matches?(req)
        @default || req.headers['Accept'].include?("application/vnd.projetofase8.v#{@version}")
    end
end
