//
//  MaintenanceItem.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 14/09/21.
//  swiftlint:disable identifier_name

import Foundation

public enum MaintenanceItem: Int, CaseIterable {
    case WheelAlignment = 0
    case TireBalance
    case TimingBelt
    case AirFilter
    case AirConditioningFilter
    case FuelFilter
    case Candle
    case EngineOil
    case RadiatorFluid
    case BrakeFluid
    case BrakePad
    case TireCalibration
    case TireChange
    case WindshieldWiper
    case LightBulbs
    case Exhaust
    case ElectronicInjection
    case Transmission
    case Battery
    case Clutch
    case Suspension

    var description: String {
        switch self {
        case .WheelAlignment: return "Alinhamento"
        case .TireBalance: return "Balanceamento"
        case .TimingBelt: return "Correia Dentada"
        case .AirFilter: return "Filtro de Ar Motor"
        case .AirConditioningFilter: return "Filtro de Ar Condicionado"
        case .FuelFilter: return "Filtro de Combustível"
        case .Candle: return "Vela"
        case .EngineOil: return "Oleo do Motor"
        case .RadiatorFluid: return "Aditivo do Radiador"
        case .BrakeFluid: return "Fluido de Freio"
        case .BrakePad: return "Pastilha de Freio"
        case .TireCalibration: return "Calibragem"
        case .TireChange: return "Troca de Pneu"
        case .WindshieldWiper: return "Limpador de Parabrisa"
        case .LightBulbs: return "Lâmpadas"
        case .Exhaust: return "Escapamento"
        case .ElectronicInjection: return "Injeção Eletrônica"
        case .Transmission: return "Transmissão"
        case .Battery: return "Bateria"
        case .Clutch: return "Embreagem"
        case .Suspension: return "Suspensão"
        }
    }
}
