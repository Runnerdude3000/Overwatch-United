//
//  Hero.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/9/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation
import Alamofire


class Hero
{
    private var _name: String!
    private var _description: String!
    private var _health: String!
    private var _armour: String!
    private var _shield: String!
    private var _heroURL: String!
    private var _difficulty: String!
    private var _image: UIImage!
    private var _heroID: Int!
    private var _roll: String!
    
    var heroID: Int
    {
        return _heroID
    }
    
    var name: String
    {
       return _name ?? ""
    }
    
    var description: String
    {
        return _description ?? ""
    }
    
    var health: String
    {
        return _health ?? ""
    }
    
    var armour: String
    {
        return _armour ?? ""
    }
    
    var shield: String
    {
        return _shield ?? ""
    }
    
    var difficulty: String
    {
        return _difficulty ?? ""
    }
    
    var heroURL: String
    {
        return _heroURL ?? ""
    }
    
    var roll: String
    {
        return _roll ?? ""
    }
    
    var image: UIImage
    {
        return _image
    }

    init(name: String, heroID: Int, image: UIImage? = nil)
    {
        self._name = name
        self._heroID = heroID
        self._image = image
        self._heroURL = String(HERO_INFO_URL) + String(self._heroID)
    }
    
    func downloadHeroDetails(completed: @escaping DownloadComplete)
    {
        //NOTE: Edit to grab and match each hero individually. This is gathering all data, but goes to the last hero.
        print("YO BRO, DOWNLOAD STARTED: download via alamo function entered")
        Alamofire.request(_heroURL).responseJSON
        {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let name = dict["name"] as? String
                {
                    self._name = name
                }
                if let description = dict["description"] as? String
                {
                    self._description = description
                }
                if let health = dict["health"] as? Int
                {
                    self._health = String(health)
                }
                if let armour = dict["armour"] as? Int
                {
                    self._armour = String(armour)
                }
                if let shield = dict["shield"] as? Int
                {
                    self._shield = String(shield)
                }
                if let difficulty = dict["difficulty"] as? Int
                {
                    self._difficulty = String(difficulty)
                }
                if let subRoll = dict["role"] as? Dictionary<String, AnyObject>
                {
                    if let roll = subRoll["name"] as? String
                    {
                        self._roll = roll
                    }
                }
            }
            completed()
        }
    }
}











