//
//  ViewController.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class LoginScreenVC: UIViewController
{

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID)
        {
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
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
    
    @IBAction func facebookButtonPressed(_ sender: UIButton)
    {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self)
        { (result, error) in
            if error != nil
            {
                print("ERROR: Unable to authenticate with Facebook - \(error)")
            }
            else if result?.isCancelled == true
            {
                print("User cancelled Facebook authentication")
            }
            else
            {
                print("Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential)
    {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil
            {
                print("ERROR: Unable to authenticate with Firebase - \(error)")
            }
            else
            {
                print("Successfully authenticated with Firebase")
                if let user = user
                {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
               
                
            }
        })
    }
    
    @IBAction func loginPressed(_ sender: UIButton)
    {
        if let email = userNameField.text, let password = passwordField.text
        {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil
                {
                    print("Email successfully authenticated with Firebase")
                    if let user = user
                    {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }
                else
                {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil
                        {
                            print("ERROR: Unable to authenticate email with Firebase")
                        }
                        else
                        {
                            print("Email authentication successful")
                            if let user = user
                            {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>)
    {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
}

