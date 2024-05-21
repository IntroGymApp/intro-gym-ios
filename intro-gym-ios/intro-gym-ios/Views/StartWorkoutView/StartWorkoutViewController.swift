//
//  StartWorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 21.05.2024.
//

import UIKit

class StartWorkoutViewController: UIViewController {

    private var excersicesTableView: UITableView!
    
    private lazy var tableHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ваше описание"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    private lazy var workoutDescrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Какое-то писание, которое пользователь сам написал. Какое-то писание, которое пользователь сам написал. Какое-то писание, которое пользователь сам написал. Какое-то писание, которое пользователь сам написал. Какое-то писание, которое пользователь сам написал. Какое-то писание, которое пользователь сам написал."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .main
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationConfigure()
        createTable()
        setupLayout()
    }
    
    private func navigationConfigure() {
        navigationItem.title = "Тренировка N"
        navigationController?.navigationBar.tintColor = .main
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(didTapEditWorkout))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func createTable() {
        excersicesTableView = UITableView(frame: .zero)
        excersicesTableView.translatesAutoresizingMaskIntoConstraints = false
        excersicesTableView.register(CustomExerciseCell.self, forCellReuseIdentifier: "ExcersiceCell")
        excersicesTableView.delegate = self
        excersicesTableView.dataSource = self
        excersicesTableView.rowHeight = 78
        excersicesTableView.backgroundColor = .clear
        excersicesTableView.separatorStyle = .none
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(excersicesTableView)
        view.addSubview(tableHeader)
        view.addSubview(workoutDescrLabel)
        
        NSLayoutConstraint.activate([
            tableHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            workoutDescrLabel.topAnchor.constraint(equalTo: tableHeader.bottomAnchor, constant: 5),
            workoutDescrLabel.leadingAnchor.constraint(equalTo: tableHeader.leadingAnchor),
            workoutDescrLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            excersicesTableView.topAnchor.constraint(equalTo: workoutDescrLabel.bottomAnchor, constant: 25),
            excersicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            excersicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            excersicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapEditWorkout() {
        
    }

}

extension StartWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExcersiceCell", for: indexPath) as! CustomExerciseCell
        cell.configure(with: "Становая тяга", 
                       approaches: 3,
                       repetitions: 6,
                       weight: 80,
                       image: UIImage(named: "ExcerciseExample"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
