//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Combine

/// Contains the abstraction of methods for performing API or locally stored data calls for Pokemon.

protocol PokemonRepository {
    
    /// Search for surrounding Pokemons
    /// - Returns: }AnyPublisher containing the encountred Pokemon or an Error
    func scanForPokemon() -> AnyPublisher<Pokemon, Error>
    
    /// Catch the encountered Pokemon
    /// - Returns: AnyPublisher with true Bool value if the Pokemon is caught or error
    func catchPokemon(_ pokemon: Pokemon) -> AnyPublisher<Bool, Error>
    
    /// Get the catched Pokemons
    /// - Returns: AnyPublisher with the array of catched Pokemon or Error
    func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error>
    
}
