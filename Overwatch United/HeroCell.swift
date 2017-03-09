//
//  HeroCell.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/9/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell
{
    var hero: Hero!
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    
    func configureCell(_ hero: Hero)
    {
        self.hero = hero
        
        heroLabel.text = self.hero.name.capitalized
        heroImage.image = UIImage(named: self.hero.name)
    }
}
