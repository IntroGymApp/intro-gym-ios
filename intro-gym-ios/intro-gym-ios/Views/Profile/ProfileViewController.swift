//
//  ProfileViewController.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 08.05.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    let mainDataHeader = Factory.createHeader(text: "Основные данные")
    let name = Factory.createFieldWithName(name: "Имя", nameData: "Максим")
    let gender = Factory.createFieldWithName(name: "Пол", nameData: "Мужской")
    let height = Factory.createFieldWithName(name: "Рост", nameData: "176")
    let weight = Factory.createFieldWithName(name: "Вес", nameData: "60")
    
    let calcHeader = Factory.createHeader(text: "Калькуляторы")
    let calcSection = Factory.createCalcViews()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    
    private let mainDataContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let calcContainerView: UIView = {
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
        view.addSubview(stack)
        
        stack.addArrangedSubview(mainDataContainerView)
        mainDataContainerView.addSubview(mainDataHeader)
        mainDataContainerView.addSubview(name)
        mainDataContainerView.addSubview(gender)
        mainDataContainerView.addSubview(height)
        mainDataContainerView.addSubview(weight)
        
        stack.addArrangedSubview(calcContainerView)
        calcContainerView.addSubview(calcHeader)
        calcContainerView.addSubview(calcSection)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainDataHeader.topAnchor.constraint(equalTo: stack.topAnchor),
            mainDataHeader.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            name.topAnchor.constraint(equalTo: mainDataHeader.bottomAnchor, constant: 15),
            name.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            gender.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30),
            gender.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            height.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 30),
            height.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            weight.topAnchor.constraint(equalTo: height.bottomAnchor, constant: 30),
            weight.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            weight.bottomAnchor.constraint(equalTo: mainDataContainerView.bottomAnchor),
            
            calcHeader.topAnchor.constraint(equalTo: calcContainerView.topAnchor),
            calcHeader.leadingAnchor.constraint(equalTo: calcContainerView.leadingAnchor),
            
            calcSection.topAnchor.constraint(equalTo: calcHeader.bottomAnchor, constant: 15),
            calcSection.leadingAnchor.constraint(equalTo: calcContainerView.leadingAnchor),
            calcSection.trailingAnchor.constraint(equalTo: calcContainerView.trailingAnchor),
            calcSection.heightAnchor.constraint(equalToConstant: 168),
            calcSection.bottomAnchor.constraint(equalTo: calcContainerView.bottomAnchor)
        ])
    }
}

