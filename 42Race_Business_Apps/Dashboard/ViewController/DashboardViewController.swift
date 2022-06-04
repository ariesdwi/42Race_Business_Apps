//
//  DashboardViewController.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import UIKit

class DashboardViewController: UIViewController {

    var viewModel: DashboardViewModelType!
    var wireframe: DashboardWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


   

}

extension DashboardViewController: DashboardViewModelOutput{
    func showAccesToken(token: String) {
       
    }
    
    func showError(message: String, completion: (() -> ())?) {
        
    }
    
    
}
