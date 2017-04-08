//
//  AppUtility.swift
//  Overwatch United
//
//  Created by Johnny Nicholson on 4/7/17.
//  Copyright © 2017 Johnny Nicholson. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility
{
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask)
    {
        if let delegate = UIApplication.shared.delegate as? AppDelegate
        {
            delegate.orientationLock = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation)
    {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
}
