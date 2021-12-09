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

struct Exercise:Equatable,Decodable {
    var id: Int
    var name: String?
    var cover_image_url:String?
    var video_url:String?
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
            case .failure(_):
                completion(.failure(.httpClientError))
            case .success(let result):
                completion(ExercicesResultMapper.map(result.data, from: result.response))
                  break
            }
        })
    }
    
}


class ExercicesResultMapper {
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> ExerciseLoader.LoaderResult {
        guard response.statusCode == 200, let exercices = try? JSONDecoder().decode([Exercise].self, from: data) else {
            return .failure(RemoteExerciceLoaderError.parsingError)
        }

        return .success(exercices)
    }
}

