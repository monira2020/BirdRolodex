//
//  ViewController.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 9/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var birdSearchTextField: UITextField!
    @IBOutlet var birdNameLabel: UILabel!
    @IBOutlet var birdAbilityLabel: UILabel!
    var birdID: String = ""
    
    /*
     * The dismissKeyboard function resigns first responder (dismisses keyboard) when user
     * taps outside the bird search text field (search text field).
     */
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        birdSearchTextField.resignFirstResponder()
    }
    
    /*
     * The search bird ID function (1) resigns first responder (dismisses keyboard) when user
     * taps search and then (2) sets the global birdID variable to the user input text.
     */
    @IBAction func searchCity(_ sender: UIButton) {
        birdSearchTextField.resignFirstResponder()
        birdID = birdSearchTextField.text! // set zipcode to user input
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGreen
        birdSearchTextField?.attributedPlaceholder = NSAttributedString(string: "bird ID",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // Do any additional setup after loading the view.
    }


}

