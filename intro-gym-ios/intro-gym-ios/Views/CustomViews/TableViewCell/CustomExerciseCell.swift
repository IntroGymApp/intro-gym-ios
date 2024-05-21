//
//  CustomExerciseCell.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 21.05.2024.
//

import UIKit

class CustomExerciseCell: UITableViewCell {
    
    let excerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    let excerciseInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .accent
        return label
    }()
    
    let excerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(excerciseLabel)
        contentView.addSubview(excerciseInfoLabel)
        contentView.addSubview(excerciseImage)
        
        NSLayoutConstraint.activate([
            excerciseImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            excerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            excerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            excerciseLabel.leadingAnchor.constraint(equalTo: excerciseImage.trailingAnchor, constant: 18),
            
            excerciseInfoLabel.topAnchor.constraint(equalTo: excerciseLabel.bottomAnchor, constant: 3),
            excerciseInfoLabel.leadingAnchor.constraint(equalTo: excerciseLabel.leadingAnchor)
        ])
        
        selectionStyle = .none
        contentView.backgroundColor = .backgroundBlock
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func configure(with title: String, approaches: Int, repetitions: Int, weight: Int, image: UIImage?) {
        excerciseLabel.text = title
        excerciseInfoLabel.text = "\(approaches)x\(repetitions)x\(weight) кг"
        excerciseImage.image = image
    }
    
}
