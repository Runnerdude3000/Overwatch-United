//
//  CharacterVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/9/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import AVFoundation

class HeroVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hero: Hero!
    var heroes = [Hero]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        appendHerores()
    }
    
    func appendHerores()
    {
        for _ in heroes
        {
            let heroItem = Hero(name: hero.name)
            heroes.append(heroItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell
        {
            let hero: Hero!
            hero = heroes[indexPath.row]
            cell.configureCell(hero)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var hero: Hero!
        
        hero = heroes[indexPath.row]
        performSegue(withIdentifier: "HeroDetailVC", sender: hero)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return heroes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 80, height: 80)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "HeroDetailVC"
        {
            if let detailsVC = segue.destination as? HeroDetailVC
            {
                if let hero = sender as? Hero
                {
                    detailsVC.hero = hero
                }
            }
        }
    }
}
