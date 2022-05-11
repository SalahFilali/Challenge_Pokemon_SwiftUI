//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Salah Filali on 11/5/2022.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var pokemon: CatchedPokemon
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                }
                
                Spacer()
            }.padding(20)
                .padding(.top, 10)
            
            Text(self.pokemon.unwrappedName)
            
            AsyncImage(url: URL(string: self.pokemon.unwrappedImagePath)) { image in
                image.resizable()
            }placeholder: {
                Color.gray
            }
            .frame(width: 200, height: 200, alignment: .center)
            
            Text(
                String.localizedStringWithFormat(
                NSLocalizedString("pokemon_weight_text", comment: ""),
                self.pokemon.weight/10)
            )
            
            Text(
                String.localizedStringWithFormat(
                NSLocalizedString("pokemon_height_text", comment: ""),
                self.pokemon.height*10)
                )
            
            Text(
                String.localizedStringWithFormat(
                NSLocalizedString("base_experience_text", comment: ""),
                self.pokemon.base_experience)
            )
            
            let pokemonTypes = pokemon.typesArray.map { type -> String in
                type.unwrappedname
            }.joined(separator: ", ")
            Text(
                String.localizedStringWithFormat(
                NSLocalizedString("type_text", comment: ""),
                pokemonTypes)
            )
            
            Text(
                String.localizedStringWithFormat(
                NSLocalizedString("caught_at_text", comment: ""),
                self.pokemon.unwrappedCatchedAt.dateToString())
            )
            
        }
        Spacer()
    }
}

