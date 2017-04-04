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
    func updateCellUI(video: Video)
    {
        videoTitle.text = video.videoTitle
        
        
    }
}
