//
//  API.swift
//  Movies
//
//  Created by Diego Fernando on 21/02/20.
//

import Foundation

enum API {
    // Mapear urls
    enum Movies {
        static let path = ""
    }
}

extension API {
    // Mapear objeto resposta erro da api
    struct ErrorResponse: Swift.Error, Decodable {
        let message: String
    }
}
