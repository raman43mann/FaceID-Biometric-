//
//  BiometricAuthenticationPopupVC.swift
//  FaceIDSignin
//
//  Created by User on 27/06/24.
//

import UIKit

class BiometricAuthenticationPopup: UIViewController {
    
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        // Load the XIB and replace the view controller's view with it
        if let nibView = Bundle.main.loadNibNamed("BiometricAuthenticationPopup", owner: self, options: nil)?.first as? UIView {
            self.view = nibView
        }
        lblMessage.text = "Tap the biometric button to unlock the app."
    }

    @IBAction func btnBiometric(_ sender: UIButton) {
        BiometricManager.shared.authenticateUser {
            self.dismiss(animated: true)
        }
    }
    
    
}
