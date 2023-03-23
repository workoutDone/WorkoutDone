//
//  CalendarView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit
import SnapKit
import Then

struct WorkOutDone {
    var date: Date
    var image: String
}

var sampleData = [WorkOutDone(date: Calendar.current.date(from: DateComponents(year: 2023, month: 03, day: 15))!, image: ""), WorkOutDone(date: Calendar.current.date(from: DateComponents(year: 2023, month: 03, day: 13))!, image: ""), WorkOutDone(date: Calendar.current.date(from: DateComponents(year: 2023, month: 03, day: 10))!, image: ""), WorkOutDone(date: Calendar.current.date(from: DateComponents(year: 2023, month: 02, day: 23))!, image: ""), WorkOutDone(date: Calendar.current.date(from: DateComponents(year: 2023, month: 03, day: 1))!, image: "")]

class CalendarView : BaseUIView {
    // MARK: - PROPERTIES
    var calendar = Calendar.current
    let formatter = DateFormatter()
    var components = DateComponents()
    var firstWeekday : Int = 0
    var daysCount : Int = 0
    var previousDays : Int = 0
    var days: [String] = []
    var dayoftheweek = ["월", "화", "수", "목", "금", "토", "일"]
    
    private let previousMonthButton = UIButton()
    
    private let previousMonthView = UIView()
    
    private let previousMonthImage = UIImageView().then {
        $0.image = UIImage(named: "previousMonth")
    }
    
    private let currentDateLabelView = UIView()
    
    private lazy var currentDateLabel = UILabel().then {
        $0.textColor = .colorECE5FF
        $0.font = .pretendard(.bold, size: 16)
        $0.textAlignment = .center
    }
    
    private let nextMonthButton = UIButton()
    
    private let nextMonthView = UIView()
    
    private let nextMonthImage = UIImageView().then {
        $0.image = UIImage(named: "nextMonth")
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousMonthView, currentDateLabelView, nextMonthView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 9
        
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.register(DayOfTheWeekCell.self, forCellWithReuseIdentifier: "DayOfTheWeekCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .color7442FF
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private let showHideCalendarButton = UIButton()
    
    private let showHideCalendarImage = UIImageView().then {
        $0.image = UIImage(named: UserDefaultsManager.shared.isMonthlyCalendar ? "show" : "hide")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCalendarView()
        setDelegateDataSource()
        setAction()
        setCurrentDate()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [previousMonthView, currentDateLabelView, nextMonthView, collectionView, showHideCalendarButton].forEach {
            self.addSubview($0)
        }

        self.addSubview(stackView)

        [previousMonthImage, previousMonthButton].forEach {
            previousMonthView.addSubview($0)
        }
        
        currentDateLabelView.addSubview(currentDateLabel)
        
        [nextMonthImage, nextMonthButton].forEach {
            nextMonthView.addSubview($0)
        }
        
        showHideCalendarButton.addSubview(showHideCalendarImage)
    }
    
    // MARK: - ACTIONS
    override func setupConstraints() {
        super.setupConstraints()
        
        previousMonthView.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }
        
        previousMonthButton.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(previousMonthView)
        }
        
        previousMonthImage.snp.makeConstraints {
            $0.centerX.equalTo(previousMonthView)
            $0.centerY.equalTo(previousMonthView)
            $0.width.equalTo(7.28)
            $0.height.equalTo(13)
        }
        
        currentDateLabelView.snp.makeConstraints {
            $0.width.equalTo(83)
        }

        currentDateLabel.snp.makeConstraints {
            $0.leading.equalTo(currentDateLabelView)
            $0.centerY.equalTo(currentDateLabelView)
        }
        
        nextMonthView.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }
        
