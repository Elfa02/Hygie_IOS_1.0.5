//
//  Consultation.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import Foundation

class Consultation {
    
    private var _medecin: Medecin!
    private var _patient: Patient!
    private var _horaire: String = "Inconnu"
    private var _objet: String = "Inconnu"
    
    var medecin: Medecin {
        get { return _medecin }
        set { _medecin = newValue }
    }
    
    var patient: Patient {
        get { return _patient }
        set { _patient = newValue }
    }
    
    var patientStr: String {
        get { return _patient.nom+" "+_patient.prenom}
    }
    
    var horaire: String {
        get { return _horaire }
        set { _horaire = newValue }
    }
    
    var objet: String {
        get { return _objet }
        set { _objet = newValue }
    }
    
    init(med: Medecin, pat: Patient, horaire: String, objet: String) {
        self.medecin = med
        self.patient = pat
        self.horaire = horaire
        self.objet = objet
    }
    
}
