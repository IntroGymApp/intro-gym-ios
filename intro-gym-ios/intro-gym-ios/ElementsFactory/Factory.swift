//
//  Factory.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 22.05.2024.
//

import UIKit

enum ButtonType {
    case fill
    case stroke
}

class Factory {
    
    //MARK: - Views
    static func createHeader(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .main
        return label
    }
    
    static func createField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .main
        textField.backgroundColor = .background
        return textField
    }
    
    static func createButton(title: String, type: ButtonType) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.accent.cgColor
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        switch type {
        case .fill:
            button.setTitleColor(.background, for: .normal)
            button.backgroundColor = .accent
        case .stroke:
            button.setTitleColor(.accent, for: .normal)
            button.backgroundColor = .background
        }
        
        return button
    }
    
    static func createTitleForPickerComponent(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .accent
        return label
    }
    
    static func createExerciseDataTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.backgroundColor = .backgroundBlock
        textField.layer.cornerRadius = 8
        textField.borderStyle = .none
        
        return textField
    }
    
    //MARK: - Constructors of the views
    static func createHeaderWithField(header: String, fieldPlaceholder: String) -> UIView {
        let label = createHeader(text: header)
        let textField = createField(placeholder: fieldPlaceholder)
        
        let superView = UIView()
        superView.translatesAutoresizingMaskIntoConstraints = false
        
        let textFieldBorder = UIView()
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.backgroundColor = .main
        
        superView.addSubview(label)
        superView.addSubview(textFieldBorder)
        superView.addSubview(textField)
        
        NSLayoutConstraint.activate([  
            superView.heightAnchor.constraint(equalToConstant: 60),
            
            label.topAnchor.constraint(equalTo: superView.topAnchor),
            label.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            
            textFieldBorder.heightAnchor.constraint(equalToConstant: 1),
            textFieldBorder.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            textFieldBorder.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textFieldBorder.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
        
        return superView
    }
    
    static func createHeaderWithText(header: String, text: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let header = createHeader(text: header)
        containerView.addSubview(header)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .main
        label.numberOfLines = 0
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: containerView.topAnchor),
            header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            label.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    static func createPlanView(approachesValue: Int, approachesValueDone: Int, repetitionsValue: Int, weightValue: Int) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let header = createHeader(text: "Ваш план")
        containerView.addSubview(header)
        
        let approaches = createPlanItemCard(iconName: "approaches", labelText: "Подходы", labelValue: "\(approachesValueDone) / \(approachesValue)")
        containerView.addSubview(approaches)
        
        let repetition = createPlanItemCard(iconName: "repetitions", labelText: "Повторы", labelValue: String(repetitionsValue))
        containerView.addSubview(repetition)
        
        let weight = createPlanItemCard(iconName: "weight", labelText: "Вес", labelValue: String(weightValue))
        containerView.addSubview(weight)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: containerView.topAnchor),
            header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            approaches.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            approaches.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            approaches.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            repetition.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            repetition.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            repetition.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            weight.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            weight.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            weight.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        return containerView
    }
    
    static func createExerciseNoteFileds() -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.alignment = .center
        containerView.addSubview(stack)
        
        let separatorTop = UIView()
        separatorTop.backgroundColor = .backgroundBlock
        separatorTop.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorTop)
        
        let separatorBottom = UIView()
        separatorBottom.backgroundColor = .backgroundBlock
        separatorBottom.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorBottom)
        
        let repeatsTextView = createExerciseDataTextField(placeholder: "Повторений")
        stack.addArrangedSubview(repeatsTextView)
        
        let weightTextView = createExerciseDataTextField(placeholder: "Килограмм")
        stack.addArrangedSubview(weightTextView)
        
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "plus"), for: .normal)
        addButton.backgroundColor = .accent
        addButton.tintColor = .background
        addButton.layer.cornerRadius = 8
        containerView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            separatorTop.topAnchor.constraint(equalTo: containerView.topAnchor),
            separatorTop.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorTop.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorTop.heightAnchor.constraint(equalToConstant: 1),
            
            repeatsTextView.heightAnchor.constraint(equalToConstant: 40),
            weightTextView.heightAnchor.constraint(equalToConstant: 40),
            
            stack.topAnchor.constraint(equalTo: separatorTop.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -12),
            
            addButton.topAnchor.constraint(equalTo: separatorTop.bottomAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            
            separatorBottom.topAnchor.constraint(equalTo: repeatsTextView.bottomAnchor, constant: 20),
            separatorBottom.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorBottom.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorBottom.heightAnchor.constraint(equalToConstant: 1),
            separatorBottom.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private static func createPlanItemCard(iconName: String, labelText: String, labelValue: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .backgroundBlock
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.accent.cgColor
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 11
        containerView.addSubview(stack)
        
        let iconImage = UIImageView(image: UIImage(named: iconName))
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .scaleAspectFit
        iconImage.clipsToBounds = true
        iconImage.tintColor = .accent
        stack.addArrangedSubview(iconImage)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = labelText
        label.textAlignment = .center
        label.textColor = .main
        stack.addArrangedSubview(label)
        
        let separator = UIView()
        separator.backgroundColor = .background
        separator.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(separator)
        
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        value.text = labelValue
        value.textAlignment = .center
        value.textColor = .main
        stack.addArrangedSubview(value)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 106),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            
            stack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 68),
            
            iconImage.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            label.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            separator.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            value.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
        
        return containerView
    }
    
}
