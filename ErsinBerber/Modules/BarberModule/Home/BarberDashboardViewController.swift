//
//  MainViewController.swift
//  
//
//  Created by Oğuzhan Abuhanoğlu on 12.12.2024.
//

import UIKit
import FirebaseAuth 

class BarberDashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        print("main")
        
        let logOutButton = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(didTapLogOut))
        logOutButton.tintColor = .mainYellow
        navigationItem.rightBarButtonItem = logOutButton
    }
    

    @objc func didTapLogOut() {
        try? Auth.auth().signOut()
        
        let destinationVC = FirstViewController()
        let nav = UINavigationController(rootViewController: destinationVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    

}
