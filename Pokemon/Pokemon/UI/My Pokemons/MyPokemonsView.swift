//
//  MyPokemonsView.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import SwiftUI

struct MyPokemonsView: View {
    @ObservedObject var viewModel = MyPokemonsViewModel(
        pokemonRepository: PokemonRepositoryImp(
            remoteAPI: RemoteAPIImp(
                urlSessionManager: URLSessionManager()
            ),
            dataStore: DataStoreImp()
        )
    )
    
    let config = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        switch self.viewModel.viewState {
        case .initial:
            Color.white
        case .loading:
            ZStack {
                Color.white
                ProgressView()
                    .progressViewStyle(.circular)
            }
        case .empty:
            Text(self.viewModel.infoMessage)
        case .showList(let pokemons):
            ScrollView {
                LazyVGrid(columns: config, alignment: .center, spacing: 10) {
                    ForEach(pokemons, id: \.self) { pokemon in
                        VStack(alignment: .center, spacing: 3) {
                            AsyncImage(url: URL(string: pokemon.image_path ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.white
                            }
                            .frame(width: 100, height: 100, alignment: .leading)
                            
                            Text(pokemon.name ?? "")
                                .multilineTextAlignment(.center)
                            
                        }
                    }
                    .frame(height: 150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1))
                }
            }
        case .failed(let errorMesssage):
            Text(errorMesssage)
        }
    }
}

struct MyPokemonsView_Previews: PreviewProvider {
    static var previews: some View {
        MyPokemonsView()
    }
}
