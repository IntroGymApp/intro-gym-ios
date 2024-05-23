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
        createdWorkoutsTableView.register(CustomWorkoutCell.self, forCellReuseIdentifier: "WorkoutCell")
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
            createWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
        let createWorkoutVC = CreateWorkoutViewController()
        createWorkoutVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(createWorkoutVC, animated: true)
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
        let cell = createdWorkoutsTableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! CustomWorkoutCell
        cell.configure(with: "Тренировка \(indexPath.section + 1)",
                       descr: nil,
                       examplesCount: "Упражнений: 2",
                       backgroundImage: nil)
        
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.tintColor = .main
        cell.contentView.addSubview(arrowImage)
        
        cell.workoutTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cell.workoutDescr.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            cell.workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
            cell.workoutTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            
            cell.examplesCount.topAnchor.constraint(equalTo: cell.workoutTitle.bottomAnchor, constant: 3),
            cell.examplesCount.leadingAnchor.constraint(equalTo: cell.workoutTitle.leadingAnchor),
            
            arrowImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -25),
            arrowImage.widthAnchor.constraint(equalToConstant: 16),
            arrowImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
