//
//  CalcSectionView.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 18.05.2024.
//

import UIKit

class CalcSectionView: UIView {

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let viewSection = UIView()
        
        let baseCalc = UIView()
        baseCalc.translatesAutoresizingMaskIntoConstraints = false
        baseCalc.backgroundColor = .backgroundBlock
        baseCalc.layer.cornerRadius = 10
        
        let baseCalcImage = UIImageView(image: UIImage(named: "Ccal"))
        baseCalcImage.translatesAutoresizingMaskIntoConstraints = false
        baseCalcImage.contentMode = .scaleAspectFit
        baseCalc.addSubview(baseCalcImage)
        
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
        
        let perfectWeightCalc = UIView()
        perfectWeightCalc.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalc.backgroundColor = .backgroundBlock
        perfectWeightCalc.layer.cornerRadius = 10
        stack.addArrangedSubview(perfectWeightCalc)
        
        let perfectWeightCalcImage = UIImageView(image: UIImage(named: "PerfectWeight"))
        perfectWeightCalcImage.translatesAutoresizingMaskIntoConstraints = false
        perfectWeightCalcImage.contentMode = .scaleAspectFit
        perfectWeightCalc.addSubview(perfectWeightCalcImage)
        
        viewSection.addSubview(baseCalc)
        viewSection.addSubview(stack)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 150),
            self.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>)
            
            baseCalc.topAnchor.constraint(equalTo: viewSection.topAnchor),
            baseCalc.leadingAnchor.constraint(equalTo: viewSection.leadingAnchor),
            baseCalc.bottomAnchor.constraint(equalTo: viewSection.bottomAnchor),
            baseCalc.widthAnchor.constraint(equalToConstant: 150),
            baseCalc.heightAnchor.constraint(equalToConstant: 150),
            
            imtCalcImage.leadingAnchor.constraint(equalTo: imtCalc.leadingAnchor),
            imtCalcImage.topAnchor.constraint(equalTo: imtCalc.topAnchor),
            imtCalcImage.trailingAnchor.constraint(equalTo: imtCalc.trailingAnchor),
            imtCalcImage.bottomAnchor.constraint(equalTo: imtCalc.bottomAnchor),
            
            perfectWeightCalcImage.leadingAnchor.constraint(equalTo: perfectWeightCalc.leadingAnchor),
            perfectWeightCalcImage.topAnchor.constraint(equalTo: perfectWeightCalc.topAnchor),
            perfectWeightCalcImage.trailingAnchor.constraint(equalTo: perfectWeightCalc.trailingAnchor),
            perfectWeightCalcImage.bottomAnchor.constraint(equalTo: perfectWeightCalc.bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: viewSection.topAnchor),
            stack.leadingAnchor.constraint(equalTo: baseCalc.trailingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: viewSection.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: baseCalc.bottomAnchor),
            stack.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        addSubview(viewSection)
    }
    
}
