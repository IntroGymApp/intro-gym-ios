//
//  PrimaryButton.swift
//  IntroGym
//
//  Created by Дывак Максим on 26.03.2025.
//

import UIKit
import SnapKit

enum PrimaryButtonStyle {
    case normal
    case disabled
    case distructive
}

enum PrimaryButtonSize {
    case small
    case normal
}

final class PrimaryButton: UIButton {
    
    private var style: PrimaryButtonStyle = .normal
    private var size: PrimaryButtonSize = .normal
    
    init(title: String, style: PrimaryButtonStyle, size: PrimaryButtonSize) {
        super.init(frame: .zero)
        self.style = style
        self.size = size
        self.setTitle(title, for: .normal)
        configureView()
        setupStyle()
        setupSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.cornerRadius = 10
        self.titleLabel?.font = AppFonts.bodyBold()
    }
    
    private func setupStyle() {
        switch style {
        case .normal:
            backgroundColor = AppColors.accent
            setTitleColor(AppColors.background, for: .normal)
        case .disabled:
            isEnabled = false
            backgroundColor = AppColors.plate
            setTitleColor(AppColors.hint, for: .normal)
        case .distructive:
            backgroundColor = AppColors.plate
            setTitleColor(AppColors.red, for: .normal)
        }
    }
    
    private func setupSize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch size {
        case .small:
            self.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.width.equalTo(160)
            }
        case .normal:
            self.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.width.equalTo(350)
            }
        }
    }
    
}
