//
//  DashboardViewModel.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation
import Alamofire
import MapKit


protocol DashboardViewModelInput {
    func getData(terms:String,lat:Double,lng:Double)
    func chooseDetail(id:String)
}

protocol DashboardViewModelOutput : AnyObject{
    func showData(BusinessEntity:[BusinessModel])
    func showError(message: String, completion: (() -> ())?)
}

protocol DashboardViewModelType {
    var inputs: DashboardViewModelInput { get }
    var outputs: DashboardViewModelOutput? { get }
}

final class DashboardViewModel {
    private let network = AlamofireNetworkService()
    weak var outputs: DashboardViewModelOutput?
    var currentLocation: CLLocation!
    init() {
        network.interactor = self
       
    }
}


extension DashboardViewModel:DashboardViewModelInput {
    func getData(terms: String, lat: Double, lng: Double) {
        network.request(network: .businessSearch(searchReq(term: terms, latitude: lat, longitude: lng)))
    }
    
    func chooseDetail(id:String) {
        network.request(network: .businessId(id: id))
    }
   
}

// MARK: DashboardViewModelType
extension DashboardViewModel: DashboardViewModelType {
    var inputs: DashboardViewModelInput { self }
}

// MARK: NetworkServiceRequest
private extension DashboardViewModel {
    func requestlist(){
        network.request(network: .businessSearch(searchReq(term: "Starbucks", latitude: 37.786882, longitude: -122.399972)))
    }
}

// MARK: AlamofireNetworkServiceInteractor
extension DashboardViewModel:AlamofireNetworkServiceInteractor{
    func success(_ object: AlamofireAPIData, type: AlamofireAPINetwork) {
        switch type {
        case .businessSearch:
            let model = object.transform([BusinessModel].self)
            outputs?.showData(BusinessEntity: model)
            print(model[0].name)
        default: break
        }
    }
    
    func failed(_ error: Error, type: AlamofireAPINetwork) {
        let message = (error as? AlamofireError)?.message ?? error.localizedDescription
        outputs?.showError(message: message, completion: nil)
    }
}

