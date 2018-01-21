//
//  DataPersistance.swift
//  Hygie
//
//  Created by Francois on 20/01/2018.
//  Copyright © 2018 GODIN FRANCOIS. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class DataPersistance{
    
    var database: Connection!
    
    let medecinsTable = Table("medecinsTable")
    let idMed = Expression<String>("idMed")
    let pwMed = Expression<String>("pwMed")
    let nomMed = Expression<String>("nomMed")
    let prenomMed = Expression<String>("prenomMed")
    let mailMed = Expression<String>("mailMed")
    let rppsMed = Expression<Int>("rppsMed")
    
    let consultationsTable = Table("consultations")
    let idConsu = Expression<Int>("idConsu")
    let idMedConsu = Expression<String>("idMedConsu")
    let nomPatConsu = Expression<String>("nomPatConsu")
    let horaireConsu = Expression<String>("horaireConsu")
    let objetConsu = Expression<String>("objetConsu")
    let telConsu = Expression<String>("telConsu")
    
    init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch { print(error) }
        do{
            try database.execute("DROP TABLE consultations")
        } catch { print(error) }
        do{
            try database.execute("DROP TABLE medecins")
        } catch { print(error) }
        self.createTable()
        self.populate()
    }
    
    func insertMedecin(med: Medecin){
        print("INSERTION MEDECIN")
        let insertMed = self.medecinsTable.insert(self.idMed <- med.identifiant, self.pwMed <- med.pw, self.nomMed <- med.nom, self.prenomMed <- med.prenom, self.mailMed <- med.email, self.rppsMed <- med.rpps)
        
        do{
            try self.database.run(insertMed)
            print("MEDECIN INSERE")
        } catch{
            print(error)
        }
    }
    
    func findMedecin(id: String) -> Medecin{
        var medecin = Medecin()
        do{
            let query = self.medecinsTable.filter(self.idMed == id)
            let row = try self.database.pluck(query)
            if row != nil {
                print("MEDECIN TROUVE")
                print(row![nomMed])
                medecin = Medecin(nom: row![nomMed],prenom: row![prenomMed],pw: row![pwMed],email: row![mailMed],rpps: row![rppsMed],identifiant: row![idMed])
            }
            else {
                print("MEDECIN NON TROUVE")
            }
        }
        catch{print("MEDECIN NON TROUVE")}
        return medecin
    }
    
    //Met à jour les attributs d'un médecin trouvé par son identifiant par remplacement (à améliorer)
    func updateMedecinByID(id: String, medecin: Medecin) {
        do{
            let med = self.medecinsTable.filter(self.idMed == id)
            try self.database.run(med.delete())
        } catch{print(error)}
        insertMedecin(med: medecin)
    }
    
    //Renvoie la liste des consultation d'un médecin trouvé par son identifiant
    func findConsultationsByIDMedecin(id: String) -> [Consultation] {
        var listConsult: [Consultation] = []
        print("Recherche des consultations de "+id)
        let med = findMedecin(id: id)
        do{
            let query = self.consultationsTable.filter(self.idMedConsu == med.identifiant)
            for consul in try database.prepare(consultationsTable.filter(self.idMedConsu == med.identifiant)){
                let c = Consultation(med: Medecin(), pat: Patient(nom: consul[nomPatConsu], telephone: consul[telConsu]), horaire: consul[horaireConsu], objet: consul[objetConsu])
                listConsult.append(c)
            }
        } catch{
            print(error)
        }
        return listConsult
    }
    
    func insertConsultation(consu: Consultation){
        let insertConsul = self.consultationsTable.insert(self.idMedConsu <- consu.medecin.identifiant, self.nomPatConsu <- consu.patientStr, self.horaireConsu <- consu.horaire, self.objetConsu <- consu.objet, self.telConsu <- consu.patient.telephone)
        do{
            try self.database.run(insertConsul)
        } catch{
            print(error)
        }
    }
    
    //Vérifie si un médecin portant l'identifiant existe déjà, renvoie true si oui
    func doesAlreadyExist(id: String) -> Bool {
        var medecin = Medecin()
        do{
            let query = self.medecinsTable.filter(self.idMed == id)
            let row = try self.database.pluck(query)
            if row != nil {
                return true
            }
            else {
                return false
            }
        }
        catch{print(error)}
        return false
    }
    
    func verifLogsConnexion(id: String, pw: String) -> Bool{
        do{
            let query = self.medecinsTable.filter(self.idMed == id && self.pwMed == pw)
            var row = try self.database!.pluck(query)
            if row != nil {
                print("LE MEDECIN EST AUTHENTIFIE")
                return true
            }
            else {
                print("LE MEDECIN NEST PAS AUTHENTIFIE")
                return false
            }
        }
        catch{print("PAS AUTHENTIFIE")}
        return false
    }
    
    func createTable(){
        print("\n CREATE TABLE LAUNCHED\n")
        let createTableMeds = self.medecinsTable.create{ (table) in
            table.column(self.idMed, primaryKey: true)
            table.column(self.pwMed)
            table.column(self.nomMed)
            table.column(self.prenomMed)
            table.column(self.mailMed, unique: true)
            table.column(self.rppsMed, unique: true)
        }
        do{
            try self.database.run(createTableMeds)
            print("CREATE TABLE MEDECINS : SUCCESSFULY CREATED")
        } catch { print(error) }
        
        let createTableConsus = self.consultationsTable.create{ (table) in
            table.column(self.idConsu, primaryKey: true)
            table.column(self.idMedConsu)
            table.column(self.nomPatConsu)
            table.column(self.horaireConsu)
            table.column(self.objetConsu)
            table.column(self.telConsu)
        }
        do{
            try self.database.run(createTableConsus)
            print("CREATE TABLE CONSULTATIONS : SUCCESSFULY CREATED")
        } catch { print(error) }
    }
    
    func populate(){
        let m = Medecin(nom: "House", prenom: "Gregory", pw: "1234", email: "gregHouse@gmal.us", rpps: 75987, identifiant: "gregoryHouse01")
        let m2 = Medecin(nom: "Karp", prenom: "Jean-Claude", pw: "1234", email: "jcKarp@gmal.us", rpps: 15418, identifiant: "karp")
        let m3 = Medecin(nom: "Freud", prenom: "Sigmund", pw: "4321", email: "sFreud@gmal.us", rpps: 12561, identifiant: "freud")
        let p1 = Patient(nom: "Pascal", prenom: "Blaise", email: "pression@gmal.fr", age: 32, telephone: "0682442189")
        let p2 = Patient(nom: "Imaginaire", prenom: "Malade", email: "hypochondriaque@gmal.fr", age: 12, telephone: "0682442189")
        let p3 = Patient(nom: "Babar", prenom: "Leroi", email: "babar@gmal.fr", age: 22, telephone: "0682442189")
        let p4 = Patient(nom: "Bonaparte", prenom: "Napoléon", email: "jepossedeleurope@gmal.fr", age: 42, telephone: "0682442189")
        let p5 = Patient(nom: "Quasisanstete", prenom: "Nick", email: "etete@gmal.fr", age: 37, telephone: "0682442189")
        let p6 = Patient(nom: "House", prenom: "Gregory", email: "mysanthrope@gmal.fr", age: 31, telephone: "0682442189")
        let p7 = Patient(nom: "Legrand", prenom: "Alexandre", email: "jepossedelasie@gmal.fr", age: 32, telephone: "0682442189")
        let p8 = Patient(nom: "Tchaïkovski", prenom: "Piotr Illitch", email: "melomane@gmal.fr", age: 48, telephone: "0682442189")
        let p9 = Patient(nom: "DeMedicis", prenom: "Marie", email: "venise@gmal.fr", age: 53, telephone: "0682442189")
        let p10 = Patient(nom: "Givoarien", prenom: "Fred", email: "miro@gmal.fr", age: 72, telephone: "0682442189")
        let p11 = Patient(nom: "XVIII", prenom: "Louis", email: "jepossedelafrance@gmal.fr", age: 31, telephone: "0682442189")
        let p12 = Patient(nom: "Trump", prenom: "Donald", email: "ausecours@gmal.fr", age: 32, telephone: "0682442189")
        
        let c1 = Consultation(med: m, pat: p1, horaire: "01/02/2018", objet: "Malaise")
        let c2 = Consultation(med: m, pat: p2, horaire: "01/02/2018", objet: "Cécité")
        let c3 = Consultation(med: m, pat: p3, horaire: "01/02/2018", objet: "Ulcère")
        let c4 = Consultation(med: m, pat: p4, horaire: "01/02/2018", objet: "Mal de tête")
        let c5 = Consultation(med: m, pat: p5, horaire: "01/02/2018", objet: "Misanthrope")
        let c6 = Consultation(med: m, pat: p6, horaire: "01/02/2018", objet: "Paludisme")
        let c7 = Consultation(med: m, pat: p7, horaire: "01/02/2018", objet: "Choléra")
        let c8 = Consultation(med: m, pat: p8, horaire: "01/02/2018", objet: "Mal à la jambe")
        let c9 = Consultation(med: m, pat: p9, horaire: "01/02/2018", objet: "Maux de tête")
        let c10 = Consultation(med: m, pat: p10, horaire: "01/02/2018", objet: "Vision")
        let c11 = Consultation(med: m, pat: p11, horaire: "01/02/2018", objet: "Goutte")
        let c12 = Consultation(med: m, pat: p12, horaire: "01/02/2018", objet: "Calvitie")
        
        insertMedecin(med: m); insertMedecin(med: m2); insertMedecin(med: m3)
        insertConsultation(consu: c1);insertConsultation(consu: c2);insertConsultation(consu: c3);insertConsultation(consu: c4);insertConsultation(consu: c5);insertConsultation(consu: c6);insertConsultation(consu: c7);insertConsultation(consu: c8);insertConsultation(consu: c9);insertConsultation(consu: c10);insertConsultation(consu: c11);insertConsultation(consu: c12);
    }
}
