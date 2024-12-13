//
//  CreateAppointmentViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit

class CreateAppointmentViewController: UIViewController {
    
    var barber: Barber
    let barberInfoView: BarberInfoView
    
    
    let dateLabel = SubtitleLabel(text: "Müsait Tarihler")
    let timeLabel = SubtitleLabel(text: "Müsait Saatler")
    
    init(barber: Barber) {
        self.barber = barber
        self.barberInfoView = BarberInfoView(barber: barber)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Date()
        picker.tintColor = .white
        picker.overrideUserInterfaceStyle = .dark
        picker.locale = Locale(identifier: "tr_TR")
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0).cgColor
        picker.layer.cornerRadius = 10
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationItem.title = "Randevu Oluştur"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .inline
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        addSubviews()
        
    }
    
    func addSubviews() {
        view.addSubview(barberInfoView)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(timeLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        barberInfoView.frame = CGRect(x: width * 0.05, y: height * 0.12, width: width * 0.9, height: height * 0.17)
        
        dateLabel.frame = CGRect(x: width * 0.04, y: barberInfoView.frame.maxY + 15, width: width * 0.92, height: 35)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        timeLabel.frame = CGRect(x: width * 0.04, y: datePicker.frame.maxY + 10, width: width * 0.92, height: 35)
    }
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    

}
