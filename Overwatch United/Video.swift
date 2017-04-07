//
//  Video.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 4/3/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation

class Video: NSObject
{
   private var _videoID: String!
   private var _videoTitle: String!
   private var _videoDescription: String!
   private var _videoThumbNailURL: String!
    
    var videoID: String
    {
        get
        {
            return _videoID
        }
        set
        {
            _videoID = newValue
        }
    }
    
    var videoTitle: String
    {
        get
        {
            return _videoTitle
        }
        set
        {
            _videoTitle = newValue
        }
    }
    
    var videoDescription: String
    {
        get
        {
            return _videoDescription
        }
        set
        {
            _videoDescription = newValue
        }
        
    }
    
    var videoThumbNailURL: String
    {
        get
        {
            return _videoThumbNailURL

        }
        set
        {
            _videoThumbNailURL = newValue
        }
    }
    
}
