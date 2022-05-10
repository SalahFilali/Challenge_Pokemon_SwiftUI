//
//  RemoteAPI.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Combine


/// Contains the absstraction of methods for performing API  calls.
protocol RemoteAPI {
    
    /// Search for surrounding Pokemons
    /// - Returns: AnyPublisher containing the encountred Pokemon or an Error
    func scanForPokemon() -> AnyPublisher<Pokemon, Error>
    
}
