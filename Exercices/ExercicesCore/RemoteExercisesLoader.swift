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

struct Exercise {
    
}

protocol ExerciseLoader {
    typealias LoaderResult = Result<[Exercise],Error>
    
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
        httpClient.loadURL(url: url, completion: { _ in })
    }
    
}
