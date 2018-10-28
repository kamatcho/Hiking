//
//  APIToken.swift
//  Hiking
//
//  Created by MOHAMED on 3/21/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
class ApiToken {
    class func restartApp(){
        guard let window =  UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc :UIViewController
        if getApiToken() == nil {
            // Skip Auth Screen
            vc = sb.instantiateInitialViewController()!
        }else{
            vc = sb.instantiateViewController(withIdentifier: "BuildingView")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    
    class func setApiToken(Token : String)  {
        let api_token = UserDefaults.standard
        api_token.set(Token, forKey: "api_token")
        api_token.synchronize()
        restartApp()
    }
    
    class func getApiToken() -> String? {
        let api_token = UserDefaults.standard
        let obj =  api_token.object(forKey: "api_token")
        return obj as? String
    }
    
}
