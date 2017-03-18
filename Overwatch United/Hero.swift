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
    private var _heroID: Int!
    private var _heroURL: String!
    private var _difficulty: String!
    
    var name: String
    {
       return _name
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
    
    var heroID: Int
    {
        return _heroID
    }
    
    var heroURL: String
    {
        return _heroURL ?? ""
    }
    
    var difficulty: String
    {
        return _difficulty ?? ""
    }
    
    init(name: String, heroID: Int)
    {
        self._name = name
        
        self._heroID = heroID
        
        self._heroURL = "\(URL_BASE)\(URL_HERO)\(self._heroID)"
        
//        var i = 0
//        repeat
//        {
//            i += 1
//            self._heroURL = "\(URL_BASE)\(URL_HERO)\(i)"
//        }
//        while i < 24
        
    }
    
    func downloadHeroDetails(completed: @escaping DownloadComplete)
    {
        print("download via alamo function entered")
        Alamofire.request(_heroURL).responseJSON
        {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
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
            }
            completed()
        }
    }
}



