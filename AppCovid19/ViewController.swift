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
    
    @IBOutlet weak var banderapais: UIImageView!
    
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
        print(buscarPais.text!)
        nombrePaislabel.text = buscarPais.text
        covidManager.fetchCovid(nombrePais: buscarPais.text!)
    }
    
    
    func alertaUsuario(msj: String){
        let alerta = UIAlertController(title: "Ups!", message: msj, preferredStyle: .alert)
        let accion = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(accion)
        present(alerta, animated: true, completion: nil)
        
    }
    
}




// MARK: - Hacer la peticion a la API
extension ViewController: CovidManagerDelegate {
    
    func huboError(cualError: Error){
        
        DispatchQueue.main.async {
            
            
            if cualError.localizedDescription == "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection."{
                self.alertaUsuario(msj: "verificar si la url esta bien escrita o es una conexion segura")
            }
            
            if cualError.localizedDescription == "The data couldn’t be read because it isn’t in the correct format."{
            self.alertaUsuario(msj: "los datos no estan en el formato correcto")
            //self.nombrePaislabel.text = "los datos no estan en el formato correcto"
            }
            
            
            
        
            }
        
        print(cualError.localizedDescription)
        
    }
    
    func actualizarCovid(covid: CovidModelo){
        
        DispatchQueue.main.async {
            
            self.nombrePaislabel.text = covid.nombrePais
            self.banderapais.cargarimagen(url: URL(string: covid.imagenpais)!)
            //self.banderapais.image = UIImage(data: covid.imagen)
            self.totalCasoslabel.text = String(covid.totalCasos)
            self.totalRecuperadoslabel.text = String(covid.totalRecuperados)
            self.totalMuertoslabel.text = String(covid.totalMuertos)
            
        }
        
        print(covid.totalCasos)
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

extension UIImageView {
    func cargarimagen(url: URL){
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

