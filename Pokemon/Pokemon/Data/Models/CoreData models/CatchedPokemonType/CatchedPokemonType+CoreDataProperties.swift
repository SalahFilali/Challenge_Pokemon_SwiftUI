//
//  CatchedPokemonType+CoreDataProperties.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//
//

import Foundation
import CoreData


extension CatchedPokemonType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatchedPokemonType> {
        return NSFetchRequest<CatchedPokemonType>(entityName: "CatchedPokemonType")
    }

    @NSManaged public var name: String?
    @NSManaged public var pokemon: CatchedPokemon?
    
    /// Wrapper for name property
    public var unwrappedname: String {
        name ?? "unknown type"
    }

}

extension CatchedPokemonType : Identifiable {

}
