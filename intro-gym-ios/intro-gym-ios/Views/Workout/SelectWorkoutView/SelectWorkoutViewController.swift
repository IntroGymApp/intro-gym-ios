//
//  SelectWorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 20.05.2024.
//

import UIKit

class SelectWorkoutViewController: UIViewController {
    
    var workouts: [WorkoutEntity] = []
    var selectDay: Date?
    
    weak var delegate: MainViewControllerDelegate?
    
    private var workoutsTableView: UITableView!
    
    private lazy var tableHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите тренировку"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationConfigure()
        createTable()
        setupLayout()
        
        print(selectDay ?? "date is nil")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance()
        getAllWorkouts()
    }
    
    private func getAllWorkouts() {
        if let fetchedWorkouts = CoreDataManager.shared.getAllWorkouts() {
            workouts = fetchedWorkouts.filter { $0.date == nil }
            workoutsTableView.reloadData()
        }
    }
    
    private func setupNavigationBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func navigationConfigure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        appearance.shadowColor = .clear
        
        navigationItem.title = "Ваши тренировки"
        navigationController?.navigationBar.tintColor = .main
        
        navigationController?.navigationBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
    }
    
    private func createTable() {
        workoutsTableView = UITableView(frame: .zero)
        workoutsTableView.translatesAutoresizingMaskIntoConstraints = false
        workoutsTableView.register(CustomWorkoutCell.self, forCellReuseIdentifier: "WorkoutCell")
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.backgroundColor = .background
        workoutsTableView.rowHeight = 78
        workoutsTableView.separatorStyle = .none
        
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(workoutsTableView)
        view.addSubview(tableHeader)
        
        NSLayoutConstraint.activate([
            tableHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            workoutsTableView.topAnchor.constraint(equalTo: tableHeader.bottomAnchor, constant: 25),
            workoutsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            workoutsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            workoutsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension SelectWorkoutViewController: MainViewControllerDelegate {
    func addDayToWorkout(day: Date) {
        selectDay = day
    }
    
}

extension SelectWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = workoutsTableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! CustomWorkoutCell
        
        let workout = workouts[indexPath.section]
        let exerciseCount = (workout.exercise as? Set<ExerciseEntity>)?.count ?? 0
        
        cell.configure(with: workout.name,
                       descr: nil,
                       examplesCount: exerciseCount,
                       backgroundImage: nil)
        
        let plusImage = UIImageView(image: UIImage(named: "plus"))
        plusImage.translatesAutoresizingMaskIntoConstraints = false
        plusImage.tintColor = .main
        cell.contentView.addSubview(plusImage)
        
        cell.workoutTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cell.workoutDescr.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        NSLayoutConstraint.activate([
            cell.workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
            cell.workoutTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            
            cell.examplesCount.topAnchor.constraint(equalTo: cell.workoutTitle.bottomAnchor, constant: 3),
            cell.examplesCount.leadingAnchor.constraint(equalTo: cell.workoutTitle.leadingAnchor),
            
            plusImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            plusImage.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -25),
            plusImage.widthAnchor.constraint(equalToConstant: 16),
            plusImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWorkout = workouts[indexPath.section]
        if let selectDay = selectDay {
            CoreDataManager.shared.addWorkoutAtDay(workout: selectedWorkout, date: selectDay)
            navigationController?.popViewController(animated: true)
        } else {
            print("selectDay is nil")
        }
    }
    
}
