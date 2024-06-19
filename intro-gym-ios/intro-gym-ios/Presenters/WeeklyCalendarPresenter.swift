//
//  WeeklyCalendarPresenter.swift
//  intro-gym-ios
//
//  Created by Дывак Максим on 02.06.2024.
//

import Foundation

protocol WeeklyCalendarPresenterDelegate: AnyObject {
    func updateMonthLabel(with text: String)
    func updateDayButtonTitles(with titles: [String])
    func updateSelectedDayButton(at index: Int)
}

class WeeklyCalendarPresenter {
    
    weak var delegate: WeeklyCalendarPresenterDelegate?
    weak var viewDelegate: WeeklyCalendarViewDayDelegate?
    var selectDay: Date?
    
    private var currentWeekStartDate: Date = Date() {
        didSet {
            updateWeekDays()
        }
    }
    private var datesOfWeek: [Date] = []
    private var selectedDayIndex: Int = 0
    private var isSelectButton = false
    
    init(delegate: WeeklyCalendarPresenterDelegate, viewDelegate: WeeklyCalendarViewDayDelegate) {
        self.delegate = delegate
        self.viewDelegate = viewDelegate
        updateWeekDays()
    }
    
    private func updateWeekDays() {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeekStartDate)) ?? Date()
        
        datesOfWeek = []
        var dayTitles: [String] = []
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                dayTitles.append(dateFormatter.string(from: day))
                datesOfWeek.append(day)
            }
        }
        
        delegate?.updateDayButtonTitles(with: dayTitles)
        
        let monthFormatter = DateFormatter()
        monthFormatter.locale = Locale(identifier: "ru_RU")
        monthFormatter.dateFormat = "d MMMM yyyy"
        delegate?.updateMonthLabel(with: monthFormatter.string(from: datesOfWeek[selectedDayIndex]))
        
        if isSelectButton {
            updateSelectDay()
        } else {
            updateTodayAsSelectDay()
        }
    }
    
    private func updateSelectDay() {
        selectDay = datesOfWeek[selectedDayIndex]
        delegate?.updateSelectedDayButton(at: selectedDayIndex)
        viewDelegate?.didSelectDay(day: selectDay ?? Date())
        
        let monthFormatter = DateFormatter()
        monthFormatter.locale = Locale(identifier: "ru_RU")
        monthFormatter.dateFormat = "d MMMM yyyy"
        delegate?.updateMonthLabel(with: monthFormatter.string(from: datesOfWeek[selectedDayIndex]))
    }
    
    private func updateTodayAsSelectDay() {
        let calendar = Calendar.current
        let now = Date()
        let dateComponent = calendar.dateComponents([.day, .month, .year], from: now)
        
        for (index, date) in datesOfWeek.enumerated() {
            if calendar.dateComponents([.day, .month, .year], from: date) == dateComponent {
                selectedDayIndex = index
                updateSelectDay()
                break
            }
        }
    }
    
}

extension WeeklyCalendarPresenter: WeeklyCalendarViewDelegate {
    
    func didTapPrevWeek() {
        currentWeekStartDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentWeekStartDate) ?? Date()
        updateWeekDays()
    }
    
    func didTapNextWeek() {
        currentWeekStartDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentWeekStartDate) ?? Date()
        updateWeekDays()
    }
    
    func didSelectDay(at index: Int) {
        isSelectButton = true
        selectedDayIndex = index
        updateSelectDay()
    }
    
}
