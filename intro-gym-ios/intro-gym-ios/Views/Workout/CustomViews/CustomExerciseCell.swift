//
//  CustomExerciseCell.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 21.05.2024.
//

import UIKit

class CustomExerciseCell: UITableViewCell {
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .main
        return label
    }()
    
    let exerciseInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .accent
        return label
    }()
    
    let exerciseImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
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
        contentView.addSubview(exerciseLabel)
        contentView.addSubview(exerciseInfoLabel)
        contentView.addSubview(exerciseImage)
        
        NSLayoutConstraint.activate([
            exerciseImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            exerciseImage.widthAnchor.constraint(equalToConstant: 58),
            exerciseImage.heightAnchor.constraint(equalToConstant: 58),
            exerciseImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            
            exerciseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            exerciseLabel.leadingAnchor.constraint(equalTo: exerciseImage.trailingAnchor, constant: 18),
            exerciseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            exerciseInfoLabel.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 3),
            exerciseInfoLabel.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor)
        ])
        
        selectionStyle = .none
        contentView.backgroundColor = .backgroundBlock
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func configure(with title: String, approaches: Int, repetitions: Int, weight: Int, image: UIImage?) {
        exerciseLabel.text = title
        exerciseInfoLabel.text = "\(approaches)x\(repetitions)x\(weight) кг"
        exerciseImage.image = image
    }
    
}
