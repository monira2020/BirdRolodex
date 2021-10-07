//
//  BirdListViewController.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 10/3/21.
//

import UIKit

class BirdListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var birdTable: UITableView!
                
        var dbBird:DBHelperBird = DBHelperBird()
        var dbAbility:DBHelperAbility = DBHelperAbility()
        var birds:[BirdModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            dbBird.deleteRow(row: 1)
            dbBird.deleteRow(row: 2)
            dbBird.deleteRow(row: 3)
            dbBird.deleteRow(row: 4)
            dbBird.insert(id: 1, name: "crow", imageURL: "59858041-480px.jpeg", birdDescription: "", abilityIds: "1,2")
            dbBird.insert(id: 2, name: "pigeon", imageURL: "pigeon.jpeg", birdDescription: "", abilityIds: "1,2")
            dbBird.insert(id: 3, name: "parrot", imageURL: "parrot.jpg", birdDescription: "", abilityIds: "1,2")
            dbBird.insert(id: 4, name: "peacock", imageURL: "peacock.jpg", birdDescription: "", abilityIds: "1,2")
            
            birds = dbBird.read()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return birds.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BirdTableCell", for: indexPath) as? BirdTableViewCell
            cell?.birdName?.textAlignment = .right
            cell?.birdName?.text = birds[indexPath.row].name
            cell?.imageView!.image = UIImage(named: "\(birds[indexPath.row].imageURL)")
            cell?.accessoryType = .disclosureIndicator
            return cell ?? UITableViewCell()
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped on row")
        // Write code for navigating to the next screen.
      //
    }

}