        nextMonthButton.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(nextMonthView)
        }
        
        nextMonthImage.snp.makeConstraints {
            $0.centerX.equalTo(nextMonthView)
            $0.centerY.equalTo(nextMonthView)
            $0.width.equalTo(7.28)
            $0.height.equalTo(13)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.top.equalTo(stackView.snp.bottom).offset(UserDefaultsManager.shared.isMonthlyCalendar ? 18 : 5).priority(1)
            $0.bottom.equalTo(showHideCalendarButton.snp.top).offset(-6.5)
        }
        
        showHideCalendarImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(15)
            $0.height.equalTo(8)
        }
        
        showHideCalendarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(35)
            $0.height.equalTo(24)
        }
    }
    
    func setCalendarView() {
        self.backgroundColor = .color7442FF
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.snp.makeConstraints {
            $0.height.equalTo(UserDefaultsManager.shared.isMonthlyCalendar ? 289 : 115).priority(1)
        }
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCurrentDate() {
        formatter.dateFormat = "yyyy년 M월"
        components.year = calendar.component(.year, from: Date())
        components.month = calendar.component(.month, from: Date())
        components.day = 1

        if UserDefaultsManager.shared.isMonthlyCalendar {
            calculateMonth()
        } else {
            calculateWeek()
        }
    }
    
    func setAction() {
        previousMonthButton.addTarget(self, action: #selector(previousMonthButtonTapped), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(nextMonthButtonTapped), for: .touchUpInside)
        showHideCalendarButton.addTarget(self, action: #selector(showHideCalendarButtonTapped), for: .touchUpInside)
    }
    
    @objc func previousMonthButtonTapped(sender: UIButton!) {
        components.month = components.month! - 1
       
        if !UserDefaultsManager.shared.isMonthlyCalendar && components.month ?? 1 == calendar.component(.month, from: Date()) {
            calculateWeek()
        } else {
            calculateMonth()
        }
        
        collectionView.reloadData()
    }
    
    @objc func nextMonthButtonTapped(sender: UIButton!) {
        components.month = components.month! + 1
        
        if !UserDefaultsManager.shared.isMonthlyCalendar && components.month ?? 1 == calendar.component(.month, from: Date()) {
            calculateWeek()
        } else {
            calculateMonth()
        }
        
        collectionView.reloadData()
    }
    
    @objc func showHideCalendarButtonTapped(sender: UIButton!) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            showHideCalendarImage.image = UIImage(named: "hide")
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations:  {
                self.snp.makeConstraints {
                    $0.height.equalTo(115).priority(2)
                }
                self.collectionView.snp.makeConstraints {
                    $0.top.equalTo(self.stackView.snp.bottom).offset(5).priority(2)
                }
                self.superview?.layoutIfNeeded()
            })
            
            if components.month ?? 1 == calendar.component(.month, from: Date()) {
                calculateWeek()
            } else {
                calculateMonth()
            }
        } else {
            showHideCalendarImage.image = UIImage(named: "show")
                
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations:  {
                self.snp.makeConstraints {
                    $0.height.equalTo(289).priority(2)
                }
                self.collectionView.snp.makeConstraints {
                    $0.top.equalTo(self.stackView.snp.bottom).offset(18).priority(2)
                }
                self.superview?.layoutIfNeeded()
            })
            
            calculateMonth()
        }
        
        collectionView.reloadData()
        UserDefaultsManager.shared.saveCalendar()
    }
    
    func calculateMonth() {
        components.month = components.month! - 1
        let firstDayOfPreMonth = calendar.date(from: components)
        var lastDay = calendar.range(of: .day, in: .month, for: firstDayOfPreMonth!)!.count
        
        components.month = components.month! + 1
        let firstDayOfMonth = calendar.date(from: components)
        firstWeekday = calendar.component(.weekday, from: firstDayOfMonth!)
        daysCount = calendar.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        previousDays = 2 - firstWeekday

        currentDateLabel.text = formatter.string(from: firstDayOfMonth!)
        
        days.removeAll()
        
        for day in previousDays...daysCount {
            if day < 1 {
                days.insert(String(lastDay), at: 0)
                lastDay -= 1
            } else {
                days.append(String(day))
            }
        }
        
        var day = 1
        while days.count % 7 != 0 {
            days.append(String(day))
            day += 1
        }
    }
    
    func calculateWeek() {
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        
        formatter.dateFormat = "dd"
        let startDayOfWeek = (Int(formatter.string(from: startOfWeek)) ?? 0) + 1
        let endDayOfWeek = Int(formatter.string(from: endOfWeek)) ?? 0
        
        formatter.dateFormat = "yyyy년 M월"
        currentDateLabel.text = formatter.string(from: calendar.date(from: components)!)
        
        days.removeAll()
        
        for day in startDayOfWeek...endDayOfWeek {
            days.append(String(day))
        }
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !UserDefaultsManager.shared.isMonthlyCalendar && section == 0 {
            return dayoftheweek.count
        }
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !UserDefaultsManager.shared.isMonthlyCalendar {
            if indexPath.section ==  0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayOfTheWeekCell", for: indexPath) as? DayOfTheWeekCell else { return UICollectionViewCell() }
                cell.dayOfTheWeekLabel.text = dayoftheweek[indexPath.row]
                return cell
            }

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
            cell.dayLabel.text = days[indexPath.row]
            cell.dayLabel.font = .pretendard(.light, size: 16)
            cell.todayImage.isHidden = true
            cell.workOutDoneImage.isHidden = true
            
            if !UserDefaultsManager.shared.isMonthlyCalendar && components.month ?? 1 == calendar.component(.month, from: Date()) {
                for data in sampleData {
                    if Calendar.current.date(from: DateComponents(year: components.year, month: components.month, day: Int(days[indexPath.row])))! == data.date {
                        cell.workOutDoneImage.isHidden = false
                    }
                }
                
                cell.dayLabel.textColor = .colorF3F3F3
                
                if days[indexPath.row] == String(calendar.component(.day, from: Date())) {
                    cell.todayImage.isHidden = false
                    cell.dayLabel.font = .pretendard(.bold, size: 16)
                }
            } else {
                if indexPath.row >= firstWeekday - 1 {
                    cell.dayLabel.textColor = .colorF3F3F3
                } else {
                    cell.dayLabel.textColor = .colorF3F3F303
                }
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
        cell.dayLabel.text = days[indexPath.row]
        cell.dayLabel.font = .pretendard(.light, size: 14)
        cell.todayImage.isHidden = true
        cell.workOutDoneImage.isHidden = true
        
        if indexPath.row >= firstWeekday - 1 && indexPath.row <= daysCount + firstWeekday - 2 {
            for data in sampleData {
                if Calendar.current.date(from: DateComponents(year: components.year, month: components.month, day: Int(days[indexPath.row])))! == data.date {
                    cell.workOutDoneImage.isHidden = false
                }
            }
            cell.dayLabel.textColor = .colorF3F3F3
        } else {
            cell.dayLabel.textColor = .colorF3F3F303
        }
        
        if components.month ?? 1 == calendar.component(.month, from: Date()) && days[indexPath.row] == String(calendar.component(.day, from: Date())) {
            cell.todayImage.isHidden = false
            cell.dayLabel.font = .pretendard(.bold, size: 14)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !UserDefaultsManager.shared.isMonthlyCalendar {
            if indexPath.section == 0 {
                return CGSize(width: collectionView.bounds.width / 7.0, height: 20)
            }
            return CGSize(width: collectionView.bounds.width / 7.0, height: 29)
        }
        return CGSize(width: collectionView.bounds.width / 7.0, height: 208 / CGFloat(days.count / 7))
    }
}
