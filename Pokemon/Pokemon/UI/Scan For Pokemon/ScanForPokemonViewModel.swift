//
//  ScanForPokemonViewModel.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation
import Combine

class ScanForPokemonViewModel:ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var viewState = ScanForPokemonViewState.initial
    
    private(set) var errorMessage: String = NSLocalizedString("welcome_text", comment: "")
    private(set) var scanButtonTitle: String = NSLocalizedString("scan_button_text", comment: "")
    
    var cancellable: AnyCancellable?
    
    let pokemonRepository: PokemonRepository
    
    // MARK: - Methods
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
    }
    
    /// Search for surrounding Pokemons
    func scanForPokemon() {
        self.viewState = .loading
        cancellable = self.pokemonRepository.scanForPokemon()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.handle(error: error)
                self.viewState = .failed(errorMesssage: self.errorMessage)
            }
        }) { pokemon in
            self.viewState = .encounter(pokemon: pokemon, catchable: !pokemon.isCatched)
        }
    }
    
    /// Catch the encountered Pokemon
    /// - Parameter pokemon: The encountered Pokemon
    public func catchPokemon(_ pokemon: Pokemon) {
        self.viewState = .loading
        cancellable = self.pokemonRepository.catchPokemon(pokemon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.viewState = .failed(errorMesssage: NSLocalizedString("global_error_text", comment: ""))
                }
            }, receiveValue: { _ in
                self.scanForPokemon()
            })
    }
    
    func handle(error: Error) {
        
        let errorObject = error as NSError
        switch errorObject.code {
        case ResponseCode.internetConnectionError:
            self.errorMessage = NSLocalizedString("internet_connection_error_text", comment: "")
            self.scanButtonTitle = NSLocalizedString("retry_button_text", comment: "")
        case ResponseCode.httpNotFound:
            self.errorMessage = NSLocalizedString("not_found_error_text", comment: "")
        default:
            self.errorMessage = NSLocalizedString("global_error_text", comment: "")
            self.scanButtonTitle = NSLocalizedString("retry_button_text", comment: "")
        }
    }
    
    func hideEncounteredPokemonView() {
        self.viewState = .initial
        self.errorMessage = NSLocalizedString("welcome_text", comment: "")
        self.scanButtonTitle = NSLocalizedString("scan_button_text", comment: "")
    }
    
}
