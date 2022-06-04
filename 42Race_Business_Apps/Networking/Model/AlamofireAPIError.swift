//
//  AlamofireAPIError.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//


import Foundation

struct AlamofireError: Error {
    let code: Int
    let message: String
    
    var errorType: ErrorType {
        return ErrorType(byCode: code)
    }
}

// MARK: AlamofireError.ErrorType
extension AlamofireError {
    enum ErrorType: Int {
        case notAuthorized            = 401
        case internalError            = 500
        case acceptLanguageIsEmpty    = 800
        case authorizationIsEmpty     = 801
        case contentTypeIsEmpty       = 802
        case tokenUnverifiedOrExpired = 803
        case undefined
        
        init(byCode code: Int) {
            self = ErrorType(rawValue: code) ?? .undefined
        }
    }
}
