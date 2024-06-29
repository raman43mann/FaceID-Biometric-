//
//  BiometricManager.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import Foundation
import LocalAuthentication
import UIKit

class BiometricManager {
    static let shared = BiometricManager()
    
    
    // Check the type of biometric authentication available on the device
    static func checkBiometricType() -> LABiometryType {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            return context.biometryType
        } else {
            return .none
        }
    }
    
    func authenticateUser(completion:(()->())?=nil) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to proceed"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        BiometricHelper.showAuthenticationAlert(type: .success){
                            completion?()
                        }
                    } else if let laError = authenticationError as? LAError {
                        switch laError.code {
                        case .authenticationFailed:
                            BiometricHelper.showAuthenticationAlert(type: .authenticationFailed)
                        case .userCancel:
                            BiometricHelper.showAuthenticationAlert(type: .userCancel)
                        case .userFallback:
                            BiometricHelper.showAuthenticationAlert(type: .userFallback)
                        case .biometryNotAvailable:
                            BiometricHelper.showAuthenticationAlert(type: .biometryNotAvailable)
                        case .biometryNotEnrolled:
                            BiometricHelper.showAuthenticationAlert(type: .biometryNotEnrolled)
                        case .biometryLockout:
                            BiometricHelper.showAuthenticationAlert(type: .biometryLockout)
                        default:
                            BiometricHelper.showAuthenticationAlert(type: .unknownError)
                        }
                    } else {
                        BiometricHelper.showAuthenticationAlert(type: .unknownError)
                    }
                }
            }
        } else {
            BiometricHelper.showAuthenticationAlert(type: .biometryNotAvailable)
        }
    }
    
    
}
