//
//  ViewController.swift
//  Countries
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel = MainViewModel()
    var favouriteList = UserDefaults.standard.object(forKey: "SavedFav") as? [String] ?? [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryCell.NibName, forCellReuseIdentifier: CountryCell.identifier)
        viewModel.tableViewYenile = {
            self.tableView.reloadData()
        }
        viewModel.requestCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as! CountryCell
        let data = viewModel.countryList[indexPath.row]
        cell.ayarla(name: data.name, dolumu: ((UserDefaults.standard.object(forKey: "SavedFav") as? [String] ?? [String]()).filter({$0 == data.name}).count > 0))
        cell.favoriMi = { isFav in
            if isFav {
                self.favouriteList.append(data.name)
            } else {
                self.favouriteList = self.favouriteList.filter({ $0 != data.name })
            }
            
            UserDefaults.standard.set(self.favouriteList, forKey: "SavedFav")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.countryList[indexPath.row]
        let viewController = CountryDetailVC.instantiate(storyboard: .main, bundle: nil, identifier: nil)
        let viewModel = CountryDetailVM()
        viewModel.country = data
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
