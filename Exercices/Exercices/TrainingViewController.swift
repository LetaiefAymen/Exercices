//
//  TrainingViewController.swift
//  Exercises
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import UIKit
import ExercisesCore

protocol TraingingsDelegate {
    func showExercise(exercise: Exercise)
    func leave()
}

class TraingingsViewModel {
    
    var delegate: TraingingsDelegate?
    var datasource: [Exercise] = []
    var exerciceIndex = 0
    
    init(exercices: [Exercise]) {
        self.datasource = exercices
    }
    
    func start() {
        self.showImage()
    }
    
    func showImage() {
        if datasource.count > 0 && exerciceIndex < datasource.count {
            delegate?.showExercise(exercise: datasource[exerciceIndex])
            exerciceIndex += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.showImage()
            }
        } else {
            delegate?.leave()
        }
    }
    
}


class TrainingViewController: UIViewController {
    
    
    var trainingsViewModel: TraingingsViewModel?
    var imageLoader: ImageLoader?
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    
    
    @IBAction func cancelTrainingClicked(_ sender: Any) {
        self.leave()
    }
    
    @IBAction func favoriteExerciceClicked(_ sender: Any) {
        
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
}
