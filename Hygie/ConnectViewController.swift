//
//  ConnectViewController.swift
//  Hygie
//
//  Created by GODIN FRANCOIS on 22/12/2017.
//  Copyright © 2017 GODIN FRANCOIS. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

    
    @IBOutlet weak var idConnect: UITextField!
    @IBOutlet weak var pwConnect: UITextField!
    
    var dataPersistance:DataPersistance!
    
    @IBAction func enter(_ sender: Any) {
        if idConnect.text != ""
        {
            if self.dataPersistance.verifLogsConnexion(id: self.idConnect.text!, pw: self.pwConnect.text!)
            {
                performSegue(withIdentifier: "segue", sender: self)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segue"
        {
            if self.dataPersistance.verifLogsConnexion(id: self.idConnect.text!, pw: self.pwConnect.text!) == false
            {
                let alert = UIAlertController(title: "Alert", message: "Les renseignements fournis n'ont pas permis de vous authentifier.", preferredStyle: .alert)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var mainController = segue.destination as! ViewController
        mainController.idConnexion = idConnect.text!
        mainController.pwConnexion = pwConnect.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
