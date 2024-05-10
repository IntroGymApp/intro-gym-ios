//
//  WorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    private var createdWorkoutsTableView: UITableView!
    
    private lazy var createWorkoutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создать тренировку"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    private lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .main
        button.addTarget(self, action: #selector(createWorkout), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        createTable()
        setupLayout()
    }
    
    private func createTable() {
        createdWorkoutsTableView = UITableView(frame: .zero)
        createdWorkoutsTableView.translatesAutoresizingMaskIntoConstraints = false
        createdWorkoutsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CreatedWorkoutCell")
        createdWorkoutsTableView.dataSource = self
        createdWorkoutsTableView.delegate = self
        createdWorkoutsTableView.rowHeight = 78
        createdWorkoutsTableView.backgroundColor = .clear
        createdWorkoutsTableView.separatorStyle = .none
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(createWorkoutLabel)
        view.addSubview(createWorkoutButton)
        view.addSubview(createdWorkoutsTableView)
        
        NSLayoutConstraint.activate([
            createWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            createWorkoutLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            createWorkoutButton.centerYAnchor.constraint(equalTo: createWorkoutLabel.centerYAnchor),
            createWorkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createWorkoutButton.widthAnchor.constraint(equalToConstant: 20),
            createWorkoutButton.heightAnchor.constraint(equalToConstant: 20),
            
            createdWorkoutsTableView.topAnchor.constraint(equalTo: createWorkoutLabel.bottomAnchor, constant: 25),
            createdWorkoutsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            createdWorkoutsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createdWorkoutsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func createWorkout() {
        
    }

}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatedWorkoutCell", for: indexPath)
        
        let workoutTitle = UILabel()
        workoutTitle.translatesAutoresizingMaskIntoConstraints = false
        workoutTitle.text = "Тренировка 1"
        workoutTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        workoutTitle.textColor = .main
        cell.contentView.addSubview(workoutTitle)
        
        let examplesCount = UILabel()
        examplesCount.translatesAutoresizingMaskIntoConstraints = false
        examplesCount.text = "Упражнений: 2"
        examplesCount.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        examplesCount.textColor = .accent
        cell.contentView.addSubview(examplesCount)
        
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.tintColor = .main
        cell.contentView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
            workoutTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            workoutTitle.widthAnchor.constraint(equalToConstant: 255),
            
            examplesCount.topAnchor.constraint(equalTo: workoutTitle.bottomAnchor, constant: 2),
            examplesCount.leadingAnchor.constraint(equalTo: workoutTitle.leadingAnchor),
            examplesCount.widthAnchor.constraint(equalToConstant: 150),
            
            arrowImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -25),
            arrowImage.widthAnchor.constraint(equalToConstant: 16),
            arrowImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        cell.contentView.backgroundColor = .backgroundBlock
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
