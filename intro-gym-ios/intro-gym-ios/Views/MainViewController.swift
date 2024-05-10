//
//  MainViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private var workoutsTableView: UITableView!
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рады тебя видеть"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .main
        return label
    }()
    
    private lazy var welcomeBackUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "С возвращением, User.name!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.tintColor = .main
        btn.addTarget(self, action: #selector(addWorkout), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        setupLayout()
    }
    
    private func createTable() {
        workoutsTableView = UITableView(frame: .zero)
        workoutsTableView.translatesAutoresizingMaskIntoConstraints = false
        workoutsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.rowHeight = 120
        workoutsTableView.backgroundColor = .clear
        workoutsTableView.separatorStyle = .none
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(welcomeLabel)
        view.addSubview(welcomeBackUserLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(workoutsTableView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            welcomeBackUserLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            welcomeBackUserLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            addWorkoutButton.topAnchor.constraint(equalTo: welcomeLabel.centerYAnchor),
            addWorkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 20),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 20),
            
            workoutsTableView.topAnchor.constraint(equalTo: welcomeBackUserLabel.bottomAnchor, constant: 25),
            workoutsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            workoutsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            workoutsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addWorkout() {
        
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        
        let backgroundImageCell = UIImageView()
        backgroundImageCell.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageCell.image = UIImage(named: "CellWorkoutBackground")
        backgroundImageCell.contentMode = .scaleAspectFill
        backgroundImageCell.clipsToBounds = true
        cell.contentView.addSubview(backgroundImageCell)
        
        let workoutTitle = UILabel()
        workoutTitle.translatesAutoresizingMaskIntoConstraints = false
        workoutTitle.text = "Тренировка 1"
        workoutTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cell.contentView.addSubview(workoutTitle)
        
        let workoutDescr = UILabel()
        workoutDescr.translatesAutoresizingMaskIntoConstraints = false
        workoutDescr.text = "Какое-то писание, которое пользователь сам написал"
        workoutDescr.numberOfLines = 2
        workoutDescr.font = UIFont.systemFont(ofSize: 14, weight: .light)
        cell.contentView.addSubview(workoutDescr)
        
        let examplesCount = UILabel()
        examplesCount.translatesAutoresizingMaskIntoConstraints = false
        examplesCount.text = "Упражнений: 2"
        examplesCount.font = UIFont.systemFont(ofSize: 14, weight: .light)
        examplesCount.textColor = .accent
        cell.contentView.addSubview(examplesCount)
        
        NSLayoutConstraint.activate([
            backgroundImageCell.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            backgroundImageCell.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            backgroundImageCell.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            backgroundImageCell.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            
            workoutTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 15),
            
            workoutDescr.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            workoutDescr.topAnchor.constraint(equalTo: workoutTitle.bottomAnchor, constant: 5),
            workoutDescr.widthAnchor.constraint(equalToConstant: 200),
            
            examplesCount.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            examplesCount.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -15)
        ])
        
        let backgroundColorCell = UIView()
        backgroundColorCell.backgroundColor = .backgroundBlock
        cell.backgroundView = backgroundColorCell
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }


}

