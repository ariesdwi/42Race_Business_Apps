//
//  RequestRequirments.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation


struct searchReq {
    let term: String
    let latitude: Double
    let longitude: Double
  
    var param: [String: Any] {
        return [
            "term": term,
            "latitude": latitude,
            "longitude": longitude,
        ]
    }
}
