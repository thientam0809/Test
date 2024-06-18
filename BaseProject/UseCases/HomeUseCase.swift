//
//  HomeUseCase.swift
//  BaseProject
//
//  Created by Nguyen Khanh Thien Tam on 10/06/2024.
//

import Foundation

protocol HomeUseCase {
    func getWorkouts(completion: @escaping (Result<Workout?, Error>) -> Void)
}
