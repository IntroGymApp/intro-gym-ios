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
    
}
