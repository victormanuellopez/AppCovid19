//
//  CovidData.swift
//  AppCovid19
//
//  Created by Mac8 on 15/12/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct CovidData: Codable {
    
    
    let country: String
    let countryInfo: CountryInfo
    let cases: Int
    let deaths: Int
    let recovered: Int
   
}

struct CountryInfo: Codable {
   let flag: String
}




