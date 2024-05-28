//
//  ExerciseDescriptionViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 28.05.2024.
//

import UIKit

class ExerciseDescriptionViewController: UIViewController {
    
    private var exerciseDescription = Factory.createHeaderWithText(
        header: "Жим штанги лежа",
        text: "Комплексное упражнение, которое включает в себя работу нескольких групп мышц. В первую очередь работают большие грудные мышцы, дополнительно передние дельты, трицепсы.")
    
    private var exercisePreparation = Factory.createHeaderWithText(
        header: "Подготовка",
        text: "Лягте на скамью, слегка выгнув спину, образуя естественный изгиб. Штанга должна быть примерно на уровне плеч, ноги крепко упираются в пол, хват чуть шире плеч.")
    
    private var exerciseManual = Factory.createHeaderWithText(
        header: "Инструкция",
        text: "1. Сделайте вдох и медленно опустите штангу до уровня груди\n2. Выжмите штангу и по окончании движения выдохните")
    
    private var exerciseRecommendations = Factory.createHeaderWithText(
        header: "Советы",
        text: "- Градус между руками и корпусом должен быть примерно 45-60\n- Избегайте резких движений")
    
    private lazy var exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ExerciseLargeExample")
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

        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        navigationItem.title = "Грудь"
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

}
