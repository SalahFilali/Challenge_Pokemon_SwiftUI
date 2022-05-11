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
            
            Text("Weight: \(self.pokemon.weight/10)  KG")
            
            Text("Height: \(self.pokemon.height*10)  cm")
            
            Text("Base experience: \(self.pokemon.base_experience)")
            
            let pokemonTypes = pokemon.typesArray.map { type -> String in
                type.unwrappedname
            }.joined(separator: ", ")
            Text("Type: \(pokemonTypes)")
            
            Text("Caught at: \(self.pokemon.unwrappedCatchedAt.dateToString())")
        }
        Spacer()
    }
}

