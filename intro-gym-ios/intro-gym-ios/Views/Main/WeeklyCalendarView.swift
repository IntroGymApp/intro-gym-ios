//
//  WeeklyCalendarView.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 01.06.2024.
//

import UIKit

protocol WeeklyCalendarViewDelegate: AnyObject {
    func didTapPrevWeek()
    func didTapNextWeek()
    func didSelectDay(at index: Int)
}

class WeeklyCalendarView: UIView {
    
    weak var delegate: WeeklyCalendarViewDelegate?
    
    private let prevButton = UIButton()
    private let nextButton = UIButton()
    private let monthLabel = UILabel()
    private let stack = UIStackView()
    private var weekLabels = [UILabel]()
    private var dayButtons = [UIButton]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .backgroundBlock
        layer.cornerRadius = 16
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        monthLabel.textColor = .main
        monthLabel.textAlignment = .center
        
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        prevButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        prevButton.tintColor = .main
        prevButton.addTarget(self, action: #selector(showPrevWeek), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(UIImage(named: "arrow-right"), for: .normal)
        nextButton.tintColor = .main
        nextButton.addTarget(self, action: #selector(showNextWeek), for: .touchUpInside)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        
        for i in 0..<7 {
            let dayButton = UIButton()
            dayButton.translatesAutoresizingMaskIntoConstraints = false
            dayButton.layer.cornerRadius = 18
            dayButton.backgroundColor = .clear
            dayButton.tag = i
            dayButton.addTarget(self, action: #selector(didTapDayButton(_:)), for: .touchUpInside)
            dayButtons.append(dayButton)
            
            let weekLabel = UILabel()
            weekLabel.translatesAutoresizingMaskIntoConstraints = false
            weekLabel.textAlignment = .center
            weekLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            weekLabel.textColor = .main
            weekLabels.append(weekLabel)
        }
        
        dayButtons.forEach { addSubview($0) }
        weekLabels.forEach { addSubview($0) }
        addSubview(monthLabel)
        addSubview(prevButton)
        addSubview(nextButton)
        addSubview(stack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.widthAnchor.constraint(equalToConstant: 160),
            monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            monthLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            prevButton.trailingAnchor.constraint(equalTo: monthLabel.leadingAnchor, constant: -25),
            prevButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            prevButton.widthAnchor.constraint(equalToConstant: 20),
            prevButton.heightAnchor.constraint(equalToConstant: 20),
            
            nextButton.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 25),
            nextButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 20),
            
            stack.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 40),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        for i in 0..<7 {
            dayButtons[i].widthAnchor.constraint(equalToConstant: 35).isActive = true
            dayButtons[i].heightAnchor.constraint(equalToConstant: 35).isActive = true
            stack.addArrangedSubview(dayButtons[i])
            
            switch i {
            case 0: weekLabels[i].text = "п"
            case 1: weekLabels[i].text = "в"
            case 2: weekLabels[i].text = "с"
            case 3: weekLabels[i].text = "ч"
            case 4: weekLabels[i].text = "п"
            case 5: weekLabels[i].text = "с"
            case 6: weekLabels[i].text = "в"
            default: break
            }
            weekLabels[i].centerXAnchor.constraint(equalTo: dayButtons[i].centerXAnchor).isActive = true
            weekLabels[i].topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 20).isActive = true
        }
        
    }
    
    @objc private func showPrevWeek() {
        delegate?.didTapPrevWeek()
    }
    
    @objc private func showNextWeek() {
        delegate?.didTapNextWeek()
    }
    
    @objc private func didTapDayButton(_ sender: UIButton) {
        delegate?.didSelectDay(at: sender.tag)
    }
    
}

extension WeeklyCalendarView: WeeklyCalendarPresenterDelegate {
    
    func updateMonthLabel(with text: String) {
        monthLabel.text = text
    }
    
    func updateDayButtonTitles(with titles: [String]) {
        for (index, title) in titles.enumerated() {
            dayButtons[index].setTitle(title, for: .normal)
        }
    }
    
    func updateSelectedDayButton(at index: Int) {
        dayButtons.forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.main, for: .normal)
        }
        dayButtons[index].backgroundColor = .accent
        dayButtons[index].setTitleColor(.background, for: .normal)
    }
    
}
