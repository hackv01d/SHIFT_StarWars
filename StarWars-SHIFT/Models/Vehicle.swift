//
//  Vehicle.swift
//  StarWars-SHIFT
//
//  Created by Ivan Semenov on 04.02.2023.
//

import Foundation

struct Vehicle {
    let name, model, manufacturer, costInCredits: String
    let length, maxAtmospheringSpeed, crew, passengers: String
    let cargoCapacity, consumables, vehicleClass: String
    let pilots, films: [String]
    let url, created, edited: String
}

extension Vehicle: ContentViewCellViewModelData {
    var subTitle: String { "" }
    var shouldShowSubTitle: Bool { false }
}

extension Vehicle: DetailsViewModelData {
    var details: String {
        """
        Model: \(model)
        Manufacturer: \(manufacturer)
        Class: \(vehicleClass)
        Cost: \(costInCredits) credits
        Speed: \(maxAtmospheringSpeed)km/h
        Lenght: \(length)m
        Minimum Crew: \(crew)
        Passengers: \(passengers)
        """
    }
    
    var speciesURL: [String]? { nil }
    var homeworldURL: String? { nil }
    
    var shouldShowSpecies: Bool { false }
    var shouldShowHomeWorld: Bool { false }
}
