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
        collection.delegate = self
        collection.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.addHero{}
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
    
    func addHero(completed: @escaping DownloadComplete)
    {
        print("ENTERED HERO DOWNLOAD INFORMATION")
        let heroURL = URL(string: HERO_INFO_URL)!
        Alamofire.request(heroURL).responseJSON
        {
            response in let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let data = dict["data"] as? [Dictionary<String, AnyObject>], data.count > 0
                {
                    if data.count > 0
                    {
                        for i in 0..<data.count
                        {
                            if let name = data[i]["name"] as? String
                            {
                                let hero = Hero(name: name)
                                print(name)
                                self.heroes.append(hero)
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}

extension HeroesScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return heroes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
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
            return HeroCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var character: Hero!
        character = heroes[indexPath.row]
        
        performSegue(withIdentifier: "HeroDetailsVC", sender: character)
    }
    
}


