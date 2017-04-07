//
//  ForumsScreenVC.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/14/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import UIKit
import Firebase

class ForumsScreenVC: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var profilePicAdd: UIImageView!
    
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
            self.posts = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        let key = snap.key
                        let post = Post(postID: key, postData: postDict)
                        self.posts.insert(post, at: 0)
                    }
                }
            }
            self.tableView.reloadData()
        })
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

    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
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
        
        setImageData()
//        guard let image = imageAdd.image, imageSelected == true else
//        {
//            print("An image must be selected")
//            return
//        }
    }
    
    func setImageData()
    {
        if let imageData = UIImageJPEGRepresentation(imageAdd.image!, 0.2)/*, let profImageData = UIImageJPEGRepresentation(profilePicAdd.image!, 0.2) */
        {
            let imageUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/png"
            
            DataService.ds.STORAGE_IMG_POSTS.child(imageUid).put(imageData, metadata: metaData)
            { (metaData, error)
                in
                if error != nil
                {
                    print("Unable to upload image to Firebase storage")
                }
                else
                {
                    print("Successfully uploaded image to Firebase storage")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                
                    if let url = downloadURL
                    {
                        self.postToFirebase(imgURL: url)
                    }
                }
            }
        }
    }
    
    func postToFirebase(imgURL: String)
    {
        let post: Dictionary<String, AnyObject> =
        [
            "caption" : captionField.text as AnyObject,
            "imageUrl" : imgURL as AnyObject,
            "likes" : 0 as AnyObject
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        tableView.reloadData()
        
        captionField.text = ""
        imageSelected = false
        imageAdd.image = UIImage(named: "add-image")
    }
    
    @IBAction func captionFieldEntered(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
}

extension ForumsScreenVC: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
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

}







