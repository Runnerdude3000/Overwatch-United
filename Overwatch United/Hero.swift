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
//    private var _heroID: Int!
    private var _heroURL: String!
    private var _difficulty: String!
    
    var name: String
    {
        if _name == nil
        {
            _name = ""
        }
        return _name
    }
    
    var description: String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    var health: String
    {
        if _health == nil
        {
            _health = ""
        }
        return _health
    }
    
    var armour: String
    {
        if _armour == nil
        {
            _armour = ""
        }
        return _armour
    }
    
    var shield: String
    {
        if _shield == nil
        {
            _shield = ""
        }
        return _shield
    }
    
//    var heroID: Int
//    {
//        if _heroID == nil
//        {
//            _heroID = 0
//        }
//        return _heroID
//    }
    
    var heroURL: String
    {
        if _heroURL == nil
        {
            _heroURL = ""
        }
        return _heroURL
    }
    
    var difficulty: String
    {
        if _difficulty == nil
        {
            _difficulty = ""
        }
        return _difficulty
    }
    
    init(name: String)
    {
        self._name = name
        self._heroURL = String(URL_BASE) + String(URL_HERO)
    }
    
    func downloadHeroDetails(completed: @escaping DownloadComplete)
    {
        Alamofire.request(_heroURL).responseJSON
        {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let data = dict["data"] as? [Dictionary<String, AnyObject>], data.count > 0
                {
                    for i in 0..<data.count
                    {
                        if let name = data[i]["name"] as? String
                        {
                            self._name = name
                            print(self._name)
                        }
                    
                        if let description = data[i]["description"] as? String
                        {
                            self._description = description
                            print(self._description)
                        }
                    
                        if let health = data[i]["health"] as? Int
                        {
                            self._health = String(health)
                            print(self._health)
                        }
                    
                        if let armour = data[i]["armour"] as? Int
                        {
                            self._armour = String(armour)
                            print(self._armour)
                        }
                    
                        if let shield = data[i]["shield"] as? Int
                        {
                            self._shield = String(shield)
                            print(self._shield)
                        }
                    
                        if let difficulty = data[i]["difficulty"] as? Int
                        {
                            self._difficulty = String(difficulty)
                            print(self._difficulty)
                        }
                    }
                }
            }
            completed()
        }
    }
}



