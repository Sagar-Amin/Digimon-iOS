//
//  APIError.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import Foundation

enum APIError: Error {
    case invalidURLError
    case parsingError
    case noDataError
    case responseCodeError(Int)
}
