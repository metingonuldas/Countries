//
//  SavedViewController.swift
//  Countries
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import UIKit

class SavedViewController: UIViewController {
    
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
        favouriteList = UserDefaults.standard.object(forKey: "SavedFav") as? [String] ?? [String]()
        tableView.reloadData()
    }
    
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as! CountryCell
        cell.ayarla(name: favouriteList[indexPath.row], dolumu: true)
        cell.favoriMi = { [self] isFav in
            if isFav {
                favouriteList.append(favouriteList[indexPath.row])
            } else {
                favouriteList = favouriteList.filter({ $0 != favouriteList[indexPath.row] })
            }
            
            UserDefaults.standard.set(favouriteList, forKey: "SavedFav")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
