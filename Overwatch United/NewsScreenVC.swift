//
//  NewsScreen.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase
import Alamofire


class NewsScreenVC: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
  //  var delegate: VideoModelDelegate?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        grabFeedVideos()
    }
    
    func grabFeedVideos()
    {
        print("GRAB FEED VIDEOS ENTERED")
        //Fetch videos dynamically through Youtube Data API
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlistItems", parameters: ["part" : "snippet", "maxResults" : 15 ,"playlistId" : YOUTUBE_PLAYLIST_ID, "key" : GOOGLE_API_KEY], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if let JSON = response.result.value as? Dictionary<String, AnyObject>
            {
                if let items = JSON["items"] as? NSArray
                {
                    var videoInfo = [Video]()
                    for video in items
                    {
                        let videoObj = Video()
                        videoObj.videoID = (video as AnyObject).value(forKeyPath: "snippet.resourceId.videoId") as! String
                        videoObj.videoTitle = (video as AnyObject).value(forKeyPath: "snippet.title") as! String
                        videoObj.videoDescription = (video as AnyObject).value(forKeyPath: "snippet.description") as! String
                        videoObj.videoThumbNailURL = (video as AnyObject).value(forKeyPath: "snippet.thumbnails.maxres.url") as! String
                        videoInfo.append(videoObj)
                    }
                    self.videos = videoInfo
                }
            }
        }
    }
    
    
    @IBAction func logoutPressed(_ sender: UIButton)
    {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? VideoVC
        {
            if let video = sender as? Video
            {
                destination.video = video
            }
        }
    }
}

extension NewsScreenVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell
        {
            let video = videos[indexPath.row]
            cell.updateCellUI(video: video)
            
            return cell
        }
        else
        {
            return VideoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let video = videos[indexPath.row]
        performSegue(withIdentifier: "VideoVC", sender: video)
    }
}
