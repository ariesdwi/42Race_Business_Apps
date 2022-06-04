//
//  Extention.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import Foundation

import UIKit

extension UIViewController {
    func redirectTo(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
}
