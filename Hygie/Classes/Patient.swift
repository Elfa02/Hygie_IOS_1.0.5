//
//  Patient.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import Foundation

class Patient {
    
    private var _nom: String = "Inconnu"
    private var _prenom: String = "Inconnu"
    private var _email: String = "Inconnu"
    private var _age: Int = 0
    private var _telephone: String = "Inconnu"
    
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
    
    var telephone: String {
        get { return _telephone }
        set { _telephone = newValue }
        
    }
    
    var age: Int {
        get { return _age }
        set { _age = newValue }
    }
    
    init(nom: String, prenom: String, email: String, age: Int, telephone: String) {
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.age = age
        self.telephone = telephone
    }
    
    init(nom: String, telephone: String){
        self.nom = nom
        self.telephone = telephone
    }
}
