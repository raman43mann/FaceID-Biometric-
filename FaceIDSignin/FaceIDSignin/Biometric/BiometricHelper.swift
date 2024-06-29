//
//  File.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import Foundation
import UIKit

class BiometricHelper {
    static let shared = BiometricHelper()

    private init() {} // Prevents others from using the default initializer
    
    
   static func showAuthenticationAlert(type: AuthenticationAlert,completion: (()->Void)? = nil) {
       if let topController = BiometricHelper.shared.topMostViewController() {
            let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { action in
                completion?()
            }
            alert.addAction(action)
            topController.present(alert, animated: true)
        }
    }
    
    

    func topMostViewController() -> UIViewController? {
        // Attempt to find the key window that's in the foreground and visible
        var visibleWindow: UIWindow?
        for windowScene in UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }) {
            for window in windowScene.windows where window.isKeyWindow && window.isHidden == false {
                visibleWindow = window
                break
            }
        }
        
        // Fallback to older method if no visible key window is found
        if visibleWindow == nil {
            for window in UIApplication.shared.windows where window.isKeyWindow && window.isHidden == false {
                visibleWindow = window
                break
            }
        }
        
        // Traverse the view controller hierarchy to find the top-most view controller
        var topController = visibleWindow?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
}
