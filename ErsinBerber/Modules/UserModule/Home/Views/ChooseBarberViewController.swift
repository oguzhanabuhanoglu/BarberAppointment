//
//  ChooseArtistViewController.swift
//  ErsinBerber
//
//  Created by Oğuzhan Abuhanoğlu on 4.12.2024.
//

import UIKit
import FirebaseAuth
import Combine

class ChooseBarberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Berberin Kim ?"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var collectionView: UICollectionView!
    
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
    }
    
    func setupUI() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(subtitleLabel)
        subtitleLabel.frame = CGRect(x: width * 0.05, y: height * 0.2, width: width * 0.9, height: 40)
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: subtitleLabel.frame.maxY + 1, width: view.frame.width, height: view.frame.height - 41)
    }
    
    // MARK: CollectionView
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        let size = (view.frame.size.width / 2) - 6
        layout.itemSize = CGSize(width: size, height: size)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register cell
        collectionView.register(BarberCollectionViewCell.self, forCellWithReuseIdentifier: BarberCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        
        viewModel.$barbers
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.barbers.count)
        return viewModel.barbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BarberCollectionViewCell.identifier, for: indexPath) as! BarberCollectionViewCell
        let barber = viewModel.barbers[indexPath.row]
        cell.configure(with: UIImage(named: "me")!, name: "\(barber.name) \(barber.surname)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = ServiseChoiceViewController()
        destinationVC.barber = viewModel.barbers[indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @objc func didTapLogOut() {
        try? Auth.auth().signOut()
        
        let destinationVC = FirstViewController()
        let nav = UINavigationController(rootViewController: destinationVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
