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
    @IBOutlet weak var videoDescription: UITextView!
    var selectedVideo: Video?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait)
        if let vid = self.selectedVideo
        {
            self.videoTitle.text = vid.videoTitle
            self.videoDescription.text = vid.videoDescription
            
            let width = self.view.frame.size.width
            let height = width / 320 * 180
            
            let videoUrl = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style = \"margin:0\"><iframe frameBorder=\"0\" height=\"\(height)\" width=\"\(width)\" src=\"http://www.youtube.com/embed/\(vid.videoID)?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            self.videoView.loadHTMLString(videoUrl, baseURL: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }

    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
