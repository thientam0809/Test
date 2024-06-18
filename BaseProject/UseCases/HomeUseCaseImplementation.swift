//
//  HomeUseCaseImplementation.swift
//  BaseProject
//
//  Created by Nguyen Khanh Thien Tam on 10/06/2024.
//

import Foundation

class HomeUseCaseImplementation: HomeUseCase {
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func getWorkouts(completion: @escaping (Result<Workout?, Error>) -> Void) {
        repository.getWorkouts { result in
            completion(result)
        }
    }
}
