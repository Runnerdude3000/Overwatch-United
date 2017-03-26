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
    
    var image: UIImage
    {
        return _image
    }

    init(name: String, image: UIImage? = nil)
    {
        self._name = name
        self._image = image
        self._heroURL = String(HERO_INFO_URL)
    }
    
    func downloadHeroDetails(completed: @escaping DownloadComplete)
    {
        print("YO BRO, DOWNLOAD STARTED: download via alamo function entered")
        Alamofire.request(_heroURL).responseJSON
        {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>
            {
                if let data = dict["data"] as? [Dictionary<String, AnyObject>], data.count > 0
                {
                    if data.count > 0
                    {
                        for i in 0..<data.count
                        {
                            if let name = data[i]["name"] as? String
                            {
                                self._name = name
                            }
                            if let description = data[i]["description"] as? String
                            {
                                self._description = description
                            }
                            if let health = data[i]["health"] as? Int
                            {
                                self._health = String(health)
                            }
                            if let armour = data[i]["armour"] as? Int
                            {
                                self._armour = String(armour)
                            }
                            if let shield = data[i]["shield"] as? Int
                            {
                                self._shield = String(shield)
                            }
                            if let difficulty = data[i]["difficulty"] as? Int
                            {
                                self._difficulty = String(difficulty)
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
