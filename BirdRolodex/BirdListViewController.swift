//
//  BirdListViewController.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 10/3/21.
//

import UIKit

class BirdListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var birdTable: UITableView!
                
        var db:DBHelper = DBHelper()
        
        var birds:[BirdModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
//            db.deleteRow()
            db.insert(id: 1, name: "crow")
            db.insert(id: 2, name: "pigeon")
            db.insert(id: 3, name: "parrot")
            db.insert(id: 4, name: "peacock")
            
            birds = db.read()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return birds.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BirdTableCell", for: indexPath) as? BirdTableViewCell
            cell?.birdName?.text = "Name: " + birds[indexPath.row].name
            cell?.accessoryType = .disclosureIndicator
            return cell ?? UITableViewCell()
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped on row")
        // Write code for navigating to the next screen.
      //
    }

}

