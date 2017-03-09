//
//  ViewController.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController
{

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func userNameEntered(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    @IBAction func passwordEntered(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    @IBAction func onGestureTap(_ sender: UITapGestureRecognizer)
    {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    
}

