//
//  DataStoreImp.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Combine

/// Contains the implementation of methods for performing locally stored data  calls.
class DataStoreImp: DataStore {
    
    // MARK: - Properties
    private let coreDataManager =  CoreDataManager.shared

    // MARK: - Methods
    func addCatchedPokemon(pokemon: Pokemon) -> AnyPublisher<Bool, Error> {
        self.coreDataManager.addCatchedPokemon(pokemon: pokemon).eraseToAnyPublisher()
    }
    
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error> {
        self.coreDataManager.getmyPokemons()
    }
    
    func pokemonIsCatched(_ pokemon: Pokemon) -> Bool {
        self.coreDataManager.pokemonIsCatched(pokemon)
    }
    
}
