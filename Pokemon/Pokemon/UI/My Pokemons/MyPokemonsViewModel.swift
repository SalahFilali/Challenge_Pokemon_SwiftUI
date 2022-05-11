//
//  MyPokemonsViewModel.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation
import Combine

class MyPokemonsViewModel:ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var viewState = MyPokemonsViewState.initial
    
    private(set) var infoMessage: String = NSLocalizedString("empty_list_text", comment: "")

    @Published var myPokemons: [CatchedPokemon] = []
    
    @Published var selectedPokemon: CatchedPokemon?
    
    @Published var showingPokemonDetails = false
    
    
    let pokemonRepository: PokemonRepository
    
    var cancellable: AnyCancellable?
    
    // MARK: - Methods
    init(pokemonRepository: PokemonRepository) {
        self.pokemonRepository = pokemonRepository
        self.catchedPokemons()
    }
    
    /// Retrieve caught Pokemons 
    func catchedPokemons(){
        self.viewState = .loading
        cancellable = self.pokemonRepository.getmyPokemons()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.viewState = .failed(errorMesssage: NSLocalizedString("global_error_text", comment: ""))
                }
            }, receiveValue: { pokemons in
                if pokemons.isEmpty {
                    self.viewState = .empty
                }else {
                    self.viewState = .showList(pokemons: pokemons)
                }
            })
    }
    
    /// Show the selected  Pokemon details
    /// - Parameter pokemon: the selected Pokemon
    func showPokemonDetails(_ pokemon: CatchedPokemon) {
        self.selectedPokemon = pokemon
        self.showingPokemonDetails = true
    }
    
}
