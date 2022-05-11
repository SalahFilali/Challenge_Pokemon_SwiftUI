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
    
    @State private var isShowingMyPokemonsView = false
    
    var body: some View {
        
        switch viewModel.viewState {
        case .initial:
            
            NavigationView {
                VStack(alignment: .center, spacing: 20) {
                    HStack() {
                        if self.isShowingMyPokemonsView {
                            NavigationLink(isActive: self.$isShowingMyPokemonsView) {
                                MyPokemonsView()
                            } label: {
                                Text("")
                            }
                        }
                        Spacer()
                        Button(action: {
                            self.isShowingMyPokemonsView = true
                        }) {
                            Image("backpack_ic")
                        }
                    }
                    .padding(.trailing, 20)
                    Spacer()
                    Text(self.viewModel.errorMessage)
                        .padding()
                        .multilineTextAlignment(.center)
                    Button {
                        self.viewModel.scanForPokemon()
                    } label: {
                        Text(self.viewModel.scanButtonTitle)
                    }
                    Spacer()
                }
                .navigationBarHidden(true)
                .padding(.top, 20)
            }
            
        case .loading:
            ZStack {
                Color.white
                ProgressView()
                    .progressViewStyle(.circular)
            }
        case .failed(let errorMesssage):
            NavigationView {
                VStack(alignment: .center, spacing: 20) {
                    HStack() {
                        if self.isShowingMyPokemonsView {
                            NavigationLink(isActive: self.$isShowingMyPokemonsView) {
                                MyPokemonsView()
                            } label: {
                                Text("")
                            }
                        }
                        Spacer()
                        Button(action: {
                            self.isShowingMyPokemonsView = true
                        }) {
                            Image("backpack_ic")
                        }
                    }
                    .padding(.trailing, 20)
                    Spacer()
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
                .navigationBarHidden(true)
                .padding(.top, 20)
            }
        case .encounter(let pokemon, let catchable):
            NavigationView {
                VStack(alignment: .center, spacing: 20) {
                    HStack() {
                        if self.isShowingMyPokemonsView {
                            NavigationLink(isActive: self.$isShowingMyPokemonsView) {
                                MyPokemonsView()
                            } label: {
                                Text("")
                            }
                        }
                        Spacer()
                        Button(action: {
                            self.isShowingMyPokemonsView = true
                        }) {
                            Image("backpack_ic")
                        }
                    }
                    .padding(.trailing, 20)
                    Spacer()
                    PokemonEncounterView(encounteredPokemon: pokemon, catched: !catchable)
                    HStack(alignment: .center, spacing: 20) {
                        if catchable {
                            Button {
                                self.viewModel.catchPokemon(pokemon)
                            } label: {
                                Text("Catch")
                            }
                        }
                        
                        Button {
                            self.viewModel.hideEncounteredPokemonView()
                        } label: {
                            Text("Leave")
                        }
                    }.padding(20)
                    Spacer()
                }
                .navigationBarHidden(true)
                .padding(.top, 20)
            }
            
        }
    }
}
struct ScanForPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        ScanForPokemonView()
    }
}
