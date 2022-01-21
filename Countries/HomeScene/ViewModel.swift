//
//  MainViewModel.swift
//  AlamofireTest
//
//  Created by Metin Kaan Gönüldaş on 20.01.2022.
//

import UIKit
import Alamofire


class MainViewModel {
    
    var tableViewYenile: (() -> ())?
    
    var countryList: [Country] = []
    
    func requestCountries () {
        let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10"
        let apiKey = "992e823213mshe883b03846335a3p123889jsn6ad910883b03"
        
        let header: HTTPHeaders = ["X-RapidAPI-Key": apiKey]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Countries.self) { [weak self] (response) in
            guard let self = self else { return }
            if let response = response.value {
                self.countryList = response.data
                self.tableViewYenile?()
            }
        }
    
    }
    
}
