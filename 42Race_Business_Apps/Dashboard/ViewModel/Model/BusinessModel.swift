//
//  BusinessModel.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation


// MARK: - Business
struct BusinessModel: Decodable {
    let name: String
    let rating: Double
    let imageUrl:String
    let location : Location
    let id : String
}

// MARK: - Location
struct Location :Decodable{
    let city: String
}



//// MARK: - Business
struct BusinessDetail {
    let name: String
    let rating: String
    let imageUrl:String
    let location : String
    let price : String
    let displayPhone: String
    let categories : String
}


