/// A struct representing a network resource with a path, HTTP method, and parameters.
struct Resource {
    
    /// The endpoint path for the resource.
    let path: String
    
    /// The HTTP method to use for the request (e.g., GET, POST).
    let httpMethod: HttpMethod
    
    /// Query parameters to include in the request.
    let parameters: [String: String]
    
    init(path: String, httpMethod: HttpMethod = .get, parameters: [String : String] = [:]) {
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
