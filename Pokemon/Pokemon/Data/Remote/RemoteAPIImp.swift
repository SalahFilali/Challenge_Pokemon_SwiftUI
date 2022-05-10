//
//  RemoteAPIImp.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation
import Combine

/// Contains the implementation of methods for performing API  calls.
class RemoteAPIImp: RemoteAPI {
    
    // MARK: - Properties
    private let urlSessionManager: URLSessionManager
    
    // MARK: - Methods
    init(urlSessionManager: URLSessionManager) {
        self.urlSessionManager = urlSessionManager
    }
    
    func scanForPokemon() -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...1000))") else {
            return Fail(error: NSError(domain: "error url", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return self.urlSessionManager.dataTask(with: url).decode(type: Pokemon.self, decoder: JSONDecoder()).eraseToAnyPublisher()
    }
    
}
