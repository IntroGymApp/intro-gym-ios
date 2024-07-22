//
//  StartExerciseViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 25.05.2024.
//

import UIKit

protocol StartExerciseViewControllerDelegate: AnyObject {
    func getExerciseId() -> Int64
    func getExerciseImg() -> String
}

class StartExerciseViewController: UIViewController {
    
    var exercise = ExerciseEntity()
    var exerciseInfo: ExerciseInfoEntity?
    var exerciseInfoImg = ""
    var exerciseHistory: [ExerciseHistoryEntity] = []
    weak var delegate: StartExerciseViewControllerDelegate?
    var reps = -1
    var weight = -1
    
    private var exerciseNoteTableView: UITableView!
    private var exerciseNoteFields: UIView!
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExercise()
        createTable()
        getExerciseHistory()
        setupLayout()
        hideKeyboardWhenTappedAround()
    }
    
    private func getExercise() {
        guard let exerciseId = delegate?.getExerciseId() else { return }
        if let fetchedExercise = CoreDataManager.shared.getExerciseById(id: exerciseId) {
            exercise = fetchedExercise
        }
    }
    
    private func getExerciseHistory() {
        if let fetchedExerciseHistory = CoreDataManager.shared.getAllExerciseHistoryByExerciseId(exerciseId: exercise.id) {
            exerciseHistory = fetchedExerciseHistory
            exerciseNoteTableView.reloadData()
//            updateTableHeight()
        }
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func createTable() {
        exerciseNoteTableView = UITableView(frame: .zero)
        exerciseNoteTableView.translatesAutoresizingMaskIntoConstraints = false
        exerciseNoteTableView.register(ExerciseNoteTableViewCell.self, forCellReuseIdentifier: "ExerciseNote")
        exerciseNoteTableView.delegate = self
        exerciseNoteTableView.dataSource = self
        exerciseNoteTableView.rowHeight = 35
        exerciseNoteTableView.separatorStyle = .none
        exerciseNoteTableView.backgroundColor = .clear
        exerciseNoteTableView.isScrollEnabled = false
    }
    
    private func setupLayout() {
        exerciseNoteFields = Factory.createExerciseNoteFileds(repsFieldTag: 1, weightFieldTag: 2, buttonTag: 3)
        
        let exerciseInfoId = exercise.exerciseInfoId
        exerciseInfo = CoreDataManager.shared.getExerciseInfoById(id: exerciseInfoId)
        
        exerciseInfoImg = exerciseInfo?.img ?? ""
        exerciseImage.image = UIImage(named: "large-" + exerciseInfoImg)
        
        let exerciseDescription = Factory.createHeaderWithText(header: "Ваш комментарий", text: exercise.note ?? "nil")
        let planView = Factory.createPlanView(approachesValue: Int(exercise.sets), approachesValueDone: exerciseHistory.count, repetitionsValue: Int(exercise.reps), weightValue: Int(exercise.weight))
        
        let addButton = exerciseNoteFields.viewWithTag(3) as? UIButton
        addButton?.addTarget(self, action: #selector(addSet), for: .touchUpInside)
        
        view.backgroundColor = .background
        navigationItem.title = exercise.name
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .done, target: self, action: #selector(showInfo))
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(exerciseImage)
        contentView.addSubview(exerciseDescription)
        contentView.addSubview(planView)
        contentView.addSubview(exerciseNoteFields)
        contentView.addSubview(exerciseNoteTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            exerciseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            exerciseImage.heightAnchor.constraint(equalToConstant: 200),
            
            exerciseDescription.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: 25),
            exerciseDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            planView.topAnchor.constraint(equalTo: exerciseDescription.bottomAnchor, constant: 25),
            planView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            planView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exerciseNoteFields.topAnchor.constraint(equalTo: planView.bottomAnchor, constant: 25),
            exerciseNoteFields.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseNoteFields.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exerciseNoteTableView.topAnchor.constraint(equalTo: exerciseNoteFields.bottomAnchor, constant: 20),
            exerciseNoteTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseNoteTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            exerciseNoteTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            exerciseNoteTableView.heightAnchor.constraint(equalToConstant: (exerciseNoteTableView.rowHeight + 10) * CGFloat(exerciseHistory.count))
        ])
    }
    
    private func updateTableHeight() {
        let height = (exerciseNoteTableView.rowHeight + 10) * CGFloat(exerciseHistory.count)
        exerciseNoteTableView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = height
            }
        }
        exerciseNoteTableView.layoutIfNeeded()
    }
    
    @objc private func addSet() {
        guard let repsField = exerciseNoteFields.viewWithTag(1) as? UITextField,
              let repsText = repsField.text, !repsText.isEmpty,
              let weightField = exerciseNoteFields.viewWithTag(2) as? UITextField,
              let weightText = weightField.text, !weightText.isEmpty else {
            return
        }
        
        reps = Int(repsText) ?? -1
        weight = Int(weightText) ?? -1
        
        CoreDataManager.shared.addExerciseHistoryByExerciseId(exerciseId: exercise.id, reps: Int64(reps), weight: Int64(weight))
        
        getExerciseHistory()
        updateTableHeight()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func showInfo() {
        
    }

}

extension StartExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exerciseHistory.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseNote", for: indexPath) as! ExerciseNoteTableViewCell
        let exerciseHistoryNote = exerciseHistory[indexPath.section]
        
        cell.configure(count: indexPath.section + 1, repeats: Int(exerciseHistoryNote.reps), weight: Int(exerciseHistoryNote.weight))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
