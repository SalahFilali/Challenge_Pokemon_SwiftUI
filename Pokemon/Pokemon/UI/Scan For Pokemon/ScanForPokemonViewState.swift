//
//  ScanForPokemonViewState.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation

enum ScanForPokemonViewState: Equatable {
      static func == (lhs: ScanForPokemonViewState, rhs: ScanForPokemonViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case  (.loading, .loading):
            return true
        case (.failed(let lhs), .failed(let rhs)):
            return lhs == rhs
        case (.encounter(let lhs, _), .encounter(let rhs, _)):
            return lhs.id == rhs.id
        default:
            return false
        }
    }
    
    case initial
    case loading
    case failed(errorMesssage: String)
    case encounter(pokemon: Pokemon, catchable: Bool)
}

