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

class NewsScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos = [OverwatchVid]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        grabVideos()
        
    }
    
    func grabVideos()
    {
        let vid1 = OverwatchVid(imageURL: "https://img.youtube.com/vi/Q_FJwx_iYDk/hqdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/Q_FJwx_iYDk\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Developer Update | Introducing the Server Browser | Overwatch")
        
        let vid2 = OverwatchVid(imageURL: "https://img.youtube.com/vi/SX2lJuk66xI/hqdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/SX2lJuk66xI\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "[NEW SEASONAL EVENT] Welcome to the Year of the Rooster!")
        
        let vid3 = OverwatchVid(imageURL: "https://img.youtube.com/vi/At7NWZ_mw6s/hqdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/At7NWZ_mw6s\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Developer Update | Capture The Flag | Overwatch")
        
        let vid4 = OverwatchVid(imageURL: "https://img.youtube.com/vi/ibPLyx8QWYc/hqdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ibPLyx8QWYc\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Developer Update | PTR Philosophy | Overwatch")
        
        let vid5 = OverwatchVid(imageURL: "https://img.youtube.com/vi/rhVZ-QIu4jk/hqdefault.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/rhVZ-QIu4jk\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "[NOW AVAILABLE] Oasis | New Map Preview | Overwatch")
        
        videos.append(vid1)
        videos.append(vid2)
        videos.append(vid3)
        videos.append(vid4)
        videos.append(vid5)
    }
    
    @IBAction func logoutPressed(_ sender: UIButton)
    {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
        
    }

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
            return UITableViewCell()
        }
    }
    
    //UITableViewDelegate implementation: returns items in videos array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return videos.count
    }
    
    //UITableViewDelegate implementation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let video = videos[indexPath.row]
        performSegue(withIdentifier: "VideoVC", sender: video)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? VideoVC
        {
            if let video = sender as? OverwatchVid
            {
                destination.video = video
            }
        }
    }
    
    
   
}
