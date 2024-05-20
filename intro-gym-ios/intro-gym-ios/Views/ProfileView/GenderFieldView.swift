//
//  GenderSelectionView.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 18.05.2024.
//

import UIKit

class GenderFieldView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let label = ProfileFieldsFactory.createLabelField(text: "Пол")
        addSubview(label)
        
        let maleButton = createGenderButton(imageName: "male")
        addSubview(maleButton)
        
        let femaleButton = createGenderButton(imageName: "female")
        addSubview(femaleButton)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 30),
            
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            maleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            maleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            maleButton.heightAnchor.constraint(equalToConstant: 40),
            maleButton.widthAnchor.constraint(equalToConstant: 40),
            
            femaleButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            femaleButton.leadingAnchor.constraint(equalTo: maleButton.trailingAnchor, constant: 15),
            femaleButton.heightAnchor.constraint(equalToConstant: 40),
            femaleButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func createGenderButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .backgroundBlock
        button.layer.cornerRadius = 6
        button.tintColor = .main
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
            
        return button
    }

}
