//
//  ExerciceCell.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation
import UIKit
import ExercisesCore

class ExerciseCell : UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    func setup(exercise: Exercise) {
        
        self.titleLabel.text = exercise.name
        
        
    }
}
