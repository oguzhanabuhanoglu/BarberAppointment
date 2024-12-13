//
//  PhoneNumberViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 3.12.2024.
//

import UIKit

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Kayıt Ol"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let nameTextfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkText
        textField.keyboardType = .default
        textField.placeholder = " Adınızı giriniz..."
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor(named: "mainYellow")?.cgColor
        textField.layer.cornerRadius = 8
        textField.textColor = .white
        return textField
    }()
    
    private let surnameTextfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.keyboardType = .default
        textField.placeholder = " Soyadınızı giriniz..."
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor(named: "mainYellow")?.cgColor
        textField.layer.cornerRadius = 8
        textField.textColor = .white
        return textField
    }()
    
    let countryCodeButton : UIButton = {
        let button = UIButton()
        button.setTitle("+90", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor =   UIColor(named: "mainYellow")?.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor(named: "mainYellow")?.cgColor
        textField.layer.cornerRadius = 8
        textField.keyboardType = .numberPad
        textField.placeholder = " Telefon numarınızı giriniz..."
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        textField.textColor = .white
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(named: "mainYellow")
        button.setTitle("KAYIT OL", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let toSignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hesabın var mı? Giriş yap", for: .normal)
        button.setTitleColor(UIColor(named: "mainYellow"), for: .normal)
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
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "btn_close"), style: .plain, target: self, action: #selector(didTapClose))
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton
        
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapClose() {
        self.dismiss(animated: true)
    }
    
    // MARK: SetupUI
    func setupUI() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        titleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width * 0.9, height: 55)
        view.addSubview(titleLabel)
        
        nameTextfield.frame = CGRect(x: width * 0.05, y: titleLabel.frame.maxY + 5, width: width * 0.9, height: 55)
        nameTextfield.addLeftPadding(5)
        view.addSubview(nameTextfield)
        
        surnameTextfield.frame = CGRect(x: width * 0.05, y: nameTextfield.frame.maxY + 15, width: width * 0.9, height: 55)
        surnameTextfield.addLeftPadding(5)
        view.addSubview(surnameTextfield)
        
        
        countryCodeButton.frame = CGRect(x: width * 0.05, y: surnameTextfield.frame.maxY + 15, width: 55, height: 55)
        countryCodeButton.addTarget(self, action: #selector(selectCountryCode), for: .touchUpInside)
        view.addSubview(countryCodeButton)
        
        phoneNumberTextField.frame = CGRect(x: countryCodeButton.frame.maxX + 10, y: surnameTextfield.frame.maxY + 15, width: (width * 0.9) - 65, height: 55)
        phoneNumberTextField.addLeftPadding(5)
        view.addSubview(phoneNumberTextField)
        
        countryCodeTableView.frame = CGRect(x: width * 0.05, y: countryCodeButton.frame.maxY, width: width * 0.2, height: 200)
        countryCodeTableView.backgroundColor = .black
        countryCodeTableView.delegate = self
        countryCodeTableView.dataSource = self
        countryCodeTableView.isHidden = true
        countryCodeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(countryCodeTableView)
    
      
        signUpButton.frame = CGRect(x: width * 0.05, y: height * 0.80, width: width * 0.9, height: 55)
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        toSignInButton.frame = CGRect(x: width * 0.05, y: signUpButton.frame.maxY + 15, width: width * 0.9, height: 30)
        toSignInButton.addTarget(self, action: #selector(toSıgnInClicked), for: .touchUpInside)
        view.addSubview(toSignInButton)
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
    
    @objc func signUpClicked() {
        
        guard let name = nameTextfield.text, !name.isEmpty,
              let surname = surnameTextfield.text, !surname.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            self.createAlert(title: "Upps 🧐", message: "Lütfen bilgi kutucuklarının hepsini doldurduğunuzdan emin olunuz.")
            return
        }
        
        let fullPhoneNumber = "\(selectedCountryCode)\(phoneNumber)"
        print(fullPhoneNumber)
        
        let newUser = User(name: name, surname: surname, phoneNumber: fullPhoneNumber)
        
        DatabaseManager.shared.findUser(with: fullPhoneNumber) { user in
            
            if let user = user {
                self.createAlert(title: "Upps 🧐", message: "Bu numaraya ait bir hesap bulduk (\(user.name)). Lütfen giriş yapma ekranına gidiniz.")
            } else {
                AuthManager.shared.sendVerificationCode(phoneNumber: fullPhoneNumber) { success, error in
                    if success {
                        let destinationVC = VerificationViewController()
                        destinationVC.user = newUser
                        destinationVC.islogin = false
                        destinationVC.modalPresentationStyle = .fullScreen
                        self.present(destinationVC, animated: true)
                    } else {
                        print("Error: \(error ?? "Unknown error")")
                    }
                }

            }
            
        }
    }
    
    @objc func toSıgnInClicked() {
        let destinationVC = LogInViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
