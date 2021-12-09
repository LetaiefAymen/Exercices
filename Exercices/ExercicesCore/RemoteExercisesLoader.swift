//
//  RemoteExercicesLoader.swift
//  ExercicesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation


protocol HTTPClient {
    typealias ClientResult = Result<(response:HTTPURLResponse,data:Data),Error>
    
    func loadURL(url:URL, completion: @escaping (ClientResult) -> ())
}

struct Exercise:Equatable {
    
}

enum RemoteExerciceLoaderError:Error {
    case httpClientError
    case parsingError
    case unknown
}

protocol ExerciseLoader {
    typealias LoaderResult = Result<[Exercise],RemoteExerciceLoaderError>
    
    func loadExercices(completion:@escaping (LoaderResult) -> ())
}

class RemoteExercisesLoader:ExerciseLoader {
    
    let httpClient: HTTPClient
    let url: URL
    
    init(url:URL,httpClient:HTTPClient) {
        self.httpClient = httpClient
        self.url = url
    }
    
    func loadExercices(completion: @escaping (LoaderResult) -> ()) {
        httpClient.loadURL(url: url, completion: { clientResult in
            switch clientResult {
            case .failure(_): completion(.failure(.httpClientError))
            default: break
            }
        })
    }
    
}
