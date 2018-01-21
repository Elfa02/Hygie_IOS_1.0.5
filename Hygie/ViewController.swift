//
//  ViewController.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var isConnected = false;
    var isFirstLaunch = true;
    var dataPersistance: DataPersistance!
    
    @IBOutlet weak var connectButto: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var okButto: UIButton!
    
    @IBOutlet weak var subButto: UIButton!
    @IBOutlet weak var test: UILabel!
    @IBAction func connectButton(_ sender: Any) {
        if isConnected == true
        {
            self.performSegue(withIdentifier: "conditionSegue", sender: self)
        }
    }
    
    //Envoi des données vers ConnectedViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conditionSegue" && isConnected {
            if let destinationVC = segue.destination as? ConnectedViewController {
                let med = self.dataPersistance.findMedecin(id: idConnexion)
                destinationVC.medecin = med
                let listConsult: [Consultation] = self.dataPersistance.findConsultationsByIDMedecin(id: idConnexion)
                destinationVC.listConsult = listConsult
                destinationVC.dataPersistance = self.dataPersistance
            }
        }
        if segue.identifier == "subscribeSegue" {
            if let destinationVC = segue.destination as? SubscribeViewController {
                destinationVC.dataPersistance = self.dataPersistance
            }
        }
        if segue.identifier == "connectSegue" {
            if let destinationVC = segue.destination as? ConnectViewController {
                destinationVC.dataPersistance = self.dataPersistance
            }
        }
    }

    var nouvMedecin = Medecin()
    var idConnexion = String()
    var pwConnexion = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n viewDidLoad \n")
        if isFirstLaunch == true
        {
            self.dataPersistance = DataPersistance()
            isFirstLaunch = false
        }
        self.isConnected = self.dataPersistance.verifLogsConnexion(id: idConnexion, pw: pwConnexion)
        print("connecté? : "+self.isConnected.description)
        if isConnected == false
        {
            okButto.isHidden = true
        }
        else
        {
            connectButto.isHidden = true
            subButto.isHidden = true
            okButto.setTitle("Voir vos consultations", for: .normal)
            welcomeLabel.text = "Bienvenue !"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

