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
    
    private(set) var errorMessage: String = "Start your jouney to become a Pokémon master!"
    private(set) var scanButtonTitle: String = "Scan"
    
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
                print("scan for pokemon error: \(error.localizedDescription)")
                self.handle(error: error)
                self.viewState = .failed(errorMesssage: self.errorMessage)
            }
        }) { pokemon in
            self.viewState = .encounter(pokemon: pokemon)
        }
    }
    
    func handle(error: Error) {
        
        let errorObject = error as NSError
        switch errorObject.code {
        case ResponseCode.internetConnectionError:
            self.errorMessage = "Please check your internet connection or try again later."
            self.scanButtonTitle = "Retry"
        case ResponseCode.httpNotFound:
            self.errorMessage = "No Pokemons around please try again later."
        default:
            self.errorMessage = "Oops! An error has occurred. Please try again later."
            self.scanButtonTitle = "Retry"
        }
    }
    
    func hideEncounteredPokemonView() {
        self.viewState = .initial
        self.errorMessage = "Start your jouney to become a Pokémon master!"
        self.scanButtonTitle = "Scan"
    }
    
}
