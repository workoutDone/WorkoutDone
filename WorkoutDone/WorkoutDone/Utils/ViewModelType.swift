//
//  ViewModelType.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/18.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
