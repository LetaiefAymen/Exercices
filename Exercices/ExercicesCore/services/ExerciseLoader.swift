//
//  ExerciseLoader.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation


public enum RemoteExerciceLoaderError:Error {
    case httpClientError
    case parsingError
    case unknown
}

public protocol ExerciseLoader {
    typealias LoaderResult = Result<[Exercise],RemoteExerciceLoaderError>
    
    func loadExercices(completion:@escaping (LoaderResult) -> ())
}
