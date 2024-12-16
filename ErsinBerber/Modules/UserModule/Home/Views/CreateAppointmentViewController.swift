//
//  CreateAppointmentViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit
import FirebaseAuth

class CreateAppointmentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UI COMPONENTS
    let scrollView = UIScrollView()
    
    var barber: Barber
    var newAppointment: Appointment
    private let workingHours = ["11.00", "12.00", "13.00", "14.00", "15.00", "16.00", "17.00", "18.00", "19.00", "20.00"]
    private var selectedDate: Date?
    private var selectedTime: String?
    
    let barberInfoView: BarberInfoView
    
    let dateLabel = SubtitleLabel(text: "Müsait Tarihler")
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Date()
        picker.tintColor = .white
        picker.locale = Locale(identifier: "tr_TR")
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1.0).cgColor
        picker.layer.cornerRadius = 10
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let timeLabel = SubtitleLabel(text: "Müsait Saatler")
    private var timesCollectionView: UICollectionView!
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle("Randevu Al", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .mainYellow
        button.layer.cornerRadius = 8
        return button
    }()

    
    init(barber: Barber, newAppointment: Appointment) {
        self.newAppointment = newAppointment
        self.barber = barber
        self.barberInfoView = BarberInfoView(barber: barber)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addSubviews()
        configureCollectionView()

    }
    
    
    
    // MARK: - Configure navigation bar
    func configureNavigationBar() {
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.title = "Randevu Oluştur"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .inline
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    // MARK: - SetupUI
    func addSubviews() {
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.addSubview(barberInfoView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(datePicker)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(createButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width = view.frame.width
        let height = view.frame.height
        
        barberInfoView.frame = CGRect(x: width * 0.05, y: height * 0.02, width: width * 0.9, height: height * 0.17)
        
        dateLabel.frame = CGRect(x: width * 0.04, y: barberInfoView.frame.maxY + 20, width: width * 0.92, height: 35)
        datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        timeLabel.frame = CGRect(x: width * 0.04, y: datePicker.frame.maxY + 20, width: width * 0.92, height: 35)
        timesCollectionView.frame = CGRect(x: width * 0.05, y: timeLabel.frame.maxY + 3, width: width * 0.9, height: height * 0.1)
        
        createButton.addTarget(self, action: #selector(createAppointment), for: .touchUpInside)
        createButton.frame = CGRect(x: width * 0.05, y: timesCollectionView.frame.maxY + 30, width: width * 0.9, height: 55)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: width, height: createButton.frame.maxY + 20)
        scrollView.backgroundColor = .black
    }
    
    
    // MARK: - CollectionView
    func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        let size = (view.frame.size.width / 5) - 18
        layout.itemSize = CGSize(width: size, height: size / 1.5)
        
        timesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        timesCollectionView.backgroundColor = .black
        timesCollectionView.delegate = self
        timesCollectionView.dataSource = self
        timesCollectionView.dataSource = self
        timesCollectionView.allowsSelection = true
        
        timesCollectionView.register(TimesCollectionViewCell.self, forCellWithReuseIdentifier: TimesCollectionViewCell.identifier)
        
        scrollView.addSubview(timesCollectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workingHours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesCollectionViewCell.identifier, for: indexPath) as! TimesCollectionViewCell
        cell.configure(time: workingHours[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTime = workingHours[indexPath.row]
        self.selectedTime = selectedTime
        print("Seçilen saat: \(selectedTime)")
    }

    // MARK: - Funcs
    
    @objc func didChangeDate() {
        let selectedDate = datePicker.date
        self.selectedDate = selectedDate
        print(selectedDate)
        
       
//        fetchAvailableHours(for: selectedDate)
    }
    
    @objc func createAppointment() {
        print("tapped")
        guard let userPhoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") else {
            print("Failed to find phone number in local")
            return
        }
        
        DatabaseManager.shared.findUser(with: userPhoneNumber) { [self] user in
            guard let user = user else {
                print("Failed find user")
                return
            }
            
            guard let selectedDate = selectedDate,
                  let selectedTime = selectedTime else {
                print("data or time is empty")
                return
            }
            newAppointment.barber = self.barber
            newAppointment.owner = user
            newAppointment.date = selectedDate.toISOString()
            newAppointment.time = selectedTime
            
            // appointment olustur
            DatabaseManager.shared.createAppointment(newAppointment: newAppointment) { success in
                if success {
//                    let destinationVC = VerificationViewController()
//                    destinationVC.modalPresentationStyle = .fullScreen
//                    self.present(destinationVC, animated: true)
                    print("SUCCESFULLY CREATED")
                } else {
                    print("Error: When creating appointment")
                }
            }
            
        }
        
        
    }
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "TAMAM", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    

}


