//
//  LogInViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 5.12.2024.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UI Components
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Giriş Yap"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    let countryCodeButton : UIButton = {
        let button = UIButton()
        button.setTitle("+90", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor =  UIColor.mainYellow.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor.mainYellow.cgColor
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        textField.placeholder = " Telefon numarınızı giriniz..."
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        textField.textColor = .white
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainYellow
        button.setTitle("GİRİŞ YAP", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let toSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Uygulamada yeniyim ? Kayıt Ol", for: .normal)
        button.setTitleColor(.mainYellow, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let countryCodeTableView = UITableView()
    
    let countryCodes = [
        (name: "United States", code: "+1"),
        (name: "Turkey", code: "+90"),
        (name: "United Kingdom", code: "+44"),
        (name: "Germany", code: "+49"),
        (name: "France", code: "+33"),
        (name: "Japan", code: "+81")
    ]
    
    var selectedCountryCode: String = "+90"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        navigationItem.title = "Ersin Hair Studio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesBackButton = true
        setupUI()
        
    }
    
    // MARK: SETUPUI
    func setupUI() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(subtitleLabel)
        view.addSubview(countryCodeButton)
        view.addSubview(countryCodeTableView)
        view.addSubview(phoneNumberTextField)
        view.addSubview(logInButton)
        view.addSubview(toSignUpButton)
        
        subtitleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width * 0.9, height: 55)
        
        countryCodeButton.frame = CGRect(x: width * 0.05, y: subtitleLabel.frame.maxY + 5, width: 55, height: 55)
        countryCodeButton.addTarget(self, action: #selector(selectCountryCode), for: .touchUpInside)
        
        phoneNumberTextField.frame = CGRect(x: countryCodeButton.frame.maxX + 10, y: subtitleLabel.frame.maxY + 5, width: (width * 0.9) - 65, height: 55)
        phoneNumberTextField.addLeftPadding(5)
        
        logInButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        logInButton.frame = CGRect(x: width * 0.05, y: phoneNumberTextField.frame.maxY + 25, width: width * 0.9, height: 55)
        
        toSignUpButton.frame = CGRect(x: width * 0.05, y: logInButton.frame.maxY + 15, width: width * 0.9, height: 30)
        toSignUpButton.addTarget(self, action: #selector(toSıgnUpClicked), for: .touchUpInside)
        view.addSubview(toSignUpButton)
        
        countryCodeTableView.frame = CGRect(x: width * 0.05, y: countryCodeButton.frame.maxY, width: width * 0.2, height: 200)
        countryCodeTableView.backgroundColor = .black
        countryCodeTableView.delegate = self
        countryCodeTableView.dataSource = self
        countryCodeTableView.isHidden = true
        countryCodeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = countryCodes[indexPath.row].code
        cell.selectionStyle = .none
        return cell
    }

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountryCode = countryCodes[indexPath.row].code
        countryCodeButton.setTitle(selectedCountryCode, for: .normal)
        countryCodeTableView.isHidden = true
    }

   
    @objc private func selectCountryCode() {
        countryCodeTableView.isHidden = !countryCodeTableView.isHidden
        if !countryCodeTableView.isHidden {
                countryCodeTableView.layer.zPosition = 1
            }
    }
    
    @objc func didTapLogin() {
        
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            return
        }
        let fullPhoneNumber = "\(selectedCountryCode)\(phoneNumber)"
        
        DatabaseManager.shared.findUser(with: fullPhoneNumber) { user in
            
            if let user = user {
                AuthManager.shared.sendVerificationCode(phoneNumber: fullPhoneNumber) { success, error in
                    if success {
                        let destinationVC = VerificationViewController()
                        destinationVC.user = user
                        destinationVC.islogin = true
                        destinationVC.modalPresentationStyle = .fullScreen
                        self.present(destinationVC, animated: true)
                    } else {
                        print("Error: \(error ?? "Unknown error")")
                    }
                }
            } else {
                self.makeAlert(title: "Upps 🧐", message: "Bu hesap bulunamadı. Önce kayıt olmanız gerekmektedir.")
            }
         
        }

        
    }
    
    @objc func toSıgnUpClicked() {
        self.dismiss(animated: true)
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "TAMAM", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}
