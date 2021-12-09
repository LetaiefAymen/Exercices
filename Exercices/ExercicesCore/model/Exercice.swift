//
//  Exercice.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation

struct Exercise:Equatable,Decodable {
    var id: Int
    var name: String?
    var cover_image_url:String?
    var video_url:String?
}
