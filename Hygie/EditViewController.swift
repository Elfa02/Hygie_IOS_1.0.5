//
//  EditViewController.swift
//  Hygie
//
//  Created by Francois on 20/01/2018.
//  Copyright © 2018 GODIN FRANCOIS. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var rppsTextField: UITextField!
    @IBAction func validerButton(_ sender: Any) {
        if true
        {

        }
    }
    
    var dataPersistance: DataPersistance!
    var medecin = Medecin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomTextField.text = medecin.nom
        prenomTextField.text = medecin.prenom
        motDePasseTextField.text = medecin.pw
        emailTextField.text = medecin.email
        rppsTextField.text = medecin.rppsStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let connectedController = segue.destination as! ConnectedViewController
        let textFieldInt: Int? = Int(rppsTextField.text!)
        let idTemp = self.medecin.identifiant
        medecin = Medecin(nom: nomTextField.text!, prenom: prenomTextField.text!, pw: motDePasseTextField.text!, email: emailTextField.text!, rpps: textFieldInt!, identifiant: idTemp)
        self.dataPersistance.updateMedecinByID(id: self.medecin.identifiant, medecin: self.medecin)
        
        connectedController.medecin = self.medecin
        connectedController.listConsult = self.dataPersistance.findConsultationsByIDMedecin(id: self.medecin.identifiant)
        connectedController.dataPersistance = self.dataPersistance
    }
    

}
