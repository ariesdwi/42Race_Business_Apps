
//
//  DashboardViewController.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import UIKit
import MapKit

class DashboardViewController: UIViewController, UISearchResultsUpdating {
    
    var viewModel: DashboardViewModelType!
    var wireframe: DashboardWireframe!
    
    let manager = CLLocationManager()
    var currentLocation: CLLocation!
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    // Data
    var data = [BusinessModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager.requestWhenInUseAuthorization()
       

        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = manager.location
        }
    }


    func setupView(){
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "42Race"
        self.tableView.register(UINib.init(nibName: "ListBusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "ListBusinessTableViewCell")
    }
   
    
  
    
  

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        viewModel.inputs.getData(terms: text, lat: currentLocation.coordinate.latitude, lng: currentLocation.coordinate.longitude)
    }
}


extension DashboardViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListBusinessTableViewCell") as? ListBusinessTableViewCell else { return UITableViewCell() }
        let url = URL(string: data[indexPath.row].imageUrl)!
        let dataImage = try? Data(contentsOf: url )
        let image = UIImage(data: dataImage!)
        
        cell.titleBusinessLabel.text = data[indexPath.row].name
        cell.ratingLabel.text = String(data[indexPath.row].rating)
        cell.locationLabel.text = data[indexPath.row].location.city
        cell.BusinessimageView?.image = image
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wireframe.gotodetail(id: data[indexPath.row].id)
    }
}

extension DashboardViewController: DashboardViewModelOutput{
    func showData(BusinessEntity: [BusinessModel]) {
        self.data = BusinessEntity
        tableView.reloadData()
    }
    
        
    
    func showError(message: String, completion: (() -> ())?) {
        
    }
    
    
}
