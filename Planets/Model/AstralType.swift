enum AstralType: Decodable, Equatable {
    case space
    case polyanet
    case soloon(color: String)
    case cometh(direction: String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        // Split the value to separate color and model
        let components = rawValue.split(separator: "_")
        
        // Ensure there's at least a color and model component
        guard components.count == 2 else {
            switch components.first {
            case "SPACE":
                self = .space
            case "POLYANET":
                self = .polyanet
            default:
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode")
            }
            return
        }
        
        let property = String(components[0]).lowercased()
        let modelName = String(components[1])
        
        switch modelName {
        case "SOLOON":
            self = .soloon(color: property)
        case "COMETH":
            self = .cometh(direction: property)
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode")
        }
    }
}
