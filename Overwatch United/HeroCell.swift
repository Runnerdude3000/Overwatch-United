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
   
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
   
    var hero: Hero!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ hero: Hero)
    {
        self.hero = hero
        
        cellLabel.text = self.hero.name.capitalized
        cellImage.image = UIImage(named: String(self.hero.heroID))
    }
}
