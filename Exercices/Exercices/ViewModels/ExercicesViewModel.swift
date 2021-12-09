//
//  ExercicesViewModel.swift
//  Exercises
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import ExercisesCore

protocol ExercisesListDelegate {
    func showExercises(exercises: [Exercise])
}

class ExercisesViewModel {
    
    var delegate: ExercisesListDelegate?
    
    var remoteLoader: RemoteExercisesLoader
    var datasource: [Exercise] = []
    
    init(remoteLoader: RemoteExercisesLoader) {
        self.remoteLoader = remoteLoader
    }
    
    func loadAllExercices() {
        remoteLoader.loadExercices(completion: {result in
            DispatchQueue.main.async { [weak self] in

            switch result {
            case .success(let exercises) :
                self?.delegate?.showExercises(exercises: exercises)
            case .failure(_):
                break
            }
            }
        })
    }
    
}
