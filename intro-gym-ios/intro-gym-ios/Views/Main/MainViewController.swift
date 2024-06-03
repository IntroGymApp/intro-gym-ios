//
//  MainViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class MainViewController: UIViewController {
    
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
        btn.addTarget(self, action: #selector(didTapAddWorkout), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeklyCalendarView = WeeklyCalendarView()
        weeklyCalendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarPresenter = WeeklyCalendarPresenter(delegate: weeklyCalendarView)
        weeklyCalendarView.delegate = calendarPresenter
        
        createTable()
        setupLayout()
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
        navigationController?.pushViewController(selectWorkoutVC, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! CustomWorkoutCell
        cell.configure(with: "Тренировка \(indexPath.section + 1)",
                       descr: "Какое-то писание, которое пользователь сам написал",
                       examplesCount: "Упражнений: 3",
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let startWorkoutVC = StartWorkoutViewController()
        navigationController?.pushViewController(startWorkoutVC, animated: true)
    }


}

