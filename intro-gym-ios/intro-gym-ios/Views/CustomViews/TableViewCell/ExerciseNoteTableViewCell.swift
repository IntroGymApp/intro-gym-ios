//
//  ExerciseNoteTableViewCell.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 27.05.2024.
//

import UIKit

class ExerciseNoteTableViewCell: UITableViewCell {
    
    let textCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .accentLight
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let counterContainer: UIView = {
        let counterContainer = UIView()
        counterContainer.translatesAutoresizingMaskIntoConstraints = false
        counterContainer.backgroundColor = .backgroundBlock
        return counterContainer
    }()
    
    let counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .accentLight
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(count: Int, repeats: Int, weight: Int) {
        counter.text = "#\(count)"
        textCell.text = "Повторений: \(repeats) х \(weight) кг"
    }
    
    private func setupLayout() {
        contentView.addSubview(textCell)
        contentView.addSubview(counterContainer)
        counterContainer.addSubview(counter)
        
        NSLayoutConstraint.activate([
            counterContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            counterContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            counterContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterContainer.widthAnchor.constraint(equalToConstant: 50),
            
            counter.centerXAnchor.constraint(equalTo: counterContainer.centerXAnchor),
            counter.centerYAnchor.constraint(equalTo: counterContainer.centerYAnchor),
            
            textCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textCell.leadingAnchor.constraint(equalTo: counterContainer.trailingAnchor, constant: 15)
        ])
        
        selectionStyle = .none
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.backgroundBlock.cgColor
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
}
