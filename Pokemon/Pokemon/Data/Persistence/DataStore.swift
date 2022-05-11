//
//  DataStore.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Combine

/// Contains the abstraction of methods for performing locally stored data  calls.
protocol DataStore {
    
    /// Catch an encountered Pokemon
    /// - Returns: AnyPublisher with true Bool value if the Pokemon is caught or Error
    func addCatchedPokemon(pokemon: Pokemon) -> AnyPublisher<Bool, Error>
    
    /// Check if the encountered Pokemon is already catched.
    /// - Returns: True if the encountered Pokemon is already catched or false if not
    func pokemonIsCatched(_ pokemon: Pokemon) -> Bool
    
    /// Get the catched Pokemons
    /// - Returns: AnyPublisher with the array of catched Pokemon or Error
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error>
    
}
