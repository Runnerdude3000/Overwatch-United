//
//  VideoModel.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 4/6/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate
{
    func dataReady()
}

class VideoModel: NSObject
{
    var videos = [Video]()
    var delegate: VideoModelDelegate?
    
    func grabFeedVideos()
    {
        print("GRAB FEED VIDEOS ENTERED")
        //Fetch videos dynamically through Youtube Data API
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlistItems", parameters: ["part" : "snippet", "maxResults" : 15 ,"playlistId" : YOUTUBE_PLAYLIST_ID, "key" : GOOGLE_API_KEY], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
    
            if let JSON = response.result.value as? Dictionary<String, AnyObject>
            {
                //print(JSON)
                if let items = JSON["items"] as? NSArray
                {
                    var videoInfo = [Video]()
                    for video in items
                    {
                        let videoObj = Video()
                        videoObj.videoID = (video as AnyObject).value(forKeyPath: "snippet.resourceId.videoId") as! String
                        print(videoObj.videoID)
                        videoObj.videoTitle = (video as AnyObject).value(forKeyPath: "snippet.title") as! String
                        print(videoObj.videoTitle)
                        videoObj.videoDescription = (video as AnyObject).value(forKeyPath: "snippet.description") as! String
                        print(videoObj.videoDescription)
                        videoObj.videoThumbNailURL = (video as AnyObject).value(forKeyPath: "snippet.thumbnails.maxres.url") as! String
                        print(videoObj.videoThumbNailURL)
                        videoInfo.append(videoObj)
                    }
                    self.videos = videoInfo
    
                    if self.delegate != nil
                    {
                        self.delegate!.dataReady()
                    }
                }
            }
        }
    }
}
