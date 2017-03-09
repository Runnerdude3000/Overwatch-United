//
//  ProfileScreenVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/8/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class ProfileScreenVC: UIViewController
{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tankImage: UIImageView!
    @IBOutlet weak var damageImage: UIImageView!
    @IBOutlet weak var defenseImage: UIImageView!
    @IBOutlet weak var healImage: UIImageView!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rollsButtonPressed(_ sender: UIButton)
    {
        
    }
}
