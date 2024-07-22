//
//  StartWorkoutViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 21.05.2024.
//

import UIKit

class StartWorkoutViewController: UIViewController {
    
    var workout: WorkoutEntity!
    var exercises: [ExerciseEntity] = []
    var exerciseInfo: ExerciseInfoEntity!
    var selectExercise = ExerciseEntity()

    private var excersicesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        createTable()
        setupLayout()
        getAllExersices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarAppearance()
    }
    
    private func getAllExersices() {
        if let workout = workout, let exercisesSet = workout.exercise as? Set<ExerciseEntity> {
            exercises = Array(exercisesSet)
            excersicesTableView.reloadData()
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
    
    private func configureView() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationItem.title = "Тренировка"
        navigationController?.navigationBar.tintColor = .main
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(didTapEditWorkout))
        
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
        let workoutDescription = Factory.createHeaderWithText(header: workout.name, text: workout.descr ?? "nil")
        
        view.backgroundColor = .background
        view.addSubview(workoutDescription)
        view.addSubview(excersicesTableView)
        
        NSLayoutConstraint.activate([
            workoutDescription.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            workoutDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            excersicesTableView.topAnchor.constraint(equalTo: workoutDescription.bottomAnchor, constant: 25),
            excersicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            excersicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            excersicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapEditWorkout() {
        
    }

}

extension StartWorkoutViewController: StartExerciseViewControllerDelegate {
    func getExerciseImg() -> String {
        return exerciseInfo.img ?? ""
    }
    
    func getExerciseId() -> Int64 {
        return selectExercise.id
    }
    
}

extension StartWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExcersiceCell", for: indexPath) as! CustomExerciseCell
        
        let exercise = exercises[indexPath.section]
        let exerciseInfoId = exercises[indexPath.section].exerciseInfoId
        exerciseInfo = CoreDataManager.shared.getExerciseInfoById(id: exerciseInfoId)
        
        cell.configure(with: exercise.name,
                       approaches: Int(exercise.sets),
                       repetitions: Int(exercise.reps),
                       weight: Int(exercise.weight),
                       image: UIImage(named: exerciseInfo?.img ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let startExerciseVC = StartExerciseViewController()
        startExerciseVC.delegate = self
        selectExercise = exercises[indexPath.section]
        navigationController?.pushViewController(startExerciseVC, animated: true)
    }
    
}
