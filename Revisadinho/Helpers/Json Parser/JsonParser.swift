//
//  JsonParser.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 21/10/21.
//
// swiftlint:disable trailing_whitespace

import Foundation

class JsonParser {
    
    var lightsJson = "LightsContent"
    
    func parsingLights() -> [JSLights] {
        
        let decoder = JSONDecoder()
        var lightsInfo: [JSLights] = []
        
        do {
            if let bundlePath = Bundle.main.path(forResource: lightsJson, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                lightsInfo = try decoder.decode([JSLights].self, from: jsonData)
                lightsInfo = lightsInfo.sorted {
                    $0.name.lowercased() < $1.name.lowercased()
                }
                
                return lightsInfo
            }
        } catch {
            print(error)
        }
        
        return lightsInfo
    }
    
}
