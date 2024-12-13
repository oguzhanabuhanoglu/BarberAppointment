//
//  ChooseArtistViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit
import FirebaseAuth

class ChooseArtistViewController: UIViewController {
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Berberin Kim ?"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let artist1 = BarberView(image: UIImage(named: "me")!, name: "Ersin Güven")
    private let artist2 = BarberView(image: UIImage(named: "me")!, name: "Micheal Scolfield")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        navigationItem.title = "Ersin Hair Studio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let logOutButton = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(didTapLogOut))
        logOutButton.tintColor = .mainYellow
        navigationItem.rightBarButtonItem = logOutButton
        
        setupUI()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(didTapErsin))
        artist1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(didTapPrisoner))
        artist2.addGestureRecognizer(tap2)
    }
    
    @objc func didTapErsin() {
        let destinationVC = ServiseChoiceViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func didTapPrisoner() {
        let destinationVC = ServiseChoiceViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @objc func didTapLogOut() {
        try? Auth.auth().signOut()
        
        let destinationVC = FirstViewController()
        let nav = UINavigationController(rootViewController: destinationVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    func setupUI() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(subtitleLabel)
        subtitleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width * 0.9, height: 40)
        
        artist1.frame = CGRect(x: width * 0.1, y: subtitleLabel.frame.maxY + 20, width: width * 0.35, height: width * 0.35)
        artist1.layer.cornerRadius = 8
        view.addSubview(artist1)
        
        artist2.frame = CGRect(x: width * 0.55, y: subtitleLabel.frame.maxY + 20, width: width * 0.35, height: width * 0.35)
        artist2.layer.cornerRadius = 8
        view.addSubview(artist2)
    }
    

   

}
