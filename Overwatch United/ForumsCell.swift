//
//  ForumsCell.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import FirebaseStorage

class ForumsCell: UITableViewCell
{
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

    }

    func configureCell(post: Post, image: UIImage? = nil)
    {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = String(post.likes)
        
        if image != nil
        {
            self.postImg.image = image
        }
        else
        {
            let ref = FIRStorage.storage().reference(forURL: post.imageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil
                {
                    print("Unable to download image form firebase storage")
                }
                else
                {
                    print("Image downloaded from firebase storage")
                    if let imgData = data
                    {
                        if let img = UIImage(data: imgData)
                        {
                            self.postImg.image = img
                            ForumsScreenVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                        }
                    }
                }
            })
        }
    }
}
