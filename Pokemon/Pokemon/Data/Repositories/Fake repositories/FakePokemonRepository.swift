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
    
    func catchPokemon(_ pokemon: Pokemon) -> AnyPublisher<Bool, Error> {
        if errorCode != nil {
            return Fail(error: NSError(domain: "error catching Pokemon", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return Future<Bool, Error>.init { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
        
    }
    
    private func createCatchedPokemon(from pokemon: Pokemon) -> CatchedPokemon {
        let catchedPokemon = CatchedPokemon()
        catchedPokemon.id = Int16(pokemon.id)
        catchedPokemon.name = pokemon.name
        catchedPokemon.weight = Int16(pokemon.weight)
        catchedPokemon.height = Int16(pokemon.height)
        catchedPokemon.base_experience = Int16(pokemon.baseExperience)
        catchedPokemon.image_path = pokemon.imagePath
        catchedPokemon.type = NSSet(array: pokemon.type.map({ type -> CatchedPokemonType in
            let catchedPokemonType = CatchedPokemonType()
            catchedPokemonType.name = type.name
            return catchedPokemonType
        }))
        catchedPokemon.order = Int16(pokemon.order)
        catchedPokemon.catched_at = Date()
    
        return catchedPokemon
    }
    
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error> {
        if errorCode != nil {
            return Fail(error: NSError(domain: "error fetching my Pokemons", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        else {
            return Future<[CatchedPokemon], Error>.init { promise in
                let beedrill = Pokemon(id: 1, weight: 2900, height: 10, baseExperience: 178, order: 5, name: "beedrill", type: [PokemonType(name: "poison"), PokemonType(name: "bug")])
                
                let diglet = Pokemon(id: 2, weight: 0, height: 20, baseExperience: 53, order: 6, name: "diglet", type: [PokemonType(name: "groound")])
                
                let caughtBeedrill = self.createCatchedPokemon(from: beedrill)
                let caughtDiglet = self.createCatchedPokemon(from: diglet)
                promise(.success([caughtBeedrill, caughtDiglet]))
            }.eraseToAnyPublisher()
        }
    }
}
