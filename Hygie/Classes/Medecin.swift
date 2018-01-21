//
//  Medecin.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import Foundation

class Medecin {

    private var _nom: String = "Inconnu"
    private var _prenom: String = "Inconnu"
    private var _email: String = "Inconnu"
    private var _rpps: Int = 0
    private var _pw: String!
    private var _identifiant: String = "Inconnu"
    
    var nom: String {
        get { return _nom }
        set { _nom = newValue }
    }
    
    var prenom: String {
        get { return _prenom }
        set { _prenom = newValue }
    }
    
    var email: String {
        get { return _email }
        set { _email = newValue }
    }
    
    var identifiant: String {
        get { return _identifiant }
        set { _identifiant = newValue }
    }
    
    var rpps: Int {
        get { return _rpps }
        set { _rpps = newValue }
    }
    
    var rppsStr: String {
        get { return _rpps.description }
    }
    
    var pw: String {
        get { return _pw }
        set { _pw = newValue }
    }

    init(nom: String, prenom: String, pw: String, email: String, rpps: Int, identifiant: String) {
        self.nom = nom
        self.prenom = prenom
        self.pw = pw
        self.email = email
        self.rpps = rpps
        self.identifiant = identifiant
    }
    
    init() {
        self.nom = "Inconnu"
        self.prenom = "Inconnu"
        self.pw = "Inconnu"
        self.email = "Inconnu"
        self.rpps = 0
        self.identifiant = "Inconnu"
    }

}
