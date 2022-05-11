//
//  CoreDataManager.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import CoreData
import Combine

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    // MARK: - Properties
    public lazy var context: NSManagedObjectContext = {
        return container.viewContext
    } ()
    
    public lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    // MARK: - Methods
    private init() {}
    
    
    /// Saves the catched Pookemon in Data Base
    /// - Parameter pokemon: The pokemon to catch
    /// - Returns: AnyPublisher with true Bool value if the Pokemon is caught or Error
    public func addCatchedPokemon(pokemon: Pokemon) -> AnyPublisher<Bool, Error>{
        Future<Bool, Error>.init {[weak self] promise in
            guard let self = self else {
                return promise(.failure(NSError(domain: "No data", code: 0)))
            }
            self.createCatchedPokemon(pokemon: pokemon)
            do {
                try self.context.save()
                promise(.success(true))
            } catch {

                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }.eraseToAnyPublisher()
    }
    
    /// Transform the encountred Pokemon of type Pokemon to a CatchedPokemon type and with a catched_at property
    /// - Parameter pokemon: The given Pokemon to transform to a CatchedPokemn
    
    private func createCatchedPokemon(pokemon: Pokemon) {
        let catchedPokemon = CatchedPokemon(context: self.container.viewContext)
        catchedPokemon.id = Int16(pokemon.id)
        catchedPokemon.name = pokemon.name
        catchedPokemon.weight = Int16(pokemon.weight)
        catchedPokemon.height = Int16(pokemon.height)
        catchedPokemon.base_experience = Int16(pokemon.baseExperience)
        catchedPokemon.image_path = pokemon.imagePath
        catchedPokemon.type = NSSet(array: pokemon.type.map({ type -> CatchedPokemonType in
            let catchedPokemonType = CatchedPokemonType(context: self.container.viewContext)
            catchedPokemonType.name = type.name
            return catchedPokemonType
        }))
        catchedPokemon.order = Int16(pokemon.order)
        if let date = Date().dateWithFormat() {
            catchedPokemon.catched_at = date
        }
    }

    /// The array of catched Pokemons saved in Data Base
    /// - Returns: AnyPublisher with array of CatchedPokemons or Error
    public func getmyPokemons() -> AnyPublisher<[CatchedPokemon], Error>{
            return  Future<[CatchedPokemon], Error>.init {[weak self] promise in
                guard let self = self else {
                    return promise(.failure(NSError(domain: "No data", code: 0)))
                }
                do {
                    let fetshRequest: NSFetchRequest<CatchedPokemon> = CatchedPokemon.fetchRequest()
                    let sort = NSSortDescriptor(key: "order", ascending: true)
                    fetshRequest.sortDescriptors = [sort]
                    let pokemons = try self.context.fetch(fetshRequest)
                    promise(.success(pokemons))
                }catch{
                    promise(.failure(error))
                }

            }.eraseToAnyPublisher()
        }
    
    
    /// Check if the given Pokemon is already catched
    /// - Parameter pokemon: The encountered pokemon
    /// - Returns: True if the given Pokemon is already catched or False iif not
    public func pokemonIsCatched(_ pokemon: Pokemon) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatchedPokemon")
        fetchRequest.predicate = NSPredicate(format: "id == %i", Int16(pokemon.id))
        return ((try? self.container.viewContext.count(for: fetchRequest)) ?? 0) > 0
    }
}
