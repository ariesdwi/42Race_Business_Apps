//
//  DashboardWireframe.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation
import UIKit

final class DashboardWireframe {
    private weak var viewController: DashboardViewController!
    private var navCon: UINavigationController? { viewController.navigationController }

    func create() -> DashboardViewController {
        let vc = DashboardViewController()
        let vm = DashboardViewModel()
        vm.outputs = vc
        vc.viewModel = vm
        vc.wireframe = self
        viewController = vc
        return vc
    }
}
extension DashboardWireframe{
    func gotodetail(id:String) {
        let vc = DetailWireframe().create(id: id)
        navCon?.pushViewController(vc, animated: true)
    }
}
