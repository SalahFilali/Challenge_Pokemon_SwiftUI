//
//  ScanForPokemonViewModelTests.swift
//  PokemonTests
//
//  Created by Salah Filali on 11/5/2022.
//

import XCTest
import Combine
@testable import Pokemon

class ScanForPokemonViewModelTests: XCTestCase {

    var sut: ScanForPokemonViewModel!
    
    override func setUp() {
        let fakeRepository = FakeRepository()
        sut = ScanForPokemonViewModel(pokemonRepository: fakeRepository)
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testScanForPokemonViewModel_ScanForPokemonWithSucess() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_WithSucess")
        expectation.assertForOverFulfill = false
        
        let expectedPokemon = Pokemon(id: 1, weight: 50, height: 100, baseExperience: 100, order: 1, name: "Pokemon for test", type: [PokemonType(name: "dark"), PokemonType(name: "fighting")])
        
        sut.scanForPokemon()

        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .encounter(pokemon: expectedPokemon, catchable: !expectedPokemon.isCatched))
                cancellable?.cancel()
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testScanForPokemonViewModel_ScanForPokemonWithNotFoundError() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_NotFoundError")
        expectation.assertForOverFulfill = false
        let fakeRepository = FakeRepository(with: ResponseCode.httpNotFound)
        sut = ScanForPokemonViewModel(pokemonRepository: fakeRepository)
        sut.scanForPokemon()

        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .failed(errorMesssage: "No Pokemons around please try again later."))
                cancellable?.cancel()
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testScanForPokemonViewModel_ScanForPokemonWithInternetConnectionError() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_WithInternetConnectionError")
        expectation.assertForOverFulfill = false
        let fakeRepository = FakeRepository(with: ResponseCode.internetConnectionError)
        sut = ScanForPokemonViewModel(pokemonRepository: fakeRepository)
        sut.scanForPokemon()

        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .failed(errorMesssage: "Please check your internet connection or try again later."))
                cancellable?.cancel()
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testScanForPokemonViewModel_ScanForPokemonWithGlobalError() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_WithGlobalError")
        expectation.assertForOverFulfill = false
        let fakeRepository = FakeRepository(with: 500)
        sut = ScanForPokemonViewModel(pokemonRepository: fakeRepository)
        sut.scanForPokemon()

        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .failed(errorMesssage: "Oops! An error has occurred. Please try again later."))
                cancellable?.cancel()
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testScanForPokemonViewModel_CatchPokemonWithSucess() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_CatchPokemonWithSucess")
        expectation.assertForOverFulfill = false

        let pokemonForTest = Pokemon(id: 1, weight: 50, height: 100, baseExperience: 100, order: 1, name: "Pokemon for test", type: [PokemonType(name: "dark"), PokemonType(name: "fighting")])
        sut.catchPokemon(pokemonForTest)

        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .loading)
                cancellable?.cancel()
                expectation.fulfill()
            }

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testScanForPokemonViewModel_CatchPokemonWithError() {
        let expectation = self.expectation(description: "testScanForPokemonViewModel_CatchPokemonWithError")
        expectation.assertForOverFulfill = false

        let fakeRepository = FakeRepository(with: 500)
        sut = ScanForPokemonViewModel(pokemonRepository: fakeRepository)
        
        let pokemonForTest = Pokemon(id: 1, weight: 50, height: 100, baseExperience: 100, order: 1, name: "Pokemon for test", type: [PokemonType(name: "dark"), PokemonType(name: "fighting")])
        sut.catchPokemon(pokemonForTest)
        
        var cancellable: AnyCancellable?
        cancellable = sut.$viewState
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, .failed(errorMesssage: NSLocalizedString("global_error_text", comment: "")))
                cancellable?.cancel()
                expectation.fulfill()
            }

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    private func createCatchedPokemon(from pokemon: Pokemon) -> CatchedPokemon {
        let catchedPokemon = CatchedPokemon()
        catchedPokemon.id = Int16(pokemon.id)
        catchedPokemon.name = pokemon.name
        catchedPokemon.weight = Int16(pokemon.weight)
        catchedPokemon.height = Int16(pokemon.height)
        catchedPokemon.base_experience = Int16(pokemon.baseExperience)
        catchedPokemon.image_path = pokemon.imagePath
        catchedPokemon.type = NSSet(array: pokemon.type.map({ type -> CatchedPokemonType in
            let catchedPokemonType = CatchedPokemonType()
            catchedPokemonType.name = type.name
            return catchedPokemonType
        }))
        catchedPokemon.order = Int16(pokemon.order)
        if let date = Date().dateWithFormat() {
            catchedPokemon.catched_at = date
        }
        return catchedPokemon
    }
    
}
