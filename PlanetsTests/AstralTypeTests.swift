import Foundation
import Testing
@testable import Planets

struct AstralTypeTests {
    
    @Test("Test Space decoding") func spaceDecodingTest() async throws {
        let jsonData = try #require("\"SPACE\"".data(using: .utf8))
        let decodedConference = try JSONDecoder().decode(AstralType.self, from: jsonData )
        #expect(decodedConference == .space)
    }

    @Test("Test Polyanet decoding") func polyanetDecodingTest() async throws {
        let jsonData = try #require("\"POLYANET\"".data(using: .utf8))
        let decodedConference = try? JSONDecoder().decode(AstralType.self, from: jsonData )
        #expect(decodedConference == .polyanet)
    }
    
    @Test("Test Soloon decoding") func soloonDecodingTest() async throws {
        let jsonData = try #require("\"BLUE_SOLOON\"".data(using: .utf8))
        let decodedConference = try? JSONDecoder().decode(AstralType.self, from: jsonData )
        #expect(decodedConference == .soloon(color: "blue"))
    }

    @Test("Test Cometh decoding") func comethDecodingTest() async throws {
        let jsonData = try  #require("\"RIGHT_COMETH\"".data(using: .utf8))
        let decodedConference = try? JSONDecoder().decode(AstralType.self, from: jsonData )
        #expect(decodedConference == .cometh(direction: "right"))
    }
    
    @Test("Test chain with more than two componets") func moreThanTwoComponents() async throws {
        let jsonData = try #require("\"RIGHT_COMETH_2\"".data(using: .utf8))
        let decodedConference = try? JSONDecoder().decode(AstralType.self, from: jsonData )
        #expect(decodedConference == nil)
    }
}
