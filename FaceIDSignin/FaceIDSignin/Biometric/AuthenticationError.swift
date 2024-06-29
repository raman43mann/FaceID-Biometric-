//
//  AuthenticationError.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import Foundation

enum AuthenticationAlert {
    case success
    case authenticationFailed
    case userCancel
    case userFallback
    case biometryNotAvailable
    case biometryNotEnrolled
    case biometryLockout
    case unknownError
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .authenticationFailed, .userCancel, .userFallback, .biometryNotAvailable, .biometryNotEnrolled, .biometryLockout, .unknownError:
            return "Authentication Error"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "Authentication successful!"
        case .authenticationFailed:
            return "There was a problem verifying your identity."
        case .userCancel:
            return "You pressed cancel."
        case .userFallback:
            return "You pressed password."
        case .biometryNotAvailable:
            return "Face ID/Touch ID is not available."
        case .biometryNotEnrolled:
            return "Face ID/Touch ID is not set up."
        case .biometryLockout:
            return "Face ID/Touch ID is locked."
        case .unknownError:
            return "An unexpected error occurred."
        }
    }
}
