//
//  FirstViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "firstScreen")
        return imageView
    }()

    private let userSignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("MÜŞTERİ GİRİŞİ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let barberSignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("KUAFÖR GİRİŞİ", for: .normal)
        button.setTitleColor(UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0).cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }
    
    func setupUI() {
        let width = view.frame.width
        let height = view.frame.height
        
        backgroundImage.frame = CGRect(x: 0, y: 0, width: width, height: height * 0.6)
        view.addSubview(backgroundImage)
        
        userSignInButton.frame = CGRect(x: width * 0.1, y: backgroundImage.frame.maxY + height * 0.1, width: width * 0.8, height: 55)
        userSignInButton.addTarget(self, action: #selector(didTapUserSignIn), for: .touchUpInside)
        view.addSubview(userSignInButton)
        
        barberSignInButton.frame = CGRect(x: width * 0.1, y: userSignInButton.frame.maxY + 15, width: width * 0.8, height: 55)
        barberSignInButton.addTarget(self, action: #selector(didTapBarberSignIn), for: .touchUpInside)
        view.addSubview(barberSignInButton)
        
        
        
    }
    
    @objc func didTapUserSignIn() {
        let destinationVC = SignUpViewController()
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
    }
    
    @objc func didTapBarberSignIn() {
        let destinationVC = BarberLogInViewController()
        let navigationController = UINavigationController(rootViewController: destinationVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    

  

}
