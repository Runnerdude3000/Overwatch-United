//
//  ForumsScreenVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import Firebase

class ForumsScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    var imageSelected = false
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //Pulls data from database -> posts entity
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        let key = snap.key
                        let post = Post(postID: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForumsCell") as? ForumsCell
        {
            if let image = ForumsScreenVC.imageCache.object(forKey: post.imageURL as NSString)
            {
                cell.configureCell(post: post, image: image)
            }
            else
            {
                cell.configureCell(post: post)
                return cell
            }
            return cell
        }
        else
        {
            return ForumsCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imageAdd.image = image
            imageSelected = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any)
    {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton)
    {
        guard let caption = captionField.text, caption != "" else
        {
            print("Caption must be entered")
            return
        }
        guard let image = imageAdd.image, imageSelected == true else
        {
            print("An image must be selected")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(image, 0.2)
        {
            let imageUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/png"
            
            DataService.ds.STORAGE_IMG_POSTS.child(imageUid).put(imageData, metadata: metaData) { (metaData, error) in
                if error != nil
                {
                    print("Unable to upload image to Firebase storage")
                }
                else
                {
                    print("Successfully uploaded image to Firebase storage")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                }
            }
        }
    }
}






























