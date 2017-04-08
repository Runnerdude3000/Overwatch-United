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

class NewsScreenVC: UIViewController, VideoModelDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
    var selectedVideo: Video?
    let model = VideoModel()

    override func viewDidLoad()
    {
        self.model.delegate = self
        model.grabFeedVideos()
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
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
                destination.selectedVideo = video
            }
        }
    }
}

extension NewsScreenVC: UITableViewDelegate, UITableViewDataSource
{
    func dataReady()
    {
        self.videos = self.model.videos
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell")!
        
        let videoTitle = videos[indexPath.row].videoTitle
        let label = cell.viewWithTag(2) as! UILabel
        label.text = videoTitle
        
        //Construct video thumbnail url
        let videoThumbnailURLString = videos[indexPath.row].videoThumbNailURL
        
        //Create an NSURL object
        let videoThumbNailURL = URL(string: videoThumbnailURLString)
        
        if videoThumbNailURL != nil
        {
            //Create NSURLRequest object
            let request = URLRequest(url: videoThumbNailURL!)
            //Create NSURLSession
            let session = URLSession.shared
            //Create a data task and pass in the request
            let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, resposne: URLResponse?, error: Error?) in
                DispatchQueue.main.async
                {
                    //Get a refernce to the imageview element of the cell
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    //Create an image object from the data and assign it into the image view
                    imageView.image = UIImage(data: data!)
                }
            })
            dataTask.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let video: Video = videos[indexPath.row]
        performSegue(withIdentifier: "VideoVC", sender: video)
    }
}
