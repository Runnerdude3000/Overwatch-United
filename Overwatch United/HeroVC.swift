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
  
    @IBOutlet weak var collection: UICollectionView!
    
    var heroes = [Hero]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        appendHeroes()
       
    }
    
    func appendHeroes()
    {
        let path = Bundle.main.path(forResource: "overwatch", ofType: "csv")
        
        do
        {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            
            for row in rows
            {
                let heroID = Int(row["id"]!)!
                let heroName = row["name"]!
                
                let hero = Hero(name: heroName, heroID: heroID)
                heroes.append(hero)
            }
            print(heroes)
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell
        {
            let character: Hero!
            character = heroes[indexPath.row]
            cell.configureCell(character)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var character: Hero!
        
        character = heroes[indexPath.row]
        performSegue(withIdentifier: "HeroDetailVC", sender: character)
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
