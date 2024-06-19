//
//  CustomWorkoutCell.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 20.05.2024.
//

import UIKit

class CustomWorkoutCell: UITableViewCell {

    let backgroundImageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let workoutTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let workoutDescr: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let examplesCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .accent
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(backgroundImageCell)
        contentView.addSubview(workoutTitle)
        contentView.addSubview(workoutDescr)
        contentView.addSubview(examplesCount)
        
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = .backgroundBlock
        backgroundView = backgroundColorView
        
        selectionStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func configure(with title: String, descr: String?, examplesCount: Int?, backgroundImage: UIImage?) {
        workoutTitle.text = title
        workoutDescr.text = descr
        
        if examplesCount != nil {
            self.examplesCount.text = "Упражнений: \(examplesCount ?? 0)"
            self.examplesCount.isHidden = false
        } else {
            self.examplesCount.text = ""
            self.examplesCount.isHidden = true
        }
        
        backgroundImageCell.image = backgroundImage
    }
    
}
