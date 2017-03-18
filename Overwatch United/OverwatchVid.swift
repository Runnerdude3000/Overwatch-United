//
//  OverwatchVid.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/15/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation

class OverwatchVid
{
    private var _imageURL: String!
    private var _videoURL: String!
    private var _videoTitle: String!
    
    var imageURL: String
    {
        return _imageURL
    }
    
    var videoURL: String
    {
        return _videoURL
    }
    
    var videoTitle: String
    {
        return _videoTitle
    }
    
    init(imageURL: String, videoURL: String, videoTitle: String)
    {
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
    } 
}
