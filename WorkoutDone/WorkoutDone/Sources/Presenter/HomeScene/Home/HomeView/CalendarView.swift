//
//  CalendarView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

//
//  CalendarView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit
import SnapKit
import Then

protocol CalendarViewDelegate: AnyObject {
    func didSelectedCalendarDate()
}

class CalendarView : BaseUIView {
    // MARK: - PROPERTIES
    var selectDate : Date?
    
    var calendar = Calendar.current
    let formatter = DateFormatter()
    var components = DateComponents()
    var selectComponents = DateComponents()
    var firstWeekday : Int = 0
    var daysCount : Int = 0
    var previousDays : Int = 0
    var days: [String] = []
    var dayoftheweek = ["일", "월", "화", "수", "목", "금", "토"]

    var delegate: CalendarViewDelegate?
    
    var calendarViewModel = CalendarViewModel()
    var currentMonthStamp = [String: String]()
    
    private let previousMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "previousMonth"), for: .normal)
    }
    
    private let currentDateLabelView = UIView()
    
    private lazy var currentDateLabel = UILabel().then {
        $0.textColor = .colorC8B4FF
        $0.font = .pretendard(.bold, size: 16)
        $0.textAlignment = .center
    }
    
    private let nextMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "nextMonth"), for: .normal)
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousMonthButton, currentDateLabelView, nextMonthButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 9
        
        return stackView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        collectionView.register(DayOfTheWeekCell.self, forCellWithReuseIdentifier: "DayOfTheWeekCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private let showHideCalendarButton = UIButton()
    
    private let showHideCalendarImage = UIImageView().then {
        $0.image = UIImage(named: UserDefaultsManager.shared.isMonthlyCalendar ? "calendar_show" : "calendar_hide")
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
        
        [previousMonthButton, currentDateLabelView, nextMonthButton, collectionView, showHideCalendarButton].forEach {
            self.addSubview($0)
        }

        self.addSubview(stackView)
        
        currentDateLabelView.addSubview(currentDateLabel)
        
        showHideCalendarButton.addSubview(showHideCalendarImage)
    }
    
    // MARK: - ACTIONS
    override func setupConstraints() {
        super.setupConstraints()
        
        previousMonthButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }

        currentDateLabelView.snp.makeConstraints {
            $0.width.equalTo(83)
        }

        currentDateLabel.snp.makeConstraints {
            $0.leading.equalTo(currentDateLabelView)
            $0.centerY.equalTo(currentDateLabelView)
        }
        
        nextMonthButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }
   
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.top.equalTo(stackView.snp.bottom).offset(6)
            $0.bottom.equalTo(showHideCalendarButton.snp.top).offset(-2)
        }
        
        showHideCalendarImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(15)
            $0.height.equalTo(8)
        }
        
        showHideCalendarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-3)
            $0.width.equalTo(35)
            $0.height.equalTo(19)
        }
    }
    
    func setCalendarView() {
        self.backgroundColor = .colorF6F4FF
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.snp.makeConstraints {
            $0.height.equalTo(UserDefaultsManager.shared.isMonthlyCalendar ? 330 : 126).priority(1)
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
        
        let currentYearMonth = setDateFormatter(dateComponents: components)
        currentMonthStamp = calendarViewModel.loadStampImage(date: currentYearMonth)
        
        selectComponents.year = calendar.component(.year, from: Date())
        selectComponents.month = calendar.component(.month, from: Date())
        selectComponents.day = calendar.component(.day, from: Date())
        
        selectDate = setSelectDateFormatter(dateComponents: selectComponents)
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
        
        let currentYearMonth = setDateFormatter(dateComponents: components)
        currentMonthStamp = calendarViewModel.loadStampImage(date: currentYearMonth)
        
        collectionView.reloadData()
    }
    
    @objc func nextMonthButtonTapped(sender: UIButton!) {
        components.month = components.month! + 1
        
        if !UserDefaultsManager.shared.isMonthlyCalendar && components.month ?? 1 == calendar.component(.month, from: Date()) {
            calculateWeek()
        } else {
            calculateMonth()
        }
        
        let currentYearMonth = setDateFormatter(dateComponents: components)
        currentMonthStamp = calendarViewModel.loadStampImage(date: currentYearMonth)
        
        collectionView.reloadData()
    }
    
    @objc func showHideCalendarButtonTapped(sender: UIButton!) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            showHideCalendarImage.image = UIImage(named: "calendar_hide")
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations:  {
                self.snp.makeConstraints {
                    $0.height.equalTo(126).priority(2)
                }
                self.superview?.layoutIfNeeded()
            })
            
            if components.month ?? 1 == calendar.component(.month, from: Date()) {
                calculateWeek()
            } else {
                calculateMonth()
            }
        } else {
            showHideCalendarImage.image = UIImage(named: "calendar_show")
                
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations:  {
                self.snp.makeConstraints {
                    $0.height.equalTo(330).priority(2)
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
        let startDayOfWeek = (Int(formatter.string(from: startOfWeek)) ?? 0)
        let endDayOfWeek = Int(formatter.string(from: endOfWeek)) ?? 0
        
        formatter.dateFormat = "yyyy년 M월"
        currentDateLabel.text = formatter.string(from: calendar.date(from: components)!)
        
        days.removeAll()
        
        if startDayOfWeek > endDayOfWeek {
            for day in startDayOfWeek...startDayOfWeek + (7 - endDayOfWeek) {
                days.append(String(day))
            }
            for day in 1..<endDayOfWeek {
                days.append(String(day))
            }
        } else {
            for day in startDayOfWeek..<endDayOfWeek {
                days.append(String(day))
            }
        }
    }
    
    func setSelectDateFormatter(dateComponents : DateComponents) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return calendar.date(from: dateComponents)!
    }
    
    func setDateFormatter(dateComponents : DateComponents) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM."
        let date = calendar.date(from: dateComponents)!
        
        return dateFormatter.string(from: date)
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return dayoftheweek.count
        }
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section ==  0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayOfTheWeekCell", for: indexPath) as? DayOfTheWeekCell else { return UICollectionViewCell() }
            cell.dayOfTheWeekLabel.text = dayoftheweek[indexPath.row]
            return cell
        }
        
        if !UserDefaultsManager.shared.isMonthlyCalendar {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
            cell.dayLabel.text = days[indexPath.row]
            cell.dayLabel.font = .pretendard(.light, size: 16)
            cell.selectedDateImage.isHidden = true
            cell.stampImage.isHidden = true
            
            if components.month ?? 1 == calendar.component(.month, from: Date()) {
                cell.dayLabel.textColor = .color121212
                
                if days[indexPath.row] == String(calendar.component(.day, from: Date())) {
                    cell.dayLabel.font = .pretendard(.extraBold, size: 16)
                }
                
                let day = days[indexPath.row]
                if let stamp = currentMonthStamp[day] {
                    cell.stampImage.isHidden = false
                    cell.dayLabel.textColor = .colorC8B4FF
                    cell.stampImage.image = UIImage(named: stamp)
                }
                
                if selectComponents.year == components.year && selectComponents.month == components.month && selectComponents.day == Int(days[indexPath.row]) {
                    cell.selectedDateImage.isHidden = false
                    
                    if cell.stampImage.isHidden {
                        cell.selectedDateImage.snp.remakeConstraints {
                            $0.centerX.centerY.equalTo(cell.contentView)
                            $0.width.height.equalTo(40)
                        }
                    }
                }
                
            } else {
                if indexPath.row >= firstWeekday - 1 {
                    cell.dayLabel.textColor = .color121212
                } else {
                    cell.dayLabel.textColor = .color121212.withAlphaComponent(0.3)
                }
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
        cell.dayLabel.text = days[indexPath.row]
        cell.dayLabel.font = .pretendard(.light, size: 16)
        cell.selectedDateImage.isHidden = true
        cell.stampImage.isHidden = true
        
        if indexPath.row >= firstWeekday - 1 && indexPath.row <= daysCount + firstWeekday - 2 {
            if components.month ?? 1 == calendar.component(.month, from: Date()) && days[indexPath.row] == String(calendar.component(.day, from: Date())) {
                cell.dayLabel.font = .pretendard(.extraBold, size: 16)
            }
            cell.dayLabel.textColor = .color121212
            
            let day = days[indexPath.row]
            if let stamp = currentMonthStamp[day] {
                cell.stampImage.isHidden = false
                cell.dayLabel.textColor = .colorC8B4FF
                cell.stampImage.image = UIImage(named: stamp)
            }
            
            if selectComponents.year == components.year && selectComponents.month == components.month && selectComponents.day == Int(days[indexPath.row]) {
                cell.selectedDateImage.isHidden = false
                
                if cell.stampImage.isHidden {
                    cell.selectedDateImage.snp.remakeConstraints {
                        $0.centerX.centerY.equalTo(cell.contentView)
                        $0.width.height.equalTo(40)
                    }
                }
            }
            
        } else {
            cell.dayLabel.textColor = .color121212.withAlphaComponent(0.3)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width / 7.0, height: 20)
        }
        
        if !UserDefaultsManager.shared.isMonthlyCalendar {
            return CGSize(width: collectionView.bounds.width / 7.0, height: 45)
        }
        return CGSize(width: collectionView.bounds.width / 7.0, height: (collectionView.bounds.height - 23) / CGFloat(days.count / 7))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            if indexPath.row >= firstWeekday - 1 && indexPath.row <= daysCount + firstWeekday - 2 {
                selectComponents.year = components.year
                selectComponents.month = components.month
                selectComponents.day = Int(days[indexPath.row])
                
                selectDate = setSelectDateFormatter(dateComponents: selectComponents)
            }
        } else {
            if components.month ?? 1 == calendar.component(.month, from: Date()) {
                selectComponents.year = components.year
                selectComponents.month = components.month
                selectComponents.day = Int(days[indexPath.row])
                
                selectDate = setSelectDateFormatter(dateComponents: selectComponents)
            }
        }
        
        collectionView.reloadData()
       
        delegate?.didSelectedCalendarDate()
    }
}
