//
//  ConnectedViewController.swift
//  Hygie
//
//  Created by Francois on 20/01/2018.
//  Copyright © 2018 GODIN FRANCOIS. All rights reserved.
//

import UIKit
import SQLite

class ConnectedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var rppsLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var dataPersistance: DataPersistance!
    var listConsult: [Consultation] = []
    var medecin = Medecin()
    var editRequested = false

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.listConsult.count
    }
    
    //Remplissage Liste
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConnectedViewControllerTableViewCell
        cell.nomPatientLabel.text = listConsult[indexPath.row].patient.nom
        cell.objetLabel.text = listConsult[indexPath.row].objet
        cell.horaireLabel.text = listConsult[indexPath.row].horaire
        return(cell)
    }
    
    //Envoi des données vers EditViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            if let destinationVC = segue.destination as? EditViewController {
                destinationVC.medecin = self.medecin
                destinationVC.dataPersistance = self.dataPersistance
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Remplissage des données médecin
        welcomeLabel.text = "Bienvenue Docteur "+self.medecin.nom+"\n Vos prochains rendez-vous sont : "
        nomLabel.text = self.medecin.nom
        prenomLabel.text = self.medecin.prenom
        rppsLabel.text = self.medecin.rppsStr
        idLabel.text = self.medecin.identifiant
        emailLabel.text = self.medecin.email
        listConsult = self.dataPersistance.findConsultationsByIDMedecin(id: self.medecin.identifiant)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
}
