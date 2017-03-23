//
//  DataService.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/18/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference() //contains URL of the root of the Database: grabbed from Plist
let STORAGE_BASE = FIRStorage.storage().reference() //contains base URL for storage

class DataService
{
    static let ds = DataService() //Creates singleton class: static, globally accessible
    
    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts") //contains base URL /posts
    private var _REF_USERS = DB_BASE.child("Users") //contains base URL /Users
    
    // Storage references
    private var _STORAGE_IMG_POSTS = STORAGE_BASE.child("post-pics") //contains /post-pics/
    
    var REF_BASE: FIRDatabaseReference
    {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference
    {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference
    {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference
    {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        if let userRef = uid
        {
            let userRef = REF_USERS.child(userRef)
            return userRef
        }
        return FIRDatabaseReference()
    }
    
    var STORAGE_IMG_POSTS: FIRStorageReference
    {
        return _STORAGE_IMG_POSTS
    }
    
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>)
    {
        REF_USERS.child(uid).updateChildValues(userData) //Note: if this child of users does not exist, it will be created
        
    }
    
}



