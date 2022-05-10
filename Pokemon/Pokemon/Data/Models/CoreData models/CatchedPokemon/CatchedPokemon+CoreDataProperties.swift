//
//  CatchedPokemon+CoreDataProperties.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//
//

import Foundation
import CoreData


extension CatchedPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatchedPokemon> {
        return NSFetchRequest<CatchedPokemon>(entityName: "CatchedPokemon")
    }

    @NSManaged public var base_experience: Int16
    @NSManaged public var catched_at: Date?
    @NSManaged public var height: Int16
    @NSManaged public var id: Int16
    @NSManaged public var image_path: String?
    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var type: NSSet?
    
    /// Wrapper for CatchedAt property
    public var unwrappedCatchedAt: Date {
        catched_at ?? Date()
    }
    
    /// Wrapper for ImagePath property
    public var unwrappedImagePath: String {
        image_path ?? "unknown image"
    }
    
    /// Wrapper for name property
    public var unwrappedName: String {
        name ?? "unknown pokemon"
    }
    
    /// Wrapper for type property
    public var typesArray: [CatchedPokemonType] {
        let typesSet = type as? Set<CatchedPokemonType> ?? []
        return Array(typesSet)
    }

}

// MARK: Generated accessors for type
extension CatchedPokemon {

    @objc(addTypeObject:)
    @NSManaged public func addToType(_ value: CatchedPokemonType)

    @objc(removeTypeObject:)
    @NSManaged public func removeFromType(_ value: CatchedPokemonType)

    @objc(addType:)
    @NSManaged public func addToType(_ values: NSSet)

    @objc(removeType:)
    @NSManaged public func removeFromType(_ values: NSSet)

}

extension CatchedPokemon : Identifiable {

}
