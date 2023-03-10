//
//  CalendarView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/05.
//

import UIKit
import SnapKit
import Then

class CalendarView : BaseUIView {
    // MARK: - PROPERTIES
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var firstWeekday : Int = 0
    var daysCountInMonth : Int = 0
    var weekdayAdding : Int = 0
    var days: [String] = []
    var isShowingCalendar : Bool = true
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
        $0.image = UIImage(named: "show")
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(previousMonthView)
        self.addSubview(currentDateLabelView)
        self.addSubview(nextMonthView)
        self.addSubview(stackView)
        self.addSubview(collectionView)
        self.addSubview(showHideCalendarButton)
        
        
        previousMonthView.addSubview(previousMonthImage)
        previousMonthView.addSubview(previousMonthButton)
        
        currentDateLabelView.addSubview(currentDateLabel)
        
        nextMonthView.addSubview(nextMonthImage)
        nextMonthView.addSubview(nextMonthButton)
        
        showHideCalendarButton.addSubview(showHideCalendarImage)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setLayout()
        setAction()
        
        dateFormatter.dateFormat = "yyyy년 M월"
        components.year = cal.component(.year, from: Date())
        components.month = cal.component(.month, from: Date())
        components.day = 1
        calculationDate()
        
        self.backgroundColor = .color7442FF
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.snp.makeConstraints {
            $0.height.equalTo(333).priority(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setLayout() {
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
            $0.top.equalToSuperview().offset(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-21)
            $0.top.equalTo(stackView.snp.bottom).offset(18).priority(1)
            $0.bottom.equalTo(showHideCalendarButton.snp.top).offset(-6.5)
            //$0.height.equalTo(208)
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
    
    func setAction() {
        previousMonthButton.addTarget(self, action: #selector(previousMonthButtonTapped), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(nextMonthButtonTapped), for: .touchUpInside)
        showHideCalendarButton.addTarget(self, action: #selector(showHideCalendarButtonTapped), for: .touchUpInside)
    }
    
    @objc func previousMonthButtonTapped(sender: UIButton!) {
        components.month = components.month! - 1
        calculationDate()
        collectionView.reloadData()
    }
    
    @objc func nextMonthButtonTapped(sender: UIButton!) {
        components.month = components.month! + 1
        calculationDate()
        collectionView.reloadData()
    }
    
    @objc func showHideCalendarButtonTapped(sender: UIButton!) {
        if isShowingCalendar {
            showHideCalendarImage.image = UIImage(named: "hide")
            self.snp.makeConstraints {
                $0.height.equalTo(159).priority(2)
            }
            collectionView.snp.makeConstraints {
                $0.top.equalTo(stackView.snp.bottom).offset(5).priority(2)
            }
            days = ["1","2","3","4","5","6","7"]
            
        } else {
            showHideCalendarImage.image = UIImage(named: "show")
            self.snp.makeConstraints {
                $0.height.equalTo(333).priority(2)
            }
            collectionView.snp.makeConstraints {
                $0.top.equalTo(stackView.snp.bottom).offset(18).priority(2)
            }
            calculationDate()
        }
       
        collectionView.reloadData()
        isShowingCalendar = !isShowingCalendar
    }
    
    func calculationDate() {
        self.days.removeAll()
        components.month = components.month! - 1
        let firstDayOfPreMonth = cal.date(from: components)
        var lastDay = cal.range(of: .day, in: .month, for: firstDayOfPreMonth!)!.count
        
        components.month = components.month! + 1
        let firstDayOfMonth = cal.date(from: components)
        firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday

        self.currentDateLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        
        for day in weekdayAdding...daysCountInMonth {
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
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if !isShowingCalendar {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isShowingCalendar {
            if section == 0 {
                return dayoftheweek.count
            }
            return days.count
        }
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !isShowingCalendar {
            if indexPath.section ==  0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayOfTheWeekCell", for: indexPath) as? DayOfTheWeekCell else { return UICollectionViewCell() }
                cell.dayOfTheWeekLabel.text = dayoftheweek[indexPath.row]
                return cell
            }

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
            cell.dayLabel.text = days[indexPath.row]
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as? DayCell else { return UICollectionViewCell() }
        cell.dayLabel.text = days[indexPath.row]
        if indexPath.row >= firstWeekday - 1 && indexPath.row <= daysCountInMonth + firstWeekday - 2 {
            cell.dayLabel.textColor = .colorF3F3F3
        } else {
            cell.dayLabel.textColor = .colorF3F3F303
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !isShowingCalendar {
            if indexPath.section == 0 {
                return CGSize(width: collectionView.bounds.width / 7.0, height: 20)
            }
            return CGSize(width: collectionView.bounds.width / 7.0, height: 29)
        }
        return CGSize(width: collectionView.bounds.width / 7.0, height: 208 / CGFloat(days.count / 7))
    }
}
