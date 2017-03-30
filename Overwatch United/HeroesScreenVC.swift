//
//  HeroesScreenVCViewController.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/26/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import Alamofire

class HeroesScreenVC: UIViewController
{
    @IBOutlet weak var collection: UICollectionView!
    var heroes = [Hero]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self

        parseHeroCSV()
    }

    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "HeroDetailsVC"
        {
            if let detailsVC = segue.destination as? HeroDetailsVC
            {
                if let character = sender as? Hero
                {
                    detailsVC.hero = character
                }
            }
        }
    }
    
    func parseHeroCSV()
    {
        let path = Bundle.main.path(forResource: "overwatch", ofType: "csv")
        do
        {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            
            for row in rows
            {
                let heroId = Int(row["id"]!)!
                let name = row["name"]!
                
                let hero = Hero(name: name, heroID: heroId)
                heroes.append(hero)
            }
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
}

extension HeroesScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
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
            return HeroCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var character: Hero!
        character = heroes[indexPath.row]
        
        performSegue(withIdentifier: "HeroDetailsVC", sender: character)
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
        return CGSize(width: 90, height: 90)
    }
    
}


