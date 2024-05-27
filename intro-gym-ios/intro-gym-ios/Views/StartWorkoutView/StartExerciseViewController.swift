//
//  StartExerciseViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 25.05.2024.
//

import UIKit

class StartExerciseViewController: UIViewController {
    
    private var exerciseNoteTableView: UITableView!
    
    private var exerciseDescription = Factory.createHeaderWithText(header: "Ваш комментарий", text: "Какой-то комментарий пользователя. Какой-то комментарий пользователя. Какой-то комментарий пользователя. Какой-то комментарий пользователя. Какой-то комментарий пользователя. Какой-то комментарий пользователя")
    private var planView = Factory.createPlanView(approachesValue: 5, approachesValueDone: 0, repetitionsValue: 6, weightValue: 60)
    private var exerciseNoteFields = Factory.createExerciseNoteFileds()
    
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
        image.image = UIImage(named: "ExerciseLargeExample")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        createTable()
        setupLayout()
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
        view.backgroundColor = .background
        navigationItem.title = "Становая тяга"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info"), style: .done, target: self, action: #selector(showInfo))
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
            exerciseNoteTableView.heightAnchor.constraint(equalToConstant: (exerciseNoteTableView.rowHeight + 10) * CGFloat(exerciseNoteTableView.numberOfSections))
        ])
    }
    
    @objc private func showInfo() {
        
    }

}

extension StartExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseNote", for: indexPath) as! ExerciseNoteTableViewCell
        cell.configure(count: indexPath.section + 1, repeats: 5, weight: 60)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
