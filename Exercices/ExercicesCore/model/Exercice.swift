//
//  Exercice.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation

public struct Exercise:Equatable,Decodable {
    public var id: Int
    public var name: String?
    public var cover_image_url:String?
    public var video_url:String?
}
