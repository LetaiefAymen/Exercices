//
//  RemoteExercicesLoaderTests.swift
//  RemoteExercicesLoaderTests
//
//  Created by Aymen Letaief on 09.12.21.
//

import XCTest
@testable import ExercicesCore

class RemoteExercicesLoaderTests: XCTestCase {

    
    func test_sut_notNil() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut)
    }
    
    func makeSUT() -> RemoteExercicesLoader {
        let loader = RemoteExercicesLoader()
        return loader
    }
}
