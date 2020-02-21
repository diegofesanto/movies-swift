//
//  RequestRetrier.swift
//  Movies
//
//  Created by Diego Fernando on 21/02/20.
//

import Foundation

enum RetryAction: Equatable {
    case noRetry
    case retryAfter(Delay)
    
    typealias Delay = Int
}

protocol RequestRetrier {
    func shouldRetry(dueTo error: Error, currentAttempt: Int) -> RetryAction
}

final class RequestRetrierImpl: RequestRetrier {
    private let maxAttempts = 2
    
    func shouldRetry(dueTo error: Error, currentAttempt: Int) -> RetryAction {
        guard let error = error as? APIClientImpl.Error, maxAttempts >= currentAttempt + 1 else {
            return .noRetry
        }
        
        switch error {
        case .api:
            return .noRetry
        default:
            return .retryAfter(delay(for: currentAttempt + 1))
        }
    }
    
    private func delay(for nextAttempt: Int) -> RetryAction.Delay {
        let unit = 4
        return nextAttempt * unit
    }
}
