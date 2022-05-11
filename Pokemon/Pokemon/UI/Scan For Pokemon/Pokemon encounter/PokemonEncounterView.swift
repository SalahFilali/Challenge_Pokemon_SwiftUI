//
//  PokemonEncounterView.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import SwiftUI

struct PokemonEncounterView: View {
    
    @State var encounteredPokemon: Pokemon
    
    @State var catched: Bool
    
    var body: some View {
        VStack(
                alignment: .center,
                spacing: 20
            ) {
                AsyncImage(url: URL(string: self.encounteredPokemon.imagePath)) { image in
                    image.resizable()
                } placeholder: {
                    Color.white
                }
                .frame(width: 250, height: 250, alignment: .center)
                
                if self.catched {
                    Text(NSLocalizedString("pokemon_already_caught_message", comment: ""))
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text(self.encounteredPokemon.name)
                
                Text(String.localizedStringWithFormat(
                    NSLocalizedString("pokemon_height_text", comment: ""),
                    self.encounteredPokemon.height*10)
                    )
                
                Text(String.localizedStringWithFormat(
                    NSLocalizedString("pokemon_weight_text", comment: ""),
                    self.encounteredPokemon.weight/10)
                )
            }.padding()
        
    }
}

