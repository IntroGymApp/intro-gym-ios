//
//  ExerciseDescriptionViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 28.05.2024.
//

import UIKit

protocol ExerciseDescriptionViewControllerDelegate: AnyObject {
    func getWorkoutId() -> Int64
}

class ExerciseDescriptionViewController: UIViewController {
    
    weak var delegate: ExerciseDescriptionViewControllerDelegate?
    var exerciseInfo: ExerciseInfoEntity!
    var shouldShowAddButton: Bool = false
    
    private lazy var exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "large-" + (exerciseInfo.img ?? ""))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExerciseInfoById()
        configureView()
        setupLayout()
    }
    
    private func getExerciseInfoById() {
        let exerciseInfoId = exerciseInfo.id
        if let fetchedExerciseInfo = CoreDataManager.shared.getExerciseInfoById(id: exerciseInfoId) {
            exerciseInfo = fetchedExerciseInfo
        }
    }
    
    private func configureView() {
        navigationController?.navigationBar.tintColor = .main
        if shouldShowAddButton {
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
            navigationItem.rightBarButtonItem = addButton
        }
        
        view.backgroundColor = .background
        navigationItem.title = exerciseInfo.name
    }
    
    private func setupLayout() {
        let exerciseDescription = Factory.createHeaderWithText(header: exerciseInfo.name, text: exerciseInfo.descr ?? "nil")
        let exercisePreparation = Factory.createHeaderWithText(header: "Подготовка", text: exerciseInfo.preparation ?? "nil")
        let exerciseManual = Factory.createHeaderWithText(header: "Выполнение", text: exerciseInfo.execution ?? "nil")
        let exerciseRecommendations = Factory.createHeaderWithText(header: "Советы", text: exerciseInfo.advices ?? "nil")
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(exerciseImage)
        contentView.addSubview(exerciseDescription)
        contentView.addSubview(exercisePreparation)
        contentView.addSubview(exerciseManual)
        contentView.addSubview(exerciseRecommendations)
        
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
            
            exerciseDescription.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: 30),
            exerciseDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exercisePreparation.topAnchor.constraint(equalTo: exerciseDescription.bottomAnchor, constant: 25),
            exercisePreparation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exercisePreparation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exerciseManual.topAnchor.constraint(equalTo: exercisePreparation.bottomAnchor, constant: 25),
            exerciseManual.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseManual.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exerciseRecommendations.topAnchor.constraint(equalTo: exerciseManual.bottomAnchor, constant: 25),
            exerciseRecommendations.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exerciseRecommendations.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            exerciseRecommendations.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func didTapAddButton() {
        guard let workoutId = delegate?.getWorkoutId() else { 
            print("Failed to get workout id")
            return
        }
        CoreDataManager.shared.createExercise(workoutId: workoutId, name: exerciseInfo.name, exerciseInfoId: exerciseInfo.id, note: "nil")
        
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let editWorkoutVC = viewController as? EditWorkoutViewController {
                    navigationController.popToViewController(editWorkoutVC, animated: true)
                    return
                }
            }
        }
    }

}
