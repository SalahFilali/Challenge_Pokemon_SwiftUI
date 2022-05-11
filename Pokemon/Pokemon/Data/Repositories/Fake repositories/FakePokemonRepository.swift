//
//  FakePokemonRepository.swift
//  Pokemon
//
//  Created by Salah Filali on 11/5/2022.
//

import Foundation
import Combine

/// A fake mocked Repository to use for UnitTesting
class FakeRepository: PokemonRepository {
    
    let errorCode: Int?
    
    init(with errorCode: Int? = nil) {
        self.errorCode = errorCode
    }
    
    func scanForPokemon() -> AnyPublisher<Pokemon, Error> {
        if let errorCode = errorCode {
            return Fail(error: NSError(domain: "Test error", code: errorCode, userInfo: nil)).eraseToAnyPublisher()
        }
        
        let pokemon = Pokemon(id: 1, weight: 50, height: 100, baseExperience: 100, order: 1, name: "Pokemon for test", type: [PokemonType(name: "dark"), PokemonType(name: "fighting")])
        
        return Future<Pokemon, Error>.init { promise in
            promise(.success(pokemon))
        }.eraseToAnyPublisher()
    }
    
    func catchPokemon(_ pokemon: Pokemon) -> AnyPublisher<CatchedPokemon, Error> {
        return Fail(error: NSError(domain: "error catching Pokemon", code: 0, userInfo: nil)).eraseToAnyPublisher()
    }
    
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error> {
        return Fail(error: NSError(domain: "error fetching my Pokemons", code: 0, userInfo: nil)).eraseToAnyPublisher()
    }
}
