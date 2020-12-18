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
    
    var delegado: CovidManagerDelegate?
    
    let covidURL = "https://corona.lmao.ninja/v3/covid-19/countries"
    
    func fetchCovid(nombrePais: String){
        let urlString = "\(covidURL)/\(nombrePais)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String) {
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in if error != nil {
                
                self.delegado?.huboError(cualError: error!)
                return
                }
                
                if let datosSeguros = data {
                    
                    if let covid = self.parseJSON(covidData: datosSeguros){
                        self.delegado?.actualizarCovid(covid: covid)
                    }
                }
            }
            
            tarea.resume()
        }
    }
    
    
    
    func parseJSON(covidData: Data) -> CovidModelo? {
        let decoder = JSONDecoder()
        
        do{
            let dataDecodificada = try decoder.decode(CovidData.self, from: covidData)
            
            let nombre = dataDecodificada.country
            //print (dataDecodificada.countryInfo._id)
            //print(dataDecodificada.countryInfo.flag)
            let imagenpais = dataDecodificada.countryInfo.flag
            
            let casos = dataDecodificada.cases
            let recuperados = dataDecodificada.recovered
            let muertos = dataDecodificada.deaths
            
            let ObjCovid = CovidModelo(nombrePais: nombre, imagenpais: imagenpais, totalCasos: casos, totalRecuperados: recuperados, totalMuertos: muertos)
            
            return ObjCovid
            
        }catch{
            delegado?.huboError(cualError: error)
            return nil
            
        }
    }
    
    
    
    
    
}
