//
//  DataService.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 3/18/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference() //contains URL of the root of the Database: grabbed from Plist

class DataService
{
    static let ds = DataService() //Creates singleton class: static, globally accessible
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts") //contains base URL /posts
    private var _REF_USERS = DB_BASE.child("Users") //contains base URL /Users
    
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
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>)
    {
        REF_USERS.child(uid).updateChildValues(userData) //Note: if this child of users does not exist, it will be created
        
    }
    
}



