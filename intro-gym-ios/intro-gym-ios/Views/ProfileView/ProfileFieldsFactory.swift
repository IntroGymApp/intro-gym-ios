//
//  ProfileFieldsFactory.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 18.05.2024.
//

import UIKit

class ProfileFieldsFactory {
    
    // Создание секции
    static func addSection(withHeader header: String, section: ProfileSections) -> UIView {
        let viewSection = UIView()
        viewSection.translatesAutoresizingMaskIntoConstraints = false
        
        let header = createSectionHeader(text: header)
        viewSection.addSubview(header)
        
        var content = UIView()
        switch section {
        case .mainData: content = createMainSection()
        case .calc: content = createCalcSection()
        case .language: content = UIView()
        }
        
        viewSection.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: viewSection.topAnchor),
            header.leadingAnchor.constraint(equalTo: viewSection.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: viewSection.trailingAnchor),
            
            content.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            content.leadingAnchor.constraint(equalTo: viewSection.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: viewSection.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: viewSection.bottomAnchor)
        ])
        
        return viewSection
    }
    
    // Основная секция
    static func createMainSection() -> UIView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 26
        
        let name = createLabelField(text: "Имя")
        let nameTextField = createDataTextField(text: "User.name")
        let nameMainData = createMainDataField(label: name, textField: nameTextField)
        stack.addArrangedSubview(nameMainData)

        let genderMainData = GenderFieldView()
        stack.addArrangedSubview(genderMainData)

        let height = createLabelField(text: "Рост")
        let heightTextField = createDataTextField(text: "User.height")
        let heightMainData = createMainDataField(label: height, textField: heightTextField)
        stack.addArrangedSubview(heightMainData)

        let weight = createLabelField(text: "Вес")
        let weightTextField = createDataTextField(text: "User.weight")
        let weightMainData = createMainDataField(label: weight, textField: weightTextField)
        stack.addArrangedSubview(weightMainData)
        
        return stack
    }
    
    // Секция с калькуляторами
    static func createCalcSection() -> UIView {
        let viewSection = UIView()
        
        let baseCalc = UIView()
        baseCalc.translatesAutoresizingMaskIntoConstraints = false
        baseCalc.backgroundColor = .backgroundBlock
        baseCalc.layer.cornerRadius = 10
        
        let baseCalcImage = UIImageView(image: UIImage(named: "Ccal"))
        baseCalcImage.translatesAutoresizingMaskIntoConstraints = false
        baseCalcImage.contentMode = .scaleAspectFit
        baseCalc.addSubview(baseCalcImage)
        
        let valueCcal = createCalcDataField(count: "2780", unitName: "ккал")
        baseCalc.addSubview(valueCcal)
        
        let valueProtein = createCalcDataField(count: "78", unitName: "белки")
        baseCalc.addSubview(valueProtein)
        
        let valueFat = createCalcDataField(count: "90", unitName: "жиры")
        baseCalc.addSubview(valueFat)
        
        let valueCarb = createCalcDataField(count: "329", unitName: "углеводы")
        baseCalc.addSubview(valueCarb)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        
        let imtCalc = UIView()
        imtCalc.translatesAutoresizingMaskIntoConstraints = false
        imtCalc.backgroundColor = .backgroundBlock
        imtCalc.layer.cornerRadius = 10
        stack.addArrangedSubview(imtCalc)
        
        let imtCalcImage = UIImageView(image: UIImage(named: "IMT"))
        imtCalcImage.translatesAutoresizingMaskIntoConstraints = false
        imtCalcImage.contentMode = .scaleAspectFit
        imtCalc.addSubview(imtCalcImage)
        
        let valueImt = createCalcDataField(count: "25.3", unitName: "ИМТ")
        imtCalc.addSubview(valueImt)
        
        let perfectWeightCalc = UIView()
        perfectWeightCalc.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalc.backgroundColor = .backgroundBlock
        perfectWeightCalc.layer.cornerRadius = 10
        stack.addArrangedSubview(perfectWeightCalc)
        
        let perfectWeightCalcImage = UIImageView(image: UIImage(named: "PerfectWeight"))
        perfectWeightCalcImage.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalcImage.contentMode = .scaleAspectFit
        perfectWeightCalc.addSubview(perfectWeightCalcImage)
        
        let valueWeight = createCalcDataField(count: "70" + " кг", unitName: "идеальный вес")
        perfectWeightCalc.addSubview(valueWeight)
        
        viewSection.addSubview(baseCalc)
        viewSection.addSubview(stack)
        
        NSLayoutConstraint.activate([
            baseCalc.topAnchor.constraint(equalTo: viewSection.topAnchor),
            baseCalc.leadingAnchor.constraint(equalTo: viewSection.leadingAnchor),
            baseCalc.bottomAnchor.constraint(equalTo: viewSection.bottomAnchor),
            baseCalc.widthAnchor.constraint(equalToConstant: 150),
            baseCalc.heightAnchor.constraint(equalToConstant: 150),
            
            valueCcal.topAnchor.constraint(equalTo: baseCalc.topAnchor, constant: 10),
            valueCcal.leadingAnchor.constraint(equalTo: baseCalc.leadingAnchor, constant: 15),
            
            valueProtein.topAnchor.constraint(equalTo: valueCcal.topAnchor, constant: 20),
            valueProtein.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            valueFat.topAnchor.constraint(equalTo: valueProtein.topAnchor, constant: 20),
            valueFat.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            valueCarb.topAnchor.constraint(equalTo: valueFat.topAnchor, constant: 20),
            valueCarb.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            imtCalcImage.leadingAnchor.constraint(equalTo: imtCalc.leadingAnchor),
            imtCalcImage.topAnchor.constraint(equalTo: imtCalc.topAnchor),
            imtCalcImage.trailingAnchor.constraint(equalTo: imtCalc.trailingAnchor),
            imtCalcImage.bottomAnchor.constraint(equalTo: imtCalc.bottomAnchor),
            
            valueImt.topAnchor.constraint(equalTo: imtCalc.topAnchor, constant: 12),
            valueImt.leadingAnchor.constraint(equalTo: imtCalc.leadingAnchor, constant: 15),
            
            perfectWeightCalcImage.leadingAnchor.constraint(equalTo: perfectWeightCalc.leadingAnchor),
            perfectWeightCalcImage.topAnchor.constraint(equalTo: perfectWeightCalc.topAnchor),
            perfectWeightCalcImage.trailingAnchor.constraint(equalTo: perfectWeightCalc.trailingAnchor),
            perfectWeightCalcImage.bottomAnchor.constraint(equalTo: perfectWeightCalc.bottomAnchor),
            
            valueWeight.topAnchor.constraint(equalTo: perfectWeightCalc.topAnchor, constant: 12),
            valueWeight.leadingAnchor.constraint(equalTo: perfectWeightCalc.leadingAnchor, constant: 10),
            
            stack.topAnchor.constraint(equalTo: viewSection.topAnchor),
            stack.leadingAnchor.constraint(equalTo: baseCalc.trailingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: viewSection.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: baseCalc.bottomAnchor),
            stack.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        return viewSection
    }
    
    static func createCalcDataField(count: String, unitName: String) -> UIView {
        let fieldView = UIView()
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.text = count
        value.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        value.textColor = .main
        fieldView.addSubview(value)
        
        let unit = UILabel()
        unit.translatesAutoresizingMaskIntoConstraints = false
        unit.text = unitName
        unit.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        unit.textColor = .accent
        fieldView.addSubview(unit)
        
        NSLayoutConstraint.activate([
            value.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor),
            value.topAnchor.constraint(equalTo: fieldView.topAnchor),
            
            unit.leadingAnchor.constraint(equalTo: value.trailingAnchor, constant: 6),
            unit.bottomAnchor.constraint(equalTo: value.bottomAnchor),
        ])
        
        return fieldView
    }
    
    // Создание заголовка секции
    static func createSectionHeader(text: String) -> UILabel {
        let header = UILabel()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textColor = .main
        header.text = text
        return header
    }
    
    // Создание названия поля
    static func createLabelField(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .main
        label.text = text
        return label
    }
    
    // Создание поля для ввода данных
    static func createDataTextField(text: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.text = text
        textField.textColor = .accent
        textField.backgroundColor = .clear
        return textField
    }
    
    // Создание обертки для названия поля и поля для ввода данных
    static func createMainDataField(label: UILabel, textField: UITextField) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addSubview(textField)
        
        let textFieldBorder = UIView()
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.backgroundColor = .main
        textField.addSubview(textFieldBorder)
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 30),
            
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            textFieldBorder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10),
            textFieldBorder.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            textFieldBorder.widthAnchor.constraint(equalToConstant: 300),
            textFieldBorder.heightAnchor.constraint(equalToConstant: 1),
            
            label.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
        return view
    }
}

