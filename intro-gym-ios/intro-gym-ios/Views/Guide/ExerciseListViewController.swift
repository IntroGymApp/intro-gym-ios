//
//  ExerciseListViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 28.05.2024.
//

import UIKit

class ExerciseListViewController: UIViewController {
    
    weak var delegate: ExerciseDescriptionViewControllerDelegate?
    var exercisesInfo: [ExerciseInfoEntity] = []
    var exericiseGroup = ""
    
    private var listExercisesTableView: UITableView!
    var shouldShowAddButton = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        createTable()
        setupLayout()
        getAllExercisesInfo()
    }
    
    private func getAllExercisesInfo() {
        exercisesInfo = CoreDataManager.shared.getAllExercisesInfoByGroup(group: exericiseGroup)
        listExercisesTableView.reloadData()
    }
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationItem.title = exericiseGroup
        
        view.backgroundColor = .background
    }
    
    private func createTable() {
        listExercisesTableView = UITableView(frame: .zero)
        listExercisesTableView.translatesAutoresizingMaskIntoConstraints = false
        listExercisesTableView.register(CustomWorkoutCell.self, forCellReuseIdentifier: "ExcersiceCell")
        listExercisesTableView.delegate = self
        listExercisesTableView.dataSource = self
        listExercisesTableView.rowHeight = 78
        listExercisesTableView.separatorStyle = .none
        listExercisesTableView.backgroundColor = .clear
    }
    
    private func setupLayout() {
        view.addSubview(listExercisesTableView)
        
        NSLayoutConstraint.activate([
            listExercisesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listExercisesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listExercisesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listExercisesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension ExerciseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercisesInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExcersiceCell", for: indexPath) as! CustomWorkoutCell
        
        let exerciseInfo = exercisesInfo[indexPath.section]
        
        cell.configure(with: exerciseInfo.name,
                       descr: nil,
                       examplesCount: nil,
                       backgroundImage: nil)
        
        let exerciseGroupImage = UIImageView(image: UIImage(named: exerciseInfo.img ?? ""))
        exerciseGroupImage.translatesAutoresizingMaskIntoConstraints = false
        exerciseGroupImage.layer.cornerRadius = 6
        exerciseGroupImage.clipsToBounds = true
        cell.contentView.addSubview(exerciseGroupImage)
        
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(named: "arrow-right")
        arrowImage.tintColor = .main
        cell.contentView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            exerciseGroupImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            exerciseGroupImage.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 28),
            exerciseGroupImage.widthAnchor.constraint(equalToConstant: 58),
            exerciseGroupImage.heightAnchor.constraint(equalToConstant: 58),
            
            cell.workoutTitle.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            cell.workoutTitle.leadingAnchor.constraint(equalTo: exerciseGroupImage.trailingAnchor, constant: 18),
            cell.workoutTitle.widthAnchor.constraint(equalToConstant: 200),
            
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
        let exerciseDescriptionVC = ExerciseDescriptionViewController()
        exerciseDescriptionVC.shouldShowAddButton = shouldShowAddButton
        exerciseDescriptionVC.delegate = delegate
        exerciseDescriptionVC.exerciseInfo = exercisesInfo[indexPath.section]
        navigationController?.pushViewController(exerciseDescriptionVC, animated: true)
    }
    
}
