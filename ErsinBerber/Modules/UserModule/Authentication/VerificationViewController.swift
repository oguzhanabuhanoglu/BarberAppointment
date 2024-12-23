//
//  VerificationViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 9.12.2024.
//

import UIKit

class VerificationViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    var islogin: Bool?
    
    // MARK: UI COMPONENTS
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Doğrulama kodunu giriniz"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let number1 = VerificationTextField()
    private let number2 = VerificationTextField()
    private let number3 = VerificationTextField()
    private let number4 = VerificationTextField()
    private let number5 = VerificationTextField()
    private let number6 = VerificationTextField()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(named: "mainYellow")
        button.setTitle("DEVAM ET", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("verification")
        view.backgroundColor = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        navigationItem.title = "Ersin Hair Studio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupUI()
        setupDelegates()
        
    }
    
    // MARK: SETUP UI
    func setupUI() {
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        view.addSubview(subtitleLabel)
        subtitleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width - 20, height: 35)
        
        let fields = [number1, number2, number3, number4, number5, number6]
        for (index, field) in fields.enumerated() {
            view.addSubview(field)
            field.frame = CGRect(x: (width * 0.5) - 175 + CGFloat(index) * 60, y: subtitleLabel.frame.maxY + 10, width: 50, height: 50)
        }
        
        continueButton.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.frame = CGRect(x: width * 0.05, y: number3.frame.maxY + 15, width: width * 0.9, height: 55)
    }
    
    
    // MARK: SETUP DELEGATES
    func setupDelegates() {
        let fields = [number1, number2, number3, number4, number5, number6]
        fields.forEach { $0.delegate = self }
    }
    
    // MARK: FUNCS
    @objc func didTapVerifyButton() {
        print("Verify")
        
        guard let first = number1.text, !first.isEmpty,
              let second = number2.text, !second.isEmpty,
              let third = number3.text, !third.isEmpty,
              let fourth = number4.text, !fourth.isEmpty,
              let fifth = number5.text, !fifth.isEmpty,
              let sixth = number6.text, !sixth.isEmpty else {
            return
        }
        let verificationCode = "\(first)\(second)\(third)\(fourth)\(fifth)\(sixth)"
        print(verificationCode)
        
        guard let user = user, let islogin = islogin else {
            return
        }
        
        AuthManager.shared.verifyUser(isLogin: islogin, user: user, verificationCode: verificationCode) { result in
            switch result {
            case .success(let success):
                UserDefaults.standard.set(user.phoneNumber, forKey: "phoneNumber")
                UserDefaults.standard.set(false, forKey: "isBusinessAccount")
                let destinationVC = BarberChoiceViewController()
                let nav = UINavigationController(rootViewController: destinationVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            case .failure(let failure):
                self.createAlert(title: "Upps bir şeyler ters gitti ⚠️", message: "Yeniden doğrulama kodu alabilirsiniz.")
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if string.isEmpty {
            // Kullanıcı bir karakter sildiğinde
            textField.text = "" // Mevcut alanı temizle
            moveToPreviousField(from: textField)
            return false
        } else if text.count == 0 {
            // Yeni karakter girildiğinde, bir sonraki alana geç
            textField.text = string
            moveToNextField(from: textField)
            return false
        } else {
            moveToNextField(from: textField)
            return false
        }
    }
    
    func moveToNextField(from textField: UITextField) {
        let fields = [number1, number2, number3, number4, number5, number6]
        if let currentIndex = fields.firstIndex(of: textField as! VerificationTextField), currentIndex < fields.count - 1 {
            fields[currentIndex + 1].becomeFirstResponder()
        }
    }
    
    func moveToPreviousField(from textField: UITextField) {
        let fields = [number1, number2, number3, number4, number5, number6]
        if let currentIndex = fields.firstIndex(of: textField as! VerificationTextField), currentIndex > 0 {
            fields[currentIndex - 1].becomeFirstResponder()
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
