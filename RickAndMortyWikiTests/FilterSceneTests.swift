//
//  FilterSceneTests.swift
//  RickAndMortyWikiTests
//
//  Created by Mike Panchenko on 19.06.2025.
//

import XCTest
@testable import RickAndMortyWiki

final class FilterSceneTests: XCTestCase {
    let store = Store(initialState: FilterState(), rootReducer: FilterReducer(), middlewares: [])
    func testAddFilterCharactersData() {
       
        
        let name = "Rick"
        let gender = "Male"
        let species = "Human"
        let status = "Alive"
        store.dispatch(AddFilterCharactersDataAction(name: name,
                                                     gender: gender,
                                                     species: species,
                                                     status: status))
        DispatchQueue.main.async {
            XCTAssertEqual(self.store.state.name, name)
            XCTAssertEqual(self.store.state.gender, .male)
            XCTAssertEqual(self.store.state.species, species)
            XCTAssertEqual(self.store.state.status, .alive)
        }
    }
}
