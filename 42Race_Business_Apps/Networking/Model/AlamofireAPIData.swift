//
//  AlamofireAPIData.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//


import UIKit
import ObjectMapper

final class AlamofireAPIData : Mappable{
    
    var generalResponse: GeneralResponse = GeneralResponse()
    private(set) var data: Any = ""
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
    
}

final class GeneralResponse: Mappable {
    var responseStatus: Bool = false
    var responseCode: Int = 0
    var responseMessage: String = ""
    var responseTimestamp: String = ""
    
    var isSuccess: Bool {
        return responseStatus && responseCode == 200
    }
    
    var error: AlamofireError {
        return AlamofireError(code: responseCode, message: responseMessage)
    }
        
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        responseStatus <- map["response_status"]
        responseCode <- map["response_code"]
        responseMessage <- map["response_message"]
        responseTimestamp <- map["response_timestamp"]
    }
}

extension AlamofireAPIData {
    func transform<T: Decodable>(_ type: T.Type) -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.data, options: .prettyPrinted)
            let model = try decoder.decode(type, from: jsonData)
            return model
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }
}

