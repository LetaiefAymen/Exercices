//
//  RemoteExercicesLoaderTests.swift
//  RemoteExercicesLoaderTests
//
//  Created by Aymen Letaief on 09.12.21.
//

import XCTest
@testable import ExercisesCore

class RemoteExercisesLoaderTests: XCTestCase {

    
    func test_sut_notNil() {
        let (sut,httpClientSpy) = makeSUT()
        
        XCTAssertNotNil(sut)
        XCTAssertNotNil(httpClientSpy)
    }
    
    func test_loader_load_callHTTPCLientLoadUrl() {
        let url = URL(string: "http://test-url.com")!
        
        let (sut,httpClientSpy) = makeSUT(url: url)
        
        XCTAssertEqual(httpClientSpy.loadedURLs.count,0)
        
        sut.loadExercices(completion: { _ in })

        XCTAssertEqual(httpClientSpy.loadedURLs.count,1)
    }
    
    func makeSUT(url:URL = URL(string: "http://a-url.com")!) -> (RemoteExercisesLoader,HTTPClientSpy) {
        
        let httpClientSpy = HTTPClientSpy()
        
        let loader = RemoteExercisesLoader(url: url, httpClient: httpClientSpy)
        return (loader,httpClientSpy)
    }
}


class HTTPClientSpy: HTTPClient {
    
    var loadedURLs: [URL] = []
    
    func loadURL(url: URL, completion: @escaping (ClientResult) -> ()) {
        loadedURLs.append(url)
    }
    
    
}
