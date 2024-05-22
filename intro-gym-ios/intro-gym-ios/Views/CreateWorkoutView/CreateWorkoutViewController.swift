//
//  CreateWorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 22.05.2024.
//

import UIKit

class CreateWorkoutViewController: UIViewController {
    
    private var excersicesTableView: UITableView!
    
    private let workoutNameField = Factory.createHeaderWithField(header: "Название тренировки", fieldPlaceholder: "Введите название...")
    private let workoutDescriptionField = Factory.createHeaderWithField(header: "Описание тренировки", fieldPlaceholder: "Введите описание...")
    private let tableViewHeader = Factory.createHeader(text: "Ваши упражнения")
    private let addExcersiceButton = Factory.createButton(title: "Добавить упражнение", type: .stroke)
    private let saveWorkoutButton = Factory.createButton(title: "Сохранить", type: .fill)
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 40
        return stack
    }()
    
    private lazy var stackButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewConfigure()
        createTable()
        setupLayout()
    }
    
    private func viewConfigure() {
        navigationItem.title = "Тренировка"
        navigationController?.navigationBar.tintColor = .main
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .background
    }
    
    private func createTable() {
        excersicesTableView = UITableView(frame: .zero)
        excersicesTableView.translatesAutoresizingMaskIntoConstraints = false
        excersicesTableView.register(CustomExerciseCell.self, forCellReuseIdentifier: "ExcersiceCell")
        excersicesTableView.delegate = self
        excersicesTableView.dataSource = self
        excersicesTableView.separatorStyle = .none
        excersicesTableView.backgroundColor = .clear
        excersicesTableView.rowHeight = 78
    }
    
    private func setupLayout() {
        stack.addArrangedSubview(workoutNameField)
        stack.addArrangedSubview(workoutDescriptionField)
        
        stackButtons.addArrangedSubview(addExcersiceButton)
        stackButtons.addArrangedSubview(saveWorkoutButton)
        
        view.addSubview(stack)
        view.addSubview(stackButtons)
        view.addSubview(tableViewHeader)
        view.addSubview(excersicesTableView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableViewHeader.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 40),
            tableViewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            excersicesTableView.topAnchor.constraint(equalTo: tableViewHeader.bottomAnchor, constant: 20),
            excersicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            excersicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            excersicesTableView.bottomAnchor.constraint(equalTo: addExcersiceButton.topAnchor, constant: -20),
            
            stackButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveWorkoutButton.leadingAnchor.constraint(equalTo: stackButtons.leadingAnchor),
            saveWorkoutButton.trailingAnchor.constraint(equalTo: stackButtons.trailingAnchor),
            
            addExcersiceButton.leadingAnchor.constraint(equalTo: stackButtons.leadingAnchor),
            addExcersiceButton.trailingAnchor.constraint(equalTo: stackButtons.trailingAnchor),
        ])
        
    }

}

extension CreateWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
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
