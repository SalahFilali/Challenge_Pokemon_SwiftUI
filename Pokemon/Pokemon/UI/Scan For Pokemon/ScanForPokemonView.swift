//
//  ScanForPokemonView.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import SwiftUI

struct ScanForPokemonView: View {
    
    @ObservedObject var viewModel = ScanForPokemonViewModel(
        pokemonRepository: PokemonRepositoryImp(
            remoteAPI: RemoteAPIImp(
                urlSessionManager: URLSessionManager()
            ),
            dataStore: DataStoreImp()
        )
    )
    
    var body: some View {
        
        switch viewModel.viewState {
        case .initial:
            VStack(alignment: .center, spacing: 20) {
                Text(self.viewModel.errorMessage)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Button {
                    self.viewModel.scanForPokemon()
                } label: {
                    Text(self.viewModel.scanButtonTitle)
                }
            }
            
        case .loading:
            ZStack {
                Color.white
                ProgressView()
                    .progressViewStyle(.circular)
            }
        case .failed(let errorMesssage):
            VStack(alignment: .center, spacing: 20) {
                Text("\(errorMesssage)")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Button {
                    self.viewModel.scanForPokemon()
                } label: {
                    Text(viewModel.scanButtonTitle)
                }
                Spacer()
            }
            
        case .encounter(let pokemon, let catchable):
            VStack(alignment: .center, spacing: 20) {
                
                PokemonEncounterView(encounteredPokemon: pokemon, catched: !catchable)
                
                HStack(alignment: .center, spacing: 20) {
                    
                    Button {
                        self.viewModel.catchPokemon(pokemon)
                    } label: {
                        Text("Catch")
                    }
                    
                    Button {
                        self.viewModel.hideEncounteredPokemonView()
                    } label: {
                        Text("Leave")
                    }
                }.padding(20)
            }
        }
    }
}

struct ScanForPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        ScanForPokemonView()
    }
}
