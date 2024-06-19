//
//  StatsViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class StatsViewController: UIViewController {
    
    private lazy var motivationContaionerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundBlock
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var motivationImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "motivation")
        image.tintColor = .accent
        return image
    }()
    
    private lazy var motivationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Федор Емельяненко"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .accent
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var motivationText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "\"Победит не тот, кто сильнее, а тот, кто готов идти до конца\""
        text.font = UIFont.systemFont(ofSize: 14, weight: .light)
        text.textColor = .main
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(motivationContaionerView)
        view.addSubview(motivationImage)
        view.addSubview(motivationTitle)
        view.addSubview(motivationText)
        
        NSLayoutConstraint.activate([
            motivationContaionerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            motivationContaionerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            motivationContaionerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            motivationContaionerView.bottomAnchor.constraint(equalTo: motivationText.bottomAnchor, constant: 30),
            
            motivationImage.topAnchor.constraint(equalTo: motivationContaionerView.topAnchor, constant: 20),
            motivationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            motivationImage.widthAnchor.constraint(equalToConstant: 20),
            motivationImage.heightAnchor.constraint(equalToConstant: 20),
            
            motivationTitle.topAnchor.constraint(equalTo: motivationImage.bottomAnchor, constant: 8),
            motivationTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            motivationTitle.widthAnchor.constraint(equalToConstant: 200),
            
            motivationText.topAnchor.constraint(equalTo: motivationTitle.bottomAnchor, constant: 5),
            motivationText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            motivationText.widthAnchor.constraint(equalToConstant: 300),
        ])
    }

}
