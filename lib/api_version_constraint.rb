class ApiVersionConstraint
    #recebe o parametro options, pega a versão e guarda
    def initialize(options)
        @version = options[:version]
        @ddefault = options[:default]
    end
    # pega a requisição, vai verificar no cabeçalho acccept se tem o conteúdo do include (futuramente descobriremos o que é)
    # os defaults era para verificar a versão defaults
    def matches?(req)
        @default || req.headers['Accept'].include?("application/vnd.pprojetofase8.v#{@version}")
    end
end
