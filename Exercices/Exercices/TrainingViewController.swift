//
//  TrainingViewController.swift
//  Exercises
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import UIKit
import ExercisesCore

protocol TraingingsDelegate:class {
    func showExercise(exercise: Exercise)
    func leave()
    func showUnfavoriteButton()
    func showFavoriteButton()
}

class TraingingsViewModel {
    
    var favoriteStoreHelper: FavoriteStoreHelper
    weak var delegate: TraingingsDelegate?
    var datasource: [Exercise] = []
    var exerciceIndex = 0
    var currentExerciceIsFavorite = false
    
    init(exercices: [Exercise],favoriteStoreHelper:FavoriteStoreHelper) {
        self.favoriteStoreHelper = favoriteStoreHelper
        self.datasource = exercices
    }
    
    func start() {
        self.showImage()
    }
    
    func showImage() {
        if datasource.count > 0 && exerciceIndex < datasource.count {
            let exercise = datasource[exerciceIndex]
            currentExerciceIsFavorite = favoriteStoreHelper.isFavorite(exercise: exercise)
            delegate?.showExercise(exercise: exercise)
            self.showFavorite(isFavorite: currentExerciceIsFavorite)
            exerciceIndex += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.showImage()
            }
        } else {
            delegate?.leave()
        }
    }
    
    func switchFavorite() {
        currentExerciceIsFavorite = !currentExerciceIsFavorite
        let exercise = datasource[exerciceIndex-1]
        self.favoriteStoreHelper.setFavorite(exercise: exercise, isFavorite: currentExerciceIsFavorite)
        self.showFavorite(isFavorite: currentExerciceIsFavorite)
    }
    
    func showFavorite(isFavorite: Bool) {
        if(!isFavorite) {
            self.delegate?.showFavoriteButton()
        } else {
            self.delegate?.showUnfavoriteButton()
        }
    }
    
    func isFavorite(exercise: Exercise) -> Bool {
        self.favoriteStoreHelper.isFavorite(exercise: exercise)
    }
    
}


class TrainingViewController: UIViewController {
    
    var trainingsViewModel: TraingingsViewModel?
    var imageLoader: ImageLoader?
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    
    
    @IBAction func cancelTrainingClicked(_ sender: Any) {
        self.leave()
    }
    
    @IBAction func favoriteExerciceClicked(_ sender: Any) {
        trainingsViewModel?.switchFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainingsViewModel?.start()
    }
}

extension TrainingViewController: TraingingsDelegate {
    
    func showExercise(exercise: Exercise) {
        if let urlString = exercise.cover_image_url, let imageUrl = URL(string: urlString) {
            imageLoader?.loadImage(url: imageUrl, completion: { result in
                
                switch result {
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        let image = UIImage(data: data)
                        self?.exerciseImageView?.image = image
                    }
                default:
                    break
                }
                
            })
        }
        
    }
    
    func leave() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showFavoriteButton() {
        favoriteButton.setTitle("Favorite Exercice", for: .normal)
    }
    func showUnfavoriteButton() {
        favoriteButton.setTitle("UnFavorite Exercice", for: .normal)
    }
}
