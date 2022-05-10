//
//  PokemonEncounterView.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import SwiftUI

struct PokemonEncounterView: View {
    
    @State var encounteredPokemon: Pokemon
    
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
                
                Text(self.encounteredPokemon.name)
                
                Text("Height: \(self.encounteredPokemon.weight/10)  KG")
                
                Text("Weight: \(self.encounteredPokemon.height*10) cm")
            }.padding()
        
    }
}

