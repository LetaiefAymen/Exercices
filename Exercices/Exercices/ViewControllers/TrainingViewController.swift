//
//  TrainingViewController.swift
//  Exercises
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import UIKit
import ExercisesCore


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
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        trainingsViewModel?.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override public var shouldAutorotate: Bool {
       return false
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
