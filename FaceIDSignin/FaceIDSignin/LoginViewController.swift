//
//  ViewController.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnBiometric: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Config function
        configBioMetric()
       
    }

    
    func configBioMetric(){
        switch BiometricManager.checkBiometricType()
        {
        case .none:
            btnBiometric.isHidden = true
        case .touchID:
            btnBiometric.isHidden = false
            btnBiometric.setImage(UIImage(named: "ic_finger"), for: .normal)
        case .faceID:
            btnBiometric.isHidden = false
            btnBiometric.setImage(UIImage(named: "ic_face"), for: .normal)
        case .opticID:
            btnBiometric.isHidden = true
        @unknown default:
            btnBiometric.isHidden = true
        }
    }
    
    @IBAction func btnBiometricAction(_ sender: UIButton) {
        BiometricManager.shared.authenticateUser(){
            let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
            sceneDelegate?.isBioMetricLogedIn = true
            sceneDelegate?.setupLoginScreen()
        }
    }
    
}

