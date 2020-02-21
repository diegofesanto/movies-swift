//
//  APIClient.swift
//  Movies
//
//  Created by Diego Fernando on 21/02/20.
//

import Foundation
import RxSwift

protocol APIClient {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

final class APIClientImpl: APIClient {
    enum Error: Swift.Error {
        case api(API.ErrorResponse?, Data)
        case server(code: Int)
        case url(Swift.Error)
        case badResponse
        case unknown
    }
    
    private let session: URLSession
    private var requestRetrier: RequestRetrier?
    
    init(session: URLSession, requestRetrier: RequestRetrier?) {
        self.session = session
        self.requestRetrier = requestRetrier
    }
    
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        let request = buildRequest(from: endpoint)
        return perform(request)
            .map { data, statusCode in
                try self.decodeResponse(endpoint: endpoint, data: data, statusCode: statusCode)
        }
        .retryWhen { errors in
            self.retryWhen(errors: errors)
        }
    }
    
    private func decodeResponse<Response>(
        endpoint: Endpoint<Response>,
        data: Data,
        statusCode: HTTP.StatusCode
    ) throws -> Response {
        switch statusCode {
        case .success:
            return try endpoint.decode(data)
            
        case .clientError:
            throw Error.api(try? JSONDecoder().decode(API.ErrorResponse.self, from: data), data)
            
        case let .serverError(code):
            throw Error.server(code: code)
            
        default:
            throw Error.unknown
        }
    }
    
    private func retryWhen(errors: Observable<Swift.Error>) -> Observable<Void> {
        errors.enumerated().flatMap { attempt, error -> Observable<Void> in
            guard let requestRetrier = self.requestRetrier else {
                return .error(error)
            }
            
            let action = requestRetrier.shouldRetry(dueTo: error, currentAttempt: attempt)
            
            switch action {
            case .noRetry: return .error(error)
            case let .retryAfter(delay):
                return Observable<Int>.timer(.seconds(delay), scheduler: MainScheduler.instance)
                    .map { _ in () }
            }
        }
    }
    
    private func perform(_ request: URLRequest) -> Single<(Data, HTTP.StatusCode)> {
        Single.create { emitter in
            let task = self.session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    emitter(.error(Error.url(error)))
                    return
                }
                
                guard let response = response, let httpResponse = response as? HTTPURLResponse else {
                    emitter(.error(Error.badResponse))
                    return
                }
                
                let statusCode = HTTP.StatusCode(httpResponse.statusCode)
                emitter(.success((data ?? Data(), statusCode)))
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func buildRequest<Response>(from endpoint: Endpoint<Response>) -> URLRequest {
        let url = URL(string: "")!.appendingPathComponent(endpoint.path)
        
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponent.queryItems = (endpoint.query ?? [:]).map(URLQueryItem.init)
        
        var request = URLRequest(url: urlComponent.url!)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
}
