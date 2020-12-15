//
//  CovidManager.swift
//  AppCovid19
//
//  Created by Mac8 on 15/12/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

protocol CovidManagerDelegate {
    func actualizarCovid(covid: CovidModelo)
    
    func huboError(cualError: Error)
    
}



struct CovidManager {
    
    let covidURL = "https://corona.lmao.ninja/v3/covid-19/countries"
    
    func fetchCovid(nombrePais: String){
        let urlString = "\(covidURL)/\(nombrePais)"
        print(urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in if error != nil {
                
                self.delegado?.Hubo
                
                return
                
                }
                
            }
        }
        
    }
    
    
    
    func parseJSON(covidData: Data) -> CovidModelo{
        let decoder = JSONDecoder()
        
        do{
            let dataDecodificada = try decoder.decode(covidData.self, from: covidData)
            
            
            
            
        }catch{
            
        }
        
        
        
    }
    
    
}
