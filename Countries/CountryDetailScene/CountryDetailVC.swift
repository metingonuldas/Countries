//
//  CountryDetailVC.swift
//  Countries
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import UIKit
import Kingfisher

class CountryDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    var isFavourite: Bool = true
    
    var favouriteList = UserDefaults.standard.object(forKey: "SavedFav") as? [String] ?? [String]()
    var viewModel: CountryDetailVM!
    var reloadSavedFav = ViewController()
    
    @objc func addTapped(sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.country.name
        viewModel.datalariDoldur = {
            
            self.codeLabel.text = "Country Code:\(self.viewModel.detail.code)"

//            let url = URL(string: self.viewModel.detail.flagImageURI.replacingOccurrences(of: "http:", with: "https:"))
//            self.imageView.kf.setImage(with: url)
//            https://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20Ethiopia.svg -->
//            https://upload.wikimedia.org/wikipedia/commons/0/00/Flag_of_Namibia.svg

        }
        viewModel.internettenVeriCek()
        
        if favouriteList.contains(self.viewModel.country.name) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(starTapped))
        isFavourite = true
        }else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starTapped))
            isFavourite = false
        }
        
    }
    
    @objc func starTapped() {
        
        if isFavourite == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starTapped))
            favouriteList.removeAll { $0 == self.viewModel.country.name }
        }else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(starTapped))
            favouriteList.append(self.viewModel.country.name)
         }
        
    }
    
    
    @IBAction func informationClicked(_ sender: Any) {
        let myUrl = "https://www.wikidata.org/wiki/\(self.viewModel.detail.wikiDataID)"
            if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }

            // or outside scope use this
            guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
               return
            }
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
