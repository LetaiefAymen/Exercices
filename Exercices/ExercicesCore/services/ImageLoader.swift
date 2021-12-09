//
//  ImageLoader.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation

public protocol ImageLoader {
    
    typealias LoaderResult = Result<Data,ImageLoaderError>
    func loadImage(url:URL,completion:  @escaping  (LoaderResult) -> ())
}

public enum ImageLoaderError: Error {
    case invalidData
    case networkIssue
}

open class RemoteImageLoader: ImageLoader {
    
    
    var httpClient: HTTPClient
    
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    public func loadImage(url:URL,completion:  @escaping (LoaderResult) -> ()) {
       
        httpClient.loadURL(url: url, completion: { result in
            switch result {
            case .success(let result):
                if(result.response.statusCode == 200 && !result.data.isEmpty) {
                    completion(.success(result.data))
                } else {
                    completion(.failure(ImageLoaderError.networkIssue))
                }
                
            case .failure(_):
                completion(.failure(ImageLoaderError.networkIssue))
            }
        })
    }
}

