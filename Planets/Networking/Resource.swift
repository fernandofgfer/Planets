struct Resource {
    let path: String
    let httpMethod: HttpMethod
    let parameters: [String: String]
    
    init(path: String, httpMethod: HttpMethod = .get, parameters: [String : String] = [:]) {
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
