//
//  CovidManager.swift
//  AppCovid19
//
//  Created by Mac8 on 15/12/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct CovidManager {
    
    let covidURL = "https://corona.lmao.ninja/v3/covid-19/countries"
    
    func fetchCovid(nombrePais: String){
        let urlString = "\(covidURL)/\(nombrePais)"
        print(urlString)
    }
    
}
