//
//  Http.swift
//  Movies
//
//  Created by Diego Fernando on 21/02/20.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    typealias Query = [String: String]
    typealias Headers = [String: String]
    
    enum StatusCode: Hashable {
        /// 1xx Informational
        case information(Int)
        
        /// 2xx success
        case success(Int)
        
        /// 3xx Redirection
        case redirection(Int)
        
        /// 4xx Client Error
        case clientError(Int)
        
        /// 5xx Server Error
        case serverError(Int)
        
        /// Unkown class error
        case unknownError(Int)
        
        var statusCode: Int {
            switch self {
            case let .information(statusCode),
                 let .success(statusCode),
                 let .redirection(statusCode),
                 let .clientError(statusCode),
                 let .serverError(statusCode),
                 let .unknownError(statusCode):
                return statusCode
            }
        }
        
        init(_ statusCode: Int) {
            switch statusCode {
            case 100 ... 199: self = .information(statusCode)
            case 200 ... 299: self = .success(statusCode)
            case 300 ... 399: self = .redirection(statusCode)
            case 400 ... 499: self = .clientError(statusCode)
            case 500 ... 599: self = .serverError(statusCode)
            default: self = .unknownError(statusCode)
            }
        }
    }
}
