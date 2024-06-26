//
//  WorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    var workouts: [WorkoutEntity] = []
    
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

        configureView()
        createTable()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllWorkouts()
    }
    
    private func getAllWorkouts() {
        if let fetchedWorkouts = CoreDataManager.shared.getAllWorkouts() {
            workouts = fetchedWorkouts.filter { $0.date == nil }
            createdWorkoutsTableView.reloadData()
        }
    }
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        view.backgroundColor = .background
        navigationItem.title = "Ваши тренировки"
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
        let editWorkoutVC = EditWorkoutViewController()
        editWorkoutVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(editWorkoutVC, animated: true)
    }

}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = createdWorkoutsTableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! CustomWorkoutCell
        
        let workout = workouts[indexPath.section]
        let exercises = workout.exercise?.allObjects as? [ExerciseEntity]
        let exercisesCount = exercises?.count
        
        cell.configure(with: workout.name,
                       descr: nil,
                       examplesCount: exercisesCount,
                       backgroundImage: nil)
        
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(named: "arrow-right")
        arrowImage.tintColor = .main
        cell.contentView.addSubview(arrowImage)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editWorkoutVC = EditWorkoutViewController()
        editWorkoutVC.hidesBottomBarWhenPushed = true
        editWorkoutVC.workout = workouts[indexPath.section]
        navigationController?.pushViewController(editWorkoutVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { action, view, complectionHandler in
            let workoutToDelete = self.workouts[indexPath.section]
            CoreDataManager.shared.deleteWorkout(workout: workoutToDelete)
            self.getAllWorkouts()
            complectionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
