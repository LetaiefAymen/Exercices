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
    
    func test_failure_whenHTTPClientFails() {
        let (sut,httpClientSpy) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(RemoteExerciceLoaderError.httpClientError), when: {
            httpClientSpy.triggerError(error: anyNSError())
        })
    }
    
    
    func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    func expect(_ loader: RemoteExercisesLoader,toCompleteWith expectedResult: ExerciseLoader.LoaderResult,when action: () -> (), file: StaticString = #filePath, line: UInt = #line) {
        var result : ExerciseLoader.LoaderResult?

        let exp = expectation(description: "expectation of the load exercices")
        loader.loadExercices(completion: { exercises in
            
            result = exercises
            exp.fulfill()
        })
        action()
        wait(for: [exp], timeout: 1.0)
        switch (result,expectedResult) {
        case let (.success(exercises),.success(expectedExercices)):
            XCTAssertEqual(exercises, expectedExercices,file: file,line: line)
        case let (.failure(error),.failure(expectedError)):
            XCTAssertEqual(error, expectedError,file: file,line: line)
        default:
            XCTFail("not the expected result, expected \(expectedResult) , got \(result!)",file: file,line: line)
            break
        }
    }
    
    func makeSUT(url:URL = URL(string: "http://a-url.com")!) -> (RemoteExercisesLoader,HTTPClientSpy) {
        
        let httpClientSpy = HTTPClientSpy()
        
        let loader = RemoteExercisesLoader(url: url, httpClient: httpClientSpy)
        return (loader,httpClientSpy)
    }
}


class HTTPClientSpy: HTTPClient {
    
    var loadedURLs: [URL] = []
    var completions: [(ClientResult) -> ()] = []

    func loadURL(url: URL, completion: @escaping (ClientResult) -> ()) {
        loadedURLs.append(url)
        completions.append(completion)
    }
    
    func triggerError(index: Int = 0,error:Error) {
        completions[index](.failure(error))
    }
    
    
}
