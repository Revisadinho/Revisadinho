//
//  LigthsViewModel.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace

import Foundation

class LightsViewModel {
    
    var jParser = JsonParser()
    var lightsInfo: [JSLights] = []
    
    func getLightsInfo() -> [JSLights] {
        lightsInfo = jParser.parsingLights()
        return lightsInfo
    }
}
