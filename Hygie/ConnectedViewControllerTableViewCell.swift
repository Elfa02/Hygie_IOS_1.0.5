//
//  ConnectedViewControllerTableViewCell.swift
//  Hygie
//
//  Created by Francois on 20/01/2018.
//  Copyright © 2018 GODIN FRANCOIS. All rights reserved.
//

import UIKit

class ConnectedViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var nomPatientLabel: UILabel!
    @IBOutlet weak var objetLabel: UILabel!
    @IBOutlet weak var horaireLabel: UILabel!
    @IBAction func callButton(_ sender: Any) {
        if let url = URL(string: "tel://\("0682442189")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
