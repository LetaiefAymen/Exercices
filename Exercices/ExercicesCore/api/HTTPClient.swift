//
//  HTTPClient.swift
//  ExercisesCore
//
//  Created by Aymen Letaief on 09.12.21.
//

import Foundation


public protocol HTTPClient {
    typealias ClientResult = Result<(response:HTTPURLResponse,data:Data),Error>
    
    func loadURL(url:URL, completion: @escaping (ClientResult) -> ())
}
