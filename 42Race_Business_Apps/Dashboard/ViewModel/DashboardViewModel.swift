//
//  DashboardViewModel.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation
import Alamofire


protocol DashboardViewModelInput {
    func getProfile()
    func logout()
}

protocol DashboardViewModelOutput : AnyObject{
    func showAccesToken(token:String)
    func showError(message: String, completion: (() -> ())?)
}

protocol DashboardViewModelType {
    var inputs: DashboardViewModelInput { get }
    var outputs: DashboardViewModelOutput? { get }
}

final class DashboardViewModel {
    private let network = AlamofireNetworkService()
    weak var outputs: DashboardViewModelOutput?

    init() {
        network.interactor = self
    }
}


extension DashboardViewModel:DashboardViewModelInput {
    func logout() {
       
    }
    
    func getProfile() {
        
    }
    
   
   
}

// MARK: DashboardViewModelType
extension DashboardViewModel: DashboardViewModelType {
    var inputs: DashboardViewModelInput { self }
}

// MARK: NetworkServiceRequest
private extension DashboardViewModel {
    func requestCards(){
        
    }
}

// MARK: AlamofireNetworkServiceInteractor
extension DashboardViewModel:AlamofireNetworkServiceInteractor{
    func success(_ object: AlamofireAPIData, type: AlamofireAPINetwork) {
        
    }
    
    func failed(_ error: Error, type: AlamofireAPINetwork) {
        let message = (error as? AlamofireError)?.message ?? error.localizedDescription
        outputs?.showError(message: message, completion: nil)
    }
}

