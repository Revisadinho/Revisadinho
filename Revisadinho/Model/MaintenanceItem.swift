//
//  MaintenanceItem.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 14/09/21.
//  swiftlint:disable identifier_name

import Foundation

public enum MaintenanceItem: Int, CaseIterable, Codable {
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
        case .AirFilter: return "Filtro de Ar do Motor"
        case .AirConditioningFilter: return "Filtro de Ar Condicionado"
        case .FuelFilter: return "Filtro de Combustível"
        case .Candle: return "Vela"
        case .EngineOil: return "Óleo do Motor"
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

    var maintenanceInterval: Double {
        switch self {
        case .WheelAlignment: return 10000.0
        case .TireBalance: return 10000.0
        case .TimingBelt: return 40000.0
        case .AirFilter: return 10000.0
        case .AirConditioningFilter: return 15000.0
        case .FuelFilter: return 10000.0
        case .Candle: return 10000.0
        case .EngineOil: return 5000.0 // hardcoded for 5k Km, but it depends on the vehicle model
        case .RadiatorFluid: return 30000.0
        case .BrakeFluid: return 20000.0
        case .BrakePad: return 20000.0
        case .TireCalibration: return 5000.0
        case .TireChange: return 35000.0
        case .WindshieldWiper: return 20000.0
        case .LightBulbs: return 20000.0
        case .Exhaust: return 20000.0
        case .ElectronicInjection: return 20000.0
        case .Transmission: return 60000.0
        case .Battery: return 60000.0
        case .Clutch: return 100000.0
        case .Suspension: return 50000.0
        }
    }
}
