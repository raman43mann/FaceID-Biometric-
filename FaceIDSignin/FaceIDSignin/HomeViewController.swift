//
//  HomeViewController.swift
//  FaceIDSignin
//
//  Created by Ramanjeet Singh on 27/06/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func logoutAction(_ sender: Any) {
        let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        sceneDelegate?.isBioMetricLogedIn = false
        sceneDelegate?.setupLoginScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 

}
