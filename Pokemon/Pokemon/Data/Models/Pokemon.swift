//
//  Pokemon.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation

struct Pokemon: Decodable, Identifiable{
    
    let id,  weight, height, baseExperience, order: Int
    let name, imagePath : String
    let type: [PokemonType]
    private(set) var catchedAt: Date?
    private(set) var isCatched: Bool = false
    
    enum PokemonCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case weight = "weight"
        case height = "height"
        case baseExperience = "base_experience"
        case sprites = "sprites"
        case types = "types"
        case order = "order"
    }
    
    enum PokemonImageCodingKeys: String, CodingKey {
        case imagePath = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonCodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.height = try container.decode(Int.self, forKey: .height)
        self.baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        self.name = try container.decode(String.self, forKey: .name)
        
        let pokemonImageContainer = try container.nestedContainer(keyedBy: PokemonImageCodingKeys.self, forKey: .sprites)
        self.imagePath = try pokemonImageContainer.decode(String.self, forKey: .imagePath)
        
        self.type = try container.decode([PokemonType].self, forKey: .types)
        self.order = try container.decode(Int.self, forKey: .order)
    }
    
    public mutating func pokemonIsCatched() {
        self.isCatched = true
    }
    
    public init(id: Int, weight: Int, height: Int, baseExperience: Int, order: Int, name: String, imagePath : String = "",type: [PokemonType] , isCatched: Bool = false){
        self.id = id
        self.weight = weight
        self.height = height
        self.baseExperience = baseExperience
        self.order = order
        self.name = name
        self.imagePath = imagePath
        self.type = type
        self.isCatched = isCatched
    }
}

class PokemonType: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
    
    enum PokemonTypeNameCodingKeys: String, CodingKey {
        case typeName = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let pokemonTypeNameContainer = try container.nestedContainer(keyedBy: PokemonTypeNameCodingKeys.self, forKey: .type)
        self.name = try pokemonTypeNameContainer.decode(String.self, forKey: .typeName)
    }
    
    public init(name: String) {
        self.name = name
    }
}

