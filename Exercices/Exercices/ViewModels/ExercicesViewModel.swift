//
//  ExercicesViewModel.swift
//  Exercises
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import ExercisesCore

protocol ExercisesListDelegate:class {
    func showExercises(exercises: [Exercise])
}

class ExercisesViewModel {
    
    weak var delegate: ExercisesListDelegate?
    
    var remoteLoader: RemoteExercisesLoader
    var datasource: [Exercise] = []
    var favoriteStoreHelper: FavoriteStoreHelper
    
    init(remoteLoader: RemoteExercisesLoader,favoriteStoreHelper: FavoriteStoreHelper) {
        self.remoteLoader = remoteLoader
        self.favoriteStoreHelper = favoriteStoreHelper
    }
    
    func loadAllExercices() {
        remoteLoader.loadExercices(completion: {result in
            DispatchQueue.main.async { [weak self] in

            switch result {
            case .success(let exercises) :
                guard let self = self else { return }
                self.datasource = exercises
                self.delegate?.showExercises(exercises: self.datasource)
            case .failure(_):
                break
            }
            }
        })
    }
    
    func switchFavorite(exercise: Exercise, curentIsFavorite: Bool) {
        self.favoriteStoreHelper.setFavorite(exercise: exercise, isFavorite: !curentIsFavorite)
        self.delegate?.showExercises(exercises: datasource)
    }
    
    func isFavorite(exercise: Exercise) -> Bool {
        self.favoriteStoreHelper.isFavorite(exercise: exercise)
    }
    
}
