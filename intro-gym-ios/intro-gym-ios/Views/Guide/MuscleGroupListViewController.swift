//
//  MuscleGroupListViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 24.05.2024.
//

import UIKit

class MuscleGroupListViewController: UIViewController {
    
    private var listMuscleTableView: UITableView!
    private let imagesForCellName = ["breast",
                                     "legs",
                                     "shoulders",
                                     "forearm",
                                     "press",
                                     "arms-biceps",
                                     "arms-triceps",
                                     "back",]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        createTable()
        setupLayout()
    }
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationItem.title = "Упражнения"
        navigationController?.navigationBar.tintColor = .main
        
        view.backgroundColor = .background
    }
    
    private func createTable() {
        listMuscleTableView = UITableView(frame: .zero)
        listMuscleTableView.translatesAutoresizingMaskIntoConstraints = false
        listMuscleTableView.register(CustomWorkoutCell.self, forCellReuseIdentifier: "ExcersiceCell")
        listMuscleTableView.delegate = self
        listMuscleTableView.dataSource = self
        listMuscleTableView.rowHeight = 78
        listMuscleTableView.separatorStyle = .none
        listMuscleTableView.backgroundColor = .clear
    }
    
    private func setupLayout() {
        view.addSubview(listMuscleTableView)
        
        NSLayoutConstraint.activate([
            listMuscleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listMuscleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listMuscleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listMuscleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension MuscleGroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExcersiceCell", for: indexPath) as! CustomWorkoutCell
        cell.configure(with: "Грудь", 
                       descr: nil,
                       examplesCount: "Упражнений: 4",
                       backgroundImage: nil)
        
        let image: UIImage = UIImage(named: imagesForCellName[indexPath.section]) ?? UIImage()
        let muscleGroupImage = UIImageView(image: image)
        muscleGroupImage.translatesAutoresizingMaskIntoConstraints = false
        muscleGroupImage.layer.cornerRadius = 6
        muscleGroupImage.clipsToBounds = true
        cell.contentView.addSubview(muscleGroupImage)
        
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(named: "arrow")
        arrowImage.tintColor = .main
        cell.contentView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            muscleGroupImage.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            muscleGroupImage.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 28),
            muscleGroupImage.widthAnchor.constraint(equalToConstant: 58),
            muscleGroupImage.heightAnchor.constraint(equalToConstant: 58),
            
            cell.workoutTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 20),
            cell.workoutTitle.leadingAnchor.constraint(equalTo: muscleGroupImage.trailingAnchor, constant: 18),
            
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
        let exerciseGroupListVC = ExerciseListViewController()
        navigationController?.pushViewController(exerciseGroupListVC, animated: true)
    }
    
}
