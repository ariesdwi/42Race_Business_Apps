//
//  DetailViewModel.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//


import Foundation
import Alamofire


protocol DetailViewModelInput {
    func getData()
}

protocol DetailViewModelOutput : AnyObject{
    func showData(BusinessEntity:BusinessDetail)
    func showError(message: String, completion: (() -> ())?)
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInput { get }
    var outputs: DetailViewModelOutput? { get }
}

final class DetailViewModel {
    private let network = AlamofireNetworkService()
    weak var outputs: DetailViewModelOutput?
    var id = ""
    
    init(id : String) {
        network.interactor = self
        self.id = id
    }
}


extension DetailViewModel:DetailViewModelInput {    
    func getData(){
        network.request(network: .businessId(id: id))
    }
}

// MARK: DashboardViewModelType
extension DetailViewModel: DetailViewModelType {
    var inputs: DetailViewModelInput { self }
}

// MARK: NetworkServiceRequest
private extension DetailViewModel {
   
}

// MARK: AlamofireNetworkServiceInteractor
extension DetailViewModel:AlamofireNetworkServiceInteractor{
    func success(_ object: AlamofireAPIData, type: AlamofireAPINetwork) {
        switch type {
        case .businessId:
            
            outputs?.showData(BusinessEntity: BusinessDetail(name: object.name, rating: String(object.rating), imageUrl: object.imageUrl, location: object.location.address1, price: object.price, displayPhone: object.displayPhone, categories: object.categories[0].alias))
            
        default: break
        }
    }
    
    func failed(_ error: Error, type: AlamofireAPINetwork) {
        let message = (error as? AlamofireError)?.message ?? error.localizedDescription
        outputs?.showError(message: message, completion: nil)
    }
}

