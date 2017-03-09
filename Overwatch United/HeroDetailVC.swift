//
//  HeroDetailVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/9/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class HeroDetailVC: UIViewController
{
    var hero: Hero!
    
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroDifficulty: UILabel!
    @IBOutlet weak var heroHealth: UILabel!
    @IBOutlet weak var heroArmour: UILabel!
    @IBOutlet weak var heroShield: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hero.downloadHeroDetails
        {
            print("DID GET HERE!!!!")
            self.updateHeroUI()
        }

    }
    
    func updateHeroUI()
    {
        heroName.text = hero.name.capitalized
        heroImage.image = UIImage(named: hero.name.capitalized)
        heroDescription.text = hero.description
        heroDifficulty.text = hero.difficulty
        heroHealth.text = hero.health
        heroArmour.text = hero.armour
        heroShield.text = hero.shield
    }

}
