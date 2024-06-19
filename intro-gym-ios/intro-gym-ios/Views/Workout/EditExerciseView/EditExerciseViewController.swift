//
//  EditExerciseViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 23.05.2024.
//

import UIKit

protocol EditExerciseViewControllerDelegate: AnyObject {
    func getExercise() -> ExerciseEntity?
    func didUpdateExercise(_ exercise: ExerciseEntity)
}

class EditExerciseViewController: UIViewController {
    
    weak var delegate: EditExerciseViewControllerDelegate?
    var exercise: ExerciseEntity?
    var sets: Int64?
    var reps: Int64?
    var weight: Int64?
    
    private var pickerView: UIPickerView!
    private let saveExerciseButton = Factory.createButton(title: "Сохранить", type: .fill)
    private let exerciseComment = Factory.createHeaderWithField(header: "Комментарий", fieldPlaceholder: "Ваш комментарий...", fieldTag: 1)
    private let approachesLabel = Factory.createTitleForPickerComponent(text: "Подходов")
    private let repetitionsLabel = Factory.createTitleForPickerComponent(text: "Повторений")
    private let weightLabel = Factory.createTitleForPickerComponent(text: "Вес")
    
    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Становая тяга"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .main
        return label
    }()
    
    private lazy var exerciseInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "info"), for: .normal)
        button.tintColor = .main
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalCentering
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercise = delegate?.getExercise()
        createPickerView()
        setupLayout()
    }
    
    private func createPickerView() {
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // set default values
        pickerView.selectRow(Int(exercise?.sets ?? 0), inComponent: 0, animated: true)
        pickerView.selectRow(Int(exercise?.reps ?? 0), inComponent: 1, animated: true)
        pickerView.selectRow(Int(exercise?.weight ?? 0), inComponent: 2, animated: true)
    }
    
    private func setupLayout() {
        if exercise?.note != "nil" {
            let exerciseComment = exerciseComment.viewWithTag(1) as? UITextField
            exerciseComment?.text = exercise?.note
        }
        
        saveExerciseButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        
        view.backgroundColor = .background
        view.addSubview(pageTitle)
        view.addSubview(exerciseInfoButton)
        view.addSubview(stack)
        view.addSubview(pickerView)
        view.addSubview(exerciseComment)
        view.addSubview(saveExerciseButton)
        
        stack.addArrangedSubview(approachesLabel)
        stack.addArrangedSubview(repetitionsLabel)
        stack.addArrangedSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exerciseInfoButton.centerYAnchor.constraint(equalTo: pageTitle.centerYAnchor),
            exerciseInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exerciseInfoButton.widthAnchor.constraint(equalToConstant: 32),
            exerciseInfoButton.heightAnchor.constraint(equalToConstant: 32),
            
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            stack.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor, constant: 30),
            stack.trailingAnchor.constraint(equalTo: pickerView.trailingAnchor, constant: -50),
            
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: stack.topAnchor, constant: 20),
            
            saveExerciseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveExerciseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveExerciseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            exerciseComment.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 30),
            exerciseComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciseComment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func didTapSave() {
        guard let exerciseComment = exerciseComment.viewWithTag(1) as? UITextField,
              let text = exerciseComment.text else {
            print("Не удалось сохранить комментарий")
            return
        }
        
        guard let exercise = exercise else { return }
        
        CoreDataManager.shared.updateExerciseById(id: exercise.id, newSets: sets, newReps: reps, newWeight: weight, newNote: text)
        delegate?.didUpdateExercise(exercise)
        dismiss(animated: true)
    }

}

extension EditExerciseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 20
        case 1: return 50
        case 2: return 500
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(row)"
        case 1: return "\(row)"
        case 2: return "\(row) кг"
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: sets = Int64(row)
        case 1: reps = Int64(row)
        case 2: weight = Int64(row)
        default: return
        }
    }
    
}
