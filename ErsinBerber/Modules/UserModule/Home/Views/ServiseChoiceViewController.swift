//
//  ServiseChoiceViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 11.12.2024.
//

import UIKit

class ServiseChoiceViewController: UIViewController {
    
    private var selectedServiceView: ServiceOptionsView?
    var barber: Barber?
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hizmet Seçiniz"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    let hairAndBread = ServiceOptionsView(service: "SAÇ SAKAL KESİMİ", duration: "60 dk", price: "500 ₺")
    let hair = ServiceOptionsView(service: "SAÇ TIRAŞI", duration: "45 dk", price: "400 ₺")
    let bread = ServiceOptionsView(service: "SAKAL TIRAŞI", duration: "30 dk", price: "200 ₺")
    
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

        view.backgroundColor = .black
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        navigationItem.title = "Ersin Hair Studio"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        [hairAndBread, hair, bread].forEach { priceView in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePriceViewTap(_:)))
            priceView.addGestureRecognizer(tapGesture)
        }
        print(self.barber?.name)
        
        setupUI()
    }
    
    
    func setupUI() {
        
        let width = view.frame.width
        let height = view.frame.height
        view.addSubview(subtitleLabel)
        subtitleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width * 0.9, height: 40)
        
        view.addSubview(hairAndBread)
        hairAndBread.frame = CGRect(x: width * 0.05, y: subtitleLabel.frame.maxY + 10, width: width * 0.9, height: height * 0.1)
        
        view.addSubview(hair)
        hair.frame = CGRect(x: width * 0.05, y: hairAndBread.frame.maxY + 12, width: width * 0.9, height: height * 0.1)
        
        view.addSubview(bread)
        bread.frame = CGRect(x: width * 0.05, y: hair.frame.maxY + 12, width: width * 0.9, height: height * 0.1)
        
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.frame = CGRect(x: width * 0.05, y: bread.frame.maxY + 15, width: width * 0.9, height: 55)
    }
    
    
    @objc private func handlePriceViewTap(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view as? ServiceOptionsView else { return }
        
        selectedServiceView?.isSelected = false
        
        tappedView.isSelected = true
        selectedServiceView = tappedView
    }
    
    
    @objc func didTapContinue() {
        guard let barber = barber, selectedServiceView != nil else {
            self.makeAlert(title: "Upps 🧐", message: "Hizmet seçimi yapmayı unuttun.")
            return
        }
        let destinationVC = CreateAppointmentViewController(barber: barber)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "TAMAM", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
