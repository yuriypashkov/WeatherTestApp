//
//  AppDelegate.swift
//  WeatherTestApp
//
//  Created by Yuriy Pashkov on 04.06.2024.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // get api key
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keys: NSDictionary = NSDictionary(contentsOfFile: path),
            let key = keys["apiKey"] as? String {
                Constants.apiKey = key
        }
        
        return true
    }
    
}
