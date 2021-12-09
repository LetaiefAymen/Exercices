//
//  FavoriteStoreHelper.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation

public class FavoriteStoreHelper {
    
    public init(){
        
    }
    
    public func isFavorite(exercise:Exercise) -> Bool {
        return  UserDefaults.standard.bool(forKey: "exercice_\(exercise.id)")
    }
    
    public func setFavorite(exercise:Exercise,isFavorite: Bool) {
        UserDefaults.standard.set(isFavorite, forKey: "exercice_\(exercise.id)")
    }
}
