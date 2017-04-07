//
//  HeroDetailsVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/26/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class HeroDetailsVC: UIViewController
{
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: CircleImageView!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var armour: UILabel!
    @IBOutlet weak var shield: UILabel!
    @IBOutlet weak var rollImage: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    
    var hero: Hero!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hero.downloadHeroDetails
        {
            self.updateHeroUI()
        }

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    func updateHeroUI()
    {
        heroName.text = hero.name
        heroImage.image = UIImage(named: String(hero.heroID))
        difficulty.text = hero.difficulty
        health.text = hero.health
        armour.text = hero.armour
        shield.text = hero.shield
        heroDescription.text = hero.description
        rollImage.image = UIImage(named: hero.roll)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }

}
