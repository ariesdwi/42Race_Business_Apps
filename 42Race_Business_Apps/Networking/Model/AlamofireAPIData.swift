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
    var name: String = ""
    var rating: Double = 0.0
    var imageUrl:String = ""
    var location : LocationDetail =  LocationDetail()
    var price : String = ""
    var displayPhone: String = ""
    var categories : [CategoryDetail]  = []
    
    
    private(set) var businesses: Any = ""
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        businesses <- map["businesses"]
        name <- map["name"]
        rating <- map["rating"]
        imageUrl <- map["image_url"]
        location <- map["location"]
        price <- map["price"]
        displayPhone <- map["display_phone"]
        categories <- map["categories"]
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
            let jsonData = try JSONSerialization.data(withJSONObject: self.businesses, options: .prettyPrinted)
            let model = try decoder.decode(type, from: jsonData)
            return model
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }
}


//// MARK: - Location
final class LocationDetail :Mappable{
    var address1: String = ""
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        address1 <- map["address1"]
    }
}


//// MARK: - Location
final class CategoryDetail :Mappable{
    var alias: String = ""
    
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        alias <- map["alias"]
    }
}
