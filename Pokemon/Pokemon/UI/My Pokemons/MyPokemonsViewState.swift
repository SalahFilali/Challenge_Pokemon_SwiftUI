//
//  MyPokemonsViewState.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation

enum MyPokemonsViewState: Equatable {
      static func == (lhs: MyPokemonsViewState, rhs: MyPokemonsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.empty, .empty):
            return true
        case  (.loading, .loading):
            return true
        case (.failed(let lhs), .failed(let rhs)):
            return lhs == rhs
        case (.showList(let lhs), .showList(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    case initial
    case empty
    case loading
    case failed(errorMesssage: String)
    case showList(pokemons: [CatchedPokemon])
}

