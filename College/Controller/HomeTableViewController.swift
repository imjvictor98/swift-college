//
//  HomeTableViewController.swift
//  College
//
//  Created by João Victor on 17/01/20.
//  Copyright © 2020 João Victor. All rights reserved.
//

import UIKit
import Alamofire 
import SwiftyJSON

class HomeTableViewController: UITableViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    
    var student:Student =  Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = student.name
        id.text = student.cod_student
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ImageUtils.roundImage(roundFor: profilePicture)
        
        
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            print("Selected")
            self.performSegue(withIdentifier: "dashboard_to_gradeSheet", sender: nil)
        }
    }
}


