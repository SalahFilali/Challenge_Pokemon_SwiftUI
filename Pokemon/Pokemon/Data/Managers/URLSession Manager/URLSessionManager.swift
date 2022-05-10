//
//  URLSessionManager.swift
//  Pokemon
//
//  Created by Salah Filali on 10/5/2022.
//

import Foundation
import Combine


/// This protocol is defined to cancel the latest launched URLSessionDataTask
protocol CancellableTask {
    
    /// Call this method to cancel the latest launched URLSessionDataTask
    func cancelLastTask ()
    
}


final class URLSessionManager: CancellableTask {
    
    // MARK: - Properties
    let session = URLSession.shared
    
    private var latestTask: URLSessionDataTask?
    
    
    // MARK: - Methods
    
    /// Creates a task that retrieves the contents of the specified URL, then returns an  AnyPublisher with the result.
    /// - Parameter url: The URL to be retrieved.
    /// - Returns: AnyPublisher with Data or Error
    func dataTask(with url: URL) -> AnyPublisher<Data, Error> {
        
        Future<Data, Error>.init {[weak self] promise in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                }
                if data == nil {
                    promise(.failure(NSError(domain: "No data", code: 0)))
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case ResponseCode.httpOK:
                        promise(.success(data!))
                    default:
                        promise(.failure(NSError(domain: "", code: httpResponse.statusCode)))
                    }
                } else {
                    promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                }
                
                
            }
            self?.latestTask = task
            task.resume()
        }.eraseToAnyPublisher()
    }
    
    
    /// Cancels the latest launched URLSessionDataTask
    func cancelLastTask() {
        self.latestTask?.cancel()
    }
}
