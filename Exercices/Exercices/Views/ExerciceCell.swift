//
//  ExerciceCell.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import UIKit
import ExercisesCore

protocol ExerciseCellDelegate:class {
   func favoriteClicked(exercise: Exercise,isFavorite: Bool)
}

class ExerciseCell : UITableViewCell {
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    var exercice: Exercise?
    var isFavorite: Bool?
    weak var delegate: ExerciseCellDelegate?
    
    func setup(exercise: Exercise,isFavorite: Bool) {
        self.exercice = exercise
        self.isFavorite = isFavorite
        self.titleLabel.text = exercise.name
        if(isFavorite) {
            self.favoriteButton.setImage(UIImage(named:"starFilled"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named:"star"), for: .normal)
        }
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
        guard let exercice = exercice, let favorite = isFavorite else {
            return
        }
        delegate?.favoriteClicked(exercise: exercice, isFavorite: favorite)
    }
    
}
