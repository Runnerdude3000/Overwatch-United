//
//  VideoCellTableViewCell.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 2/15/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell
{
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    //to update table cell upon refresh
    func updateCellUI(video: OverwatchVid)
    {
        videoTitle.text = video.videoTitle
        
        let imURL = URL(string: video.imageURL)!
        
        DispatchQueue.global().async
        {
            do
            {
                let data = try Data(contentsOf: imURL)
                DispatchQueue.global().sync
                {
                    self.videoImage.image = UIImage(data: data)
                }
            }
            catch
            {
                    //handle the error
            }
        }
    }
}
