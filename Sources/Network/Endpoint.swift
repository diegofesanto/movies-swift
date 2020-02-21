//
//  Endpoint.swift
//  Movies
//
//  Created by Diego Fernando on 21/02/20.
//

import Foundation

struct Endpoint<Response> {
    let method: HTTP.Method
    let path: String
    let query: HTTP.Query?
    let body: Data?
    let headers: HTTP.Headers?
    let decode: (Data) throws -> Response
}

extension Endpoint where Response: Decodable {
    init(method: HTTP.Method, path: String, query: HTTP.Query?, body: Data?, headers: HTTP.Headers?) {
        self.init(method: method, path: path, query: query, body: body, headers: headers) { data in
            try JSONDecoder().decode(Response.self, from: data)
        }
    }
}

extension Endpoint where Response == Void {
    init(method: HTTP.Method, path: String, query: HTTP.Query?, body: Data?, headers: HTTP.Headers?) {
        self.init(method: method, path: path, query: query, body: body, headers: headers) { _ in
            ()
        }
    }
}

extension Endpoint: Equatable {
    static func == (lhs: Endpoint<Response>, rhs: Endpoint<Response>) -> Bool {
        lhs.method == rhs.method
            && lhs.path == rhs.path
            && lhs.query == rhs.query
            && lhs.body == rhs.body
            && lhs.headers == rhs.headers
    }
}
