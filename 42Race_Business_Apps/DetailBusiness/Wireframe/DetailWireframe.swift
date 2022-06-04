//
//  DetailWireframe.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation
import UIKit

final class DetailWireframe {
    private weak var viewController: DetailViewController!
    private var navCon: UINavigationController? { viewController.navigationController }

    func create(id:String) -> DetailViewController {
        let vc = DetailViewController()
        let vm = DetailViewModel(id:id)
        vm.outputs = vc
        vc.viewModel = vm
        vc.wireframe = self
        viewController = vc
        return vc
    }
    
    
}
