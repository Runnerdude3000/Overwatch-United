//
//  ViewController.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/15/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class VideoVC: UIViewController
{
    
    @IBOutlet weak var videoView: UIWebView!
    @IBOutlet weak var videoTitle: UILabel!
    
    private var _video: OverwatchVid!
    
    var video: OverwatchVid
    {
        get
        {
            return _video
        }
        set
        {
            _video = newValue
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        videoTitle.text = video.videoTitle
        videoView.loadHTMLString(video.videoURL, baseURL: nil)
    }

    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    

}
