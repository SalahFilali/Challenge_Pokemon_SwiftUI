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
    
    private(set) var infoMessage: String = "No Pokemons catched yet!"

    @Published var myPokemons: [CatchedPokemon] = []
    
    @Published var selectedPokemon: CatchedPokemon?
    
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
                    self.viewState = .failed(errorMesssage: "Oops! An error has occurred. Please try again later.")
                }
            }, receiveValue: { pokemons in
                if pokemons.isEmpty {
                    self.viewState = .empty
                }else {
                    self.viewState = .showList(pokemons: pokemons)
                }
            })
    }
    
}
