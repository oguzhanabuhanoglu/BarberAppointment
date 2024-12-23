//
//  MainViewController.swift
//  
//
//  Created by Oğuzhan Abuhanoğlu on 12.12.2024.
//

import UIKit
import Combine
import FirebaseAuth

class BarberDashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Components
    private var viewModel: CreateAppointmentViewModel!
    var barber: Barber
    
    private var calendarCollectionView: UICollectionView!
    private var appointmentsTableView: UITableView = UITableView()
    
    private var dates: [CalendarDate] = []
    private let dateProvider = DateProvider()
    private var selectedDate: Date?
    
    private var appointments: [Appointment] = []
    var filteredAppointments: [Appointment] = []
    private var cancellables = Set<AnyCancellable>()

    
    // MARK: - Lifecycle
    init(barber: Barber) {
        self.barber = barber
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBarberFromLocal()
        setupNavigationBar()
        setupDates()
        subscribeToAppointments()
        setupCollectionView()
        setupTableView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let selectedDate = Date().convertToFormattedDate() else {
            print("dskljfsljkdsadljksdkljgdlk")
            return
        }
        
        filterAppointments(selectedDate: selectedDate)
        print("filtered appo: \(filteredAppointments.count)")
    }
    
    
    private func getBarberFromLocal() {
        if let barber = LocalDataManager.shared.loadBarberFromUserDefaults() {
            print("Barber name: \(barber.name)")
            self.barber = barber
            
            // ViewModel'i barber verisiyle başlat
            self.viewModel = CreateAppointmentViewModel(barberName: barber.name)
        } else {
            print("No barber data found")
        }
    }
    

    private func setupNavigationBar() {
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.title = "Randevularım"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .inline
        
        let logOutButton = UIBarButtonItem(title: "Çıkış Yap", style: .plain, target: self, action: #selector(didTapLogOut))
        logOutButton.tintColor = .mainYellow
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    

    
    // MARK: - COLLECTION VIEW
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendarCollectionView.backgroundColor = .black
        calendarCollectionView.showsHorizontalScrollIndicator = true
        
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
    
        view.addSubview(calendarCollectionView)
        
        calendarCollectionView.frame = CGRect(x: 10, y: 0, width: view.frame.width - 20, height: view.frame.height * 0.25)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        let calendarDate = dates[indexPath.item]
        cell.configure(day: calendarDate.day, weekday: calendarDate.weekday, monthName: calendarDate.monthName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCalendarDate = dates[indexPath.row]
        
        guard let selectedDate = selectedCalendarDate.convertToFormattedDate() else {
            return
        }
        
        self.selectedDate = selectedDate
        filterAppointments(selectedDate: selectedDate)
        appointmentsTableView.reloadData()
        
        print(filteredAppointments.count)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 85)
    }
    
    
    
    
    
    // MARK: - TABLEVIEW
    func setupTableView() {
        
        appointmentsTableView.register(AppointmentsCell.self, forCellReuseIdentifier: AppointmentsCell.identifier)
        
        appointmentsTableView.backgroundColor = .black
        view.addSubview(appointmentsTableView)
        
        appointmentsTableView.frame = CGRect(x: 5, y: calendarCollectionView.frame.maxY + 5, width: view.frame.width - 10, height: view.frame.height * 0.7)
        
        appointmentsTableView.delegate = self
        appointmentsTableView.dataSource = self
                
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentsCell.identifier, for: indexPath) as! AppointmentsCell
        if let name = filteredAppointments[indexPath.row].owner?.name,
           let surname = filteredAppointments[indexPath.row].owner?.surname,
                let service = filteredAppointments[indexPath.row].service,
                    let time = filteredAppointments[indexPath.row].time
        {
            
            cell.configure(clientName: "\(name) \(surname)", service: service, time: time)
            
        } else {
            print("we could not get the appointments infos")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    
    
    // MARK: - DATA FUNCS
    private func setupDates() {
        let today = Date()
        print(today)
        dates = dateProvider.generateDates(startingFrom: today, daysBefore: 0, daysAfter: 30)
    }
    
    
    private func subscribeToAppointments() {
        viewModel.$appointments
            .sink { [weak self] appointments in
                self?.appointments = appointments
                guard let today = Date().convertToFormattedDate() else {
                    print("fgdfgdfhdfgh")
                    return
                }
                self?.filterAppointments(selectedDate: today)
                print("Fetceh appointments Count: \(appointments.count)")
            }
            .store(in: &cancellables)
    }
    
    
    func filterAppointments(selectedDate: Date) {
        filteredAppointments = appointments.filter { appointment in
            print("all appointments: \(appointments.count)")
            guard let appointmentDate = appointment.date?.toDate() else {
                return false
            }
            return Calendar.current.isDate(appointmentDate, inSameDayAs: selectedDate)
        }
        
        appointmentsTableView.reloadData()
        print("filtered appointments: \(filteredAppointments.count)")
    }
    
    
    @objc func didTapLogOut() {
        try? Auth.auth().signOut()
        
        let destinationVC = FirstViewController()
        let nav = UINavigationController(rootViewController: destinationVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
