//
//  MainViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func addDayToWorkout(day: Date)
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    var workouts: [WorkoutEntity] = []
    var selectDay: Date? {
        didSet {
            if workoutsTableView != nil {
                getAllWorkouts()
            }
        }
    }
    
    private var workoutsTableView: UITableView!
    private var weeklyCalendarView: WeeklyCalendarView!
    private var calendarPresenter: WeeklyCalendarPresenter!
    
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
        label.text = "С возвращением, Максим!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.tintColor = .main
        btn.addTarget(self, action: #selector(didTapAddWorkout), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeklyCalendarView = WeeklyCalendarView()
        weeklyCalendarView.translatesAutoresizingMaskIntoConstraints = false
        weeklyCalendarView.dayDelegate = self
        
        calendarPresenter = WeeklyCalendarPresenter(delegate: weeklyCalendarView, viewDelegate: self)
        weeklyCalendarView.delegate = calendarPresenter
        
        createTable()
        setupLayout()
        
        filterWorkoutsByDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllWorkouts()
    }
    
    private func getAllWorkouts() {
        if let fetchedWorkouts = CoreDataManager.shared.getAllWorkouts() {
            workouts = fetchedWorkouts
            filterWorkoutsByDate()
        }
    }
    
    private func filterWorkoutsByDate() {
        guard let selectedDate = selectDay else {
            workoutsTableView.reloadData()
            return
        }
        
        // Логирование выбранной даты
        print("Selected date: \(selectedDate)")
        
        workouts = workouts.filter { workout in
            if let workoutDate = workout.date {
                let calendar = Calendar.current
                let sameDay = calendar.isDate(workoutDate, inSameDayAs: selectedDate)
                print("Workout date: \(workoutDate), same day: \(sameDay)")
                return sameDay
            }
            return false
        }
        
        workoutsTableView.reloadData()
    }
    
    private func createTable() {
        workoutsTableView = UITableView(frame: .zero)
        workoutsTableView.translatesAutoresizingMaskIntoConstraints = false
        workoutsTableView.register(CustomWorkoutCell.self, forCellReuseIdentifier: "WorkoutCell")
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.rowHeight = 120
        workoutsTableView.backgroundColor = .clear
        workoutsTableView.separatorStyle = .none
    }
    
    private func setupLayout() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        view.backgroundColor = .background
        view.addSubview(weeklyCalendarView)
        view.addSubview(welcomeLabel)
        view.addSubview(welcomeBackUserLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(workoutsTableView)
        
        NSLayoutConstraint.activate([
            weeklyCalendarView.topAnchor.constraint(equalTo: view.topAnchor),
            weeklyCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weeklyCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weeklyCalendarView.heightAnchor.constraint(equalToConstant: 210),
            
            welcomeLabel.topAnchor.constraint(equalTo: weeklyCalendarView.bottomAnchor, constant: 20),
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
    
    @objc private func didTapAddWorkout() {
        let selectWorkoutVC = SelectWorkoutViewController()
        selectWorkoutVC.selectDay = selectDay
        navigationController?.pushViewController(selectWorkoutVC, animated: true)
    }

}

extension MainViewController: WeeklyCalendarViewDayDelegate {
    func didSelectDay(day: Date) {
        selectDay = day
    }
}

extension MainViewController: MainViewControllerDelegate {
    func addDayToWorkout(day: Date) {
        delegate?.addDayToWorkout(day: selectDay ?? Date())
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return workouts.count
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! CustomWorkoutCell
        
        let workout = workouts[indexPath.section]
        let exerciseCount = (workout.exercise as? Set<ExerciseEntity>)?.count ?? 0
        
        cell.configure(with: workout.name,
                       descr: workout.descr,
                       examplesCount: exerciseCount,
                       backgroundImage: UIImage(named: "CellWorkoutBackground"))
        
        NSLayoutConstraint.activate([
            cell.backgroundImageCell.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            cell.backgroundImageCell.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            cell.backgroundImageCell.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            cell.backgroundImageCell.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            
            cell.workoutTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            cell.workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 15),
            
            cell.workoutDescr.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            cell.workoutDescr.topAnchor.constraint(equalTo: cell.workoutTitle.bottomAnchor, constant: 5),
            cell.workoutDescr.widthAnchor.constraint(equalToConstant: 200),
            
            cell.examplesCount.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            cell.examplesCount.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -15)
        ])
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let startWorkoutVC = StartWorkoutViewController()
        startWorkoutVC.workout = workouts[indexPath.section]
        navigationController?.pushViewController(startWorkoutVC, animated: true)
    }
}
