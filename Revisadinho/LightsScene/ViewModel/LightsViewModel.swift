//
//  LigthsViewModel.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.

import Foundation
// swiftlint:disable trailing_whitespace

import Foundation

class LightsViewModel {
    
    var jParser = JsonParser()
    var lightsInfo: [JSLights] = []
    
    func getLightsInfo() -> [JSLights] {
        lightsInfo = jParser.parsingLights()
        return lightsInfo
    }
    
    func getLightsByName(name: String) -> [JSLights] {
        lightsInfo = jParser.parsingLights()
        var lightsFind = [JSLights]()
        
        for light in lightsInfo {
            if light.name.localizedStandardContains(name) {
                lightsFind.append(light)
            }
        }
        
        return lightsFind
    }
}
