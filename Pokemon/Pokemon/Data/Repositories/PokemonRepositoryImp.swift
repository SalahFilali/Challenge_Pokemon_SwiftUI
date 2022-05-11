//
//  PokemonRepositoryImp.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Combine

/// PokemonRepositoryImp contains the implementaion of PokemonRepository methods
class PokemonRepositoryImp: PokemonRepository {
    
    // MARK: - Properties
    
    /// remoteAPI is the Provider for API methods
    private let remoteAPI: RemoteAPI
    
    /// dataStore is the Provider for locally stored data methods
    private let dataStore: DataStore
    
    // MARK: - Methods
    init(
        remoteAPI: RemoteAPI,
        dataStore: DataStore
    ) {
        self.remoteAPI = remoteAPI
        self.dataStore = dataStore
    }
    
    func scanForPokemon() -> AnyPublisher<Pokemon, Error> {
        self.remoteAPI.scanForPokemon().flatMap{ pokemon -> AnyPublisher<Pokemon, Error> in
            Future<Pokemon, Error>.init { promise in
                if !self.dataStore.pokemonIsCatched(pokemon) {
                    promise(.success(pokemon))
                }
                var alreadyCatchedPokemon = pokemon
                alreadyCatchedPokemon.pokemonIsCatched()
                promise(.success(alreadyCatchedPokemon))
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    func catchPokemon(_ pokemon: Pokemon) -> AnyPublisher<Bool, Error> {
        self.dataStore.addCatchedPokemon(pokemon: pokemon)
    }
    
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error> {
        self.dataStore.getmyPokemons()
    }
    
}
