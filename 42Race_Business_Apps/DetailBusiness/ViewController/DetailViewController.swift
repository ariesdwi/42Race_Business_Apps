//
//  DetailViewController.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModelType!
    var wireframe: DetailWireframe!
    
    
    // OUTLET
    @IBOutlet weak var imageViewBusiness: UIImageView!
    @IBOutlet weak var nameBusinessLabel: UILabel!
    @IBOutlet weak var categoryBusinessLabel: UILabel!
    @IBOutlet weak var ratingBusinessLabel: UILabel!
    @IBOutlet weak var locationBusinessLabel: UILabel!
    @IBOutlet weak var openhoursBusinessLabel: UILabel!
    @IBOutlet weak var priceBusinessLabel: UILabel!
    @IBOutlet weak var contactBusinessLabel: UILabel!
    
    
    @IBOutlet weak var viewDetail: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDetail.layer.cornerRadius = 40
        viewModel.inputs.getData()
        navigationItem.largeTitleDisplayMode = .never
    }

    

}


extension DetailViewController: DetailViewModelOutput{
    func showData(BusinessEntity: BusinessDetail) {
        let url = URL(string: BusinessEntity.imageUrl)!
        let dataImage = try? Data(contentsOf: url )
        let image = UIImage(data: dataImage!)
        
        nameBusinessLabel.text = BusinessEntity.name
        categoryBusinessLabel.text = BusinessEntity.categories
        ratingBusinessLabel.text = BusinessEntity.rating
        locationBusinessLabel.text = BusinessEntity.location
        priceBusinessLabel.text = BusinessEntity.price
        contactBusinessLabel.text = BusinessEntity.displayPhone
        imageViewBusiness.image = image
        
        print(BusinessEntity.name)
    }
    
    func showError(message: String, completion: (() -> ())?) {
        
    }
    
}
