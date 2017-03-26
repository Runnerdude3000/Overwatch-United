//
//  ForumsCell.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import Firebase

class ForumsCell: UITableViewCell
{
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var likesref: FIRDatabaseReference!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likePressed))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true

    }

    func configureCell(post: Post, image: UIImage? = nil, profileImage: UIImage? = nil)
    {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = String(post.likes)
        
//        //PULL DATA FROM FIREBASE FOR PROFILE IMAGE
//        if profileImage != nil
//        {
//            self.profileImg.image = profileImage
//        }
//        else
//        {
//            let picref = FIRStorage.storage().reference(forURL: post.profileImageURL)
//            picref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
//                if error != nil
//                {
//                    print("Unable to download profile image from firebase storage")
//                }
//                else
//                {
//                    print("Profile image downloaded from firebase storage")
//                    if let imgData = data
//                    {
//                        if let img = UIImage(data: imgData)
//                        {
//                            self.profileImg.image = img
//                            ForumsScreenVC.imageCache.setObject(img, forKey: post.profileImageURL as NSString)
//                        }
//                    }
//                }
//            })
//        }
//        //====================================================
        
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
        
        likesref = DataService.ds.REF_USER_CURRENT.child("likes").child(self.post.postID)
        likesref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull
            {
                self.likeImg.image = UIImage(named: "empty-heart")
            }
            else
            {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    func likePressed(_ sender: UITapGestureRecognizer)
    {
        likesref = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postID)
        likesref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull
            {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesref.setValue(true)
            }
            else
            {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesref.removeValue()
            }
        })
    }
}
