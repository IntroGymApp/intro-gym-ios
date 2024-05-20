//
//  ProfileViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

enum ProfileSections {
    case mainData
    case calc
    case language
}

class ProfileViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        addProfileSections()
    }
    
    private func setupLayout() {
        view.backgroundColor = .background
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func addProfileSections() {
        let mainDataSection = ProfileFieldsFactory.addSection(withHeader: "Основные данные", section: .mainData)
        contentView.addArrangedSubview(mainDataSection)
        
        let calcSection = ProfileFieldsFactory.addSection(withHeader: "Калькуляторы", section: .calc)
        contentView.addArrangedSubview(calcSection)
        
        let languageSection = ProfileFieldsFactory.addSection(withHeader: "Язык", section: .language)
        contentView.addArrangedSubview(languageSection)
    }
}

