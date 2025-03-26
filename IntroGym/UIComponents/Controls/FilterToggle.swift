//
//  FilterToggle.swift
//  IntroGym
//
//  Created by Дывак Максим on 26.03.2025.
//

import UIKit
import SnapKit

final class FilterToggle: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configureView()
        setupSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.titleLabel?.font = AppFonts.bodyRegular()
        self.setTitleColor(AppColors.hint, for: .normal)
        self.setTitleColor(AppColors.background, for: .selected)
        self.backgroundColor = AppColors.background
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColors.hint?.cgColor
        self.layer.cornerRadius = 10
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc private func didTap() {
        self.isSelected.toggle()
        updateStyle()
    }
    
    private func updateStyle() {
        if isSelected {
            self.backgroundColor = AppColors.accent
            layer.borderColor = UIColor.clear.cgColor
        } else {
            self.backgroundColor = AppColors.background
            layer.borderColor = AppColors.hint?.cgColor
        }
    }
    
    private func setupSize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
}
