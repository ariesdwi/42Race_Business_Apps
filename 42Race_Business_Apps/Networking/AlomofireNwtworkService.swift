//
//  Alamofireservice.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//


import UIKit
import Alamofire

protocol AlamofireNetworkServiceInteractor: AnyObject {
    func success(_ object: AlamofireAPIData, type: AlamofireAPINetwork)
    func failed(_ error: Error, type: AlamofireAPINetwork)
}

enum AlamofireAPINetwork {
    // Dashboard
    case businessSearch(searchReq)
    
    // Detail
    case businessId(id:String)
    
    
    
    
    // PROFILE
    
    
    var method: HTTPMethod {
        switch self {

        case .businessId , .businessSearch:
            return .get
        default:
            return .post
        }
        
    }
    
    private var baseURL: String {
        switch self {
        case .businessId , .businessSearch:
            return "https://api.yelp.com/v3/businesses"
        }
    }
    
    private var path: String {
        switch self {
        case .businessId(let id) :
            return "/\(id)"
        case  .businessSearch:
            return "/search"
        default:
            return "nil"
        }
    }
    
    
    var fullPath: String { return baseURL + path }
    
    var parameters: Parameters? {
        switch self {
        case .businessSearch(let model):
            return model.param
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default  : return JSONEncoding.prettyPrinted
        }
    }
    
    
    
    
    var header: HTTPHeaders {
        var headers = [String:String]()
        switch self {
        case .businessSearch, .businessId :
            let auth = "Bearer 0ihDjhKJMCS1w_kUJ5SI1G4eLmTCfRVe3WOghl10SAZWY50OGq_jgFptJwOk6GJeE_pFm7rGGoLY2HWQhjIpiWBAehbDZrdHahwwuBW3SCu5Z8c9EZpbk35NVNCaYnYx"
            return [
                "Authorization" : auth
            ]
        default: break
        }
        return HTTPHeaders(headers)
    }
 
}


final class AlamofireNetworkService {
    weak var interactor:AlamofireNetworkServiceInteractor?
    
    func request(network: AlamofireAPINetwork) {
        alamofireCall(network: network)
    }
    
    func alamofireCall(network: AlamofireAPINetwork) {
        AF.request(network.fullPath, method: network.method, parameters: network.parameters,
                   encoding: network.parameterEncoding, headers: network.header)
            .validate()
            .responseJSON { [weak self] (response) in
                guard let self = self else { return }
                self.debug(response: response)
                switch response.result {
                case .success(let data):
                    guard let object = AlamofireAPIData(JSON: data as! [String:Any]) else { return }
                    self.populateResponse(object: object, network: network)
                case .failure(let error):
                    let returnedError = self.getError(error: error, response: response)
                    self.interactor?.failed(returnedError, type: network)
                }
        }
    }
    
    func populateResponse(object: AlamofireAPIData, network: AlamofireAPINetwork) {
        let generalResponse = object.generalResponse
        switch network {
        case .businessId , .businessSearch:
                self.interactor?.success(object, type: network)
        default:
            if generalResponse.isSuccess {
                self.interactor?.success(object, type: network)
            } else {
                let error = generalResponse.error
                self.interactor?.failed(error, type: network)
            }
        }
            
    }
    
    func debug(response: AFDataResponse<Any>) {
        if let request = response.request {
            print("\(request.httpMethod ?? "") \(request.description)")
        }
        if let response = response.response {
            print("statusCode: \(response.statusCode)")
        }
        print("response \(response.result)")
    }
    
    func getError(error: AFError, response: AFDataResponse<Any>) -> Error {
        guard let data = response.data,
              let bodyJSON = try? JSONSerialization.jsonObject(
                with: data, options: .allowFragments) as? [String: Any],
              let code = bodyJSON["code"] as? Int,
              let message = bodyJSON["message"] as? String else {
            return error
        }
        return AlamofireError(code: code, message: message)
    }
}
