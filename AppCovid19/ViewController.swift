//
//  ViewController.swift
//  AppCovid19
//
//  Created by Mac8 on 15/12/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var covidManager = CovidManager()
    
    
    @IBOutlet weak var buscarPais: UITextField!
    
    @IBOutlet weak var nombrePaislabel: UILabel!
    
    
    @IBOutlet weak var totalCasoslabel: UILabel!
    
    @IBOutlet weak var totalRecuperadoslabel: UILabel!
    
    @IBOutlet weak var totalMuertoslabel: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        covidManager.delegado = self
        
        buscarPais.delegate = self
        
        
    }
    
    
    @IBAction func BuscarPaises(_ sender: UIButton) {
    }

}

// MARK: - Hacer la peticion a la API
extension ViewController: CovidManagerDelegate {
    
    func huboError(cualError: Error){
        
        DispatchQueue.main.async {
            self.nombrePaislabel.text = cualError.localizedDescription
        }
        
        print(cualError.localizedDescription)
        
    }
    
    func actualizarCovid(covid: CovidModelo){
        
        DispatchQueue.main.async {
            
            self.nombrePaislabel.text = covid.nombrePais
            self.totalCasoslabel.text = "Total de casos: \(String(covid.totalCasos))"
            self.totalRecuperadoslabel.text = "Total de recuperados: \(String(covid.totalRecuperados))"
            self.totalMuertoslabel.text = "Total de muertos: \(String(covid.totalMuertos))"
            
        }
    }
}

//MARK: - delegado del TextField
extension ViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        buscarPais.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        covidManager.fetchCovid(nombrePais: buscarPais.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarPais.text != ""{
            return true
        } else {
            buscarPais.placeholder = "escribe una ciudad"
            print("Por favor escribe algo..")
            return false
        }
    }
    
    
}

