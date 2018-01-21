//
//  SubscribeViewController.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {
    
    @IBOutlet weak var identifiantTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var rppsTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    @IBAction func enter(_ sender: Any) {
        if identifiantTextField.text != "" && nomTextField.text != "" && prenomTextField.text != "" && mailTextField.text != "" && rppsTextField.text != ""
        {
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    var dataPersistance: DataPersistance!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainController = segue.destination as! ViewController
        let textFieldInt: Int? = Int(rppsTextField.text!)
        let nouvMedecin = Medecin(nom: nomTextField.text!, prenom: prenomTextField.text!, pw: pwTextField.text!, email: mailTextField.text!, rpps: textFieldInt!, identifiant: identifiantTextField.text!)
        self.dataPersistance.insertMedecin(med: nouvMedecin)
        mainController.dataPersistance = self.dataPersistance
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segue"
        {
            if self.dataPersistance.doesAlreadyExist(id: identifiantTextField.text!)
            {
                let alert = UIAlertController(title: "Alert", message: "Un médecin portant cet identifiant existe déjà", preferredStyle: .alert)
                self.present(alert, animated: true){
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
                }
                return false
            }
            var num = Int(self.rppsTextField.text!)
            if num == nil
            {
                let alert = UIAlertController(title: "Alert", message: "Votre numéro RPPS doit être exclusivement constitué de chiffres", preferredStyle: .alert)
                self.present(alert, animated: true){
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
                }
                return false
            }
        }
        return true
    }
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
