//
//  CreateAppointmentViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit

class CreateAppointmentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: UI COMPONENTS
    var barber: Barber
    let barberInfoView: BarberInfoView
    
    let dateLabel = SubtitleLabel(text: "Müsait Tarihler")
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
    
    let timeLabel = SubtitleLabel(text: "Müsait Saatler")
    private var timesCollectionView: UICollectionView!
    
    let workingHours = ["11.00", "12.00", "13.00", "14.00", "15.00", "16.00", "17.00", "18.00", "19.00", "20.00"]
    
    init(barber: Barber) {
        self.barber = barber
        self.barberInfoView = BarberInfoView(barber: barber)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        addSubviews()
        configureCollectionView()

    }
    
    // MARK: LAYOUTS
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
        
        timesCollectionView.frame = CGRect(x: width * 0.05, y: timeLabel.frame.maxY + 3, width: width * 0.9, height: height * 0.15)
    }
    
    
    // MARK: CollectionView
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
        
        // Register cell
        timesCollectionView.register(TimesCollectionViewCell.self, forCellWithReuseIdentifier: TimesCollectionViewCell.identifier)
        
        view.addSubview(timesCollectionView)
        
        
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
        print("Seçilen saat: \(selectedTime)")
    }

    
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    

}


/*
 
 datePicker.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)

 @objc func didChangeDate() {
     let selectedDate = datePicker.date
     fetchAvailableHours(for: selectedDate)
 }

 */
