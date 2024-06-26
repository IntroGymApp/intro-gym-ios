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
        label.numberOfLines = 0
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
    static func createHeaderWithField(header: String, fieldPlaceholder: String, fieldTag: Int) -> UIView {
        let label = createHeader(text: header)
        let textField = createField(placeholder: fieldPlaceholder)
        textField.tag = fieldTag
        
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
            header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
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
        
        let approaches = createPlanItemCard(iconName: "approaches", labelText: "Подходы", labelValue: "\(approachesValue)")
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
    
    static func createExerciseNoteFileds(repsFieldTag: Int, weightFieldTag: Int, buttonTag: Int) -> UIView {
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
        repeatsTextView.tag = repsFieldTag
        
        let weightTextView = createExerciseDataTextField(placeholder: "Килограмм")
        stack.addArrangedSubview(weightTextView)
        weightTextView.tag = weightFieldTag
        
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "plus"), for: .normal)
        addButton.backgroundColor = .accent
        addButton.tintColor = .background
        addButton.layer.cornerRadius = 8
        containerView.addSubview(addButton)
        addButton.tag = buttonTag
        
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
    
    static func createFieldWithName(name: String, nameData: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = name
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .main
        containerView.addSubview(label)
        
        let data = UILabel()
        data.translatesAutoresizingMaskIntoConstraints = false
        data.text = nameData
        data.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        data.textColor = .accent
        containerView.addSubview(data)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            data.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 60),
            data.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        return containerView
    }
    
    static func createCalcViews() -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Base calc
        let baseCalc = UIView()
        baseCalc.translatesAutoresizingMaskIntoConstraints = false
        baseCalc.backgroundColor = .backgroundBlock
        baseCalc.layer.cornerRadius = 10
        
        let baseCalcImage = UIImageView(image: UIImage(named: "Ccal"))
        baseCalcImage.translatesAutoresizingMaskIntoConstraints = false
        baseCalcImage.contentMode = .scaleAspectFill
        baseCalcImage.clipsToBounds = true
        baseCalcImage.layer.cornerRadius = 10
        baseCalc.addSubview(baseCalcImage)
        
        let valueCcal = createCalcDataField(count: "2780", unitName: "ккал")
        baseCalc.addSubview(valueCcal)
        
        let valueProtein = createCalcDataField(count: "78", unitName: "белки")
        baseCalc.addSubview(valueProtein)
        
        let valueFat = createCalcDataField(count: "90", unitName: "жиры")
        baseCalc.addSubview(valueFat)
        
        let valueCarb = createCalcDataField(count: "329", unitName: "углеводы")
        baseCalc.addSubview(valueCarb)
        
        // Imt calc
        let imtCalc = UIView()
        imtCalc.translatesAutoresizingMaskIntoConstraints = false
        imtCalc.backgroundColor = .backgroundBlock
        imtCalc.layer.cornerRadius = 10
        
        let imtCalcImage = UIImageView(image: UIImage(named: "IMT"))
        imtCalcImage.translatesAutoresizingMaskIntoConstraints = false
        imtCalcImage.contentMode = .scaleAspectFill
        imtCalcImage.clipsToBounds = true
        imtCalcImage.layer.cornerRadius = 10
        imtCalc.addSubview(imtCalcImage)
        
        let valueImt = createCalcDataField(count: "25.3", unitName: "ИМТ")
        imtCalc.addSubview(valueImt)
        
        // Perfect weight calc
        let perfectWeightCalc = UIView()
        perfectWeightCalc.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalc.backgroundColor = .backgroundBlock
        perfectWeightCalc.layer.cornerRadius = 10
        
        let perfectWeightCalcImage = UIImageView(image: UIImage(named: "PerfectWeight"))
        perfectWeightCalcImage.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalcImage.contentMode = .scaleAspectFill
        perfectWeightCalcImage.clipsToBounds = true
        perfectWeightCalcImage.layer.cornerRadius = 10
        perfectWeightCalc.addSubview(perfectWeightCalcImage)
        
        let valueWeight = createCalcDataField(count: "70" + " кг", unitName: "идеальный вес")
        perfectWeightCalc.addSubview(valueWeight)
        
        containerView.addSubview(baseCalc)
        containerView.addSubview(imtCalc)
        containerView.addSubview(perfectWeightCalc)
        
        NSLayoutConstraint.activate([
            // base calc
            baseCalc.topAnchor.constraint(equalTo: containerView.topAnchor),
            baseCalc.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            baseCalc.widthAnchor.constraint(equalToConstant: 168),
            baseCalc.heightAnchor.constraint(equalToConstant: 168),
            
            baseCalcImage.topAnchor.constraint(equalTo: baseCalc.topAnchor),
            baseCalcImage.leadingAnchor.constraint(equalTo: baseCalc.leadingAnchor),
            baseCalcImage.trailingAnchor.constraint(equalTo: baseCalc.trailingAnchor),
            baseCalcImage.bottomAnchor.constraint(equalTo: baseCalc.bottomAnchor),
            
            valueCcal.topAnchor.constraint(equalTo: baseCalc.topAnchor, constant: 10),
            valueCcal.leadingAnchor.constraint(equalTo: baseCalc.leadingAnchor, constant: 15),
            
            valueProtein.topAnchor.constraint(equalTo: valueCcal.topAnchor, constant: 24),
            valueProtein.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            valueFat.topAnchor.constraint(equalTo: valueProtein.topAnchor, constant: 24),
            valueFat.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            valueCarb.topAnchor.constraint(equalTo: valueFat.topAnchor, constant: 24),
            valueCarb.leadingAnchor.constraint(equalTo: valueCcal.leadingAnchor),
            
            // imt calc
            imtCalc.topAnchor.constraint(equalTo: containerView.topAnchor),
            imtCalc.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imtCalc.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.0, constant: -168 - 12),
            imtCalc.heightAnchor.constraint(equalToConstant: 78),
            
            imtCalcImage.topAnchor.constraint(equalTo: imtCalc.topAnchor),
            imtCalcImage.leadingAnchor.constraint(equalTo: imtCalc.leadingAnchor),
            imtCalcImage.trailingAnchor.constraint(equalTo: imtCalc.trailingAnchor),
            imtCalcImage.bottomAnchor.constraint(equalTo: imtCalc.bottomAnchor),
            
            valueImt.topAnchor.constraint(equalTo: imtCalc.topAnchor, constant: 12),
            valueImt.leadingAnchor.constraint(equalTo: imtCalc.leadingAnchor, constant: 15),
            
            // perfect weight calc
            perfectWeightCalc.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            perfectWeightCalc.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            perfectWeightCalc.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.0, constant: -168 - 12),
            perfectWeightCalc.heightAnchor.constraint(equalToConstant: 78),
            
            perfectWeightCalcImage.topAnchor.constraint(equalTo: perfectWeightCalc.topAnchor),
            perfectWeightCalcImage.leadingAnchor.constraint(equalTo: perfectWeightCalc.leadingAnchor),
            perfectWeightCalcImage.trailingAnchor.constraint(equalTo: perfectWeightCalc.trailingAnchor),
            perfectWeightCalcImage.bottomAnchor.constraint(equalTo: perfectWeightCalc.bottomAnchor),
            
            valueWeight.topAnchor.constraint(equalTo: perfectWeightCalc.bottomAnchor, constant: -30),
            valueWeight.leadingAnchor.constraint(equalTo: perfectWeightCalc.leadingAnchor, constant: 10),
            
        ])
        
        return containerView
    }
    
    static func createCalcDataField(count: String, unitName: String) -> UIView {
        let fieldView = UIView()
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        
        let value = UILabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.text = count
        value.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
}
