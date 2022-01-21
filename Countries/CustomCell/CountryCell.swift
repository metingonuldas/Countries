//
//  CountryCell.swift
//  Countries
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var favouriteImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var favoriMi: ((Bool) -> ())?
    
    var dolumu: Bool = false
    func ayarla(name: String, dolumu: Bool) {
        self.dolumu = dolumu
        nameLabel.text = name
        favouriteImage.image = UIImage(systemName: dolumu ? "star.fill" : "star")
        
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        self.dolumu = !self.dolumu
        favoriMi?(dolumu)
        favouriteImage.image = UIImage(systemName: dolumu ? "star.fill" : "star")
    }
    
}

extension CountryCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var NibName: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
