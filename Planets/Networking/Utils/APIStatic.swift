//
//  APIStatic.swift
//  Planets
//
//  Created by Fernando Garcia Fernandez on 13/11/24.
//


struct APIStatic {
    static let candidateId = "5d36690a-c5fb-4551-9452-842898a52f46"
    private static let baseURL = "https://challenge.crossmint.io/api"
    private static let postPolyanet = "polyanets"
    private static let postSoloon = "soloons"
    private static let postCometh = "comeths"
    
    static var getGoalMap: String {
        "\(baseURL)/map/\(candidateId)/goal"
    }
    
    static var putPolyanet: String {
        "\(baseURL)/\(postPolyanet)"
    }

    static var putSoloon: String {
        "\(baseURL)/\(postSoloon)"
    }

    static var putCometh: String {
        "\(baseURL)/\(postCometh)"
    }
}
