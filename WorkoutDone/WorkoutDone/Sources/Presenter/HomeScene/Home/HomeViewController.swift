//
//  HomeViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController : BaseViewController {
    
    
//    private let duringWorkoutViewController : DuringWorkoutViewController = {
//       let duringWorkoutViewController = DuringWorkoutViewController()
//        duringWorkoutViewController.view.tag = 992
////        duringWorkoutViewController.expandedViewHeight = self.view.frame.size.height
//        return duringWorkoutViewController
//    }()
    
    
    //MARK: - ViewModel
    var homeViewModel = HomeViewModel()
    let frameImageViewModel = FrameImageViewModel()
    
    private var didLoad = PublishSubject<Void>()
    var selectedDate = BehaviorSubject(value: Date().dateToInt())
    private lazy var input = HomeViewModel.Input(
        selectedDate: selectedDate.asDriver(onErrorJustReturn: Date().dateToInt()),
        loadView: didLoad.asDriver(onErrorJustReturn: ()))
    
    private lazy var output = homeViewModel.transform(input: input)
    
    
    // MARK: - PROPERTIES
    let monthlyCalendarHeight: Int = 289
    let weeklyCalendarHeight: Int = 115
    
//    private let duringWorkoutView = DuringWorkoutView()
    
    private let contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    
    let calendarView = CalendarView()
    ///기록하기
    let recordBaseView = RecordView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    ///운동하기
    private let workoutBaseView = WorkoutView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    ///운동 결과
    private let workoutResultBaseView = WorkoutResultView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.delegate = self
        calendarView.delegate = self
//        setWorkOutDoneImage()
//        duringWorkoutViewController.expandedViewHeight = self.view.frame.size.height

//        duringWorkoutViewController.didMove(toParent: self)
//        duringWorkoutViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        duringWorkoutViewController.view.backgroundColor = UIColor.red
//        print(duringWorkoutViewController.view.backgroundColor! as UIColor, "얍")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(showDuringWorkoutViewController(_:)), name: NSNotification.Name(duringWorkoutVcVisibility), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        didLoad.onNext(())
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let dateInt = calendarView.selectDate?.dateToInt()
        print(dateInt ?? Date().dateToInt(), "dd")

    }

    override func setupLayout() {
        super.setupLayout()

        view.addSubviews(contentScrollView)
        contentScrollView.addSubview(contentView)
        [calendarView, recordBaseView, workoutBaseView, workoutResultBaseView].forEach {
            contentView.addSubview($0)
        }
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .color7442FF
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isUserInteractionEnabled = true
        contentScrollView.isScrollEnabled = true
        contentScrollView.isUserInteractionEnabled = true
    }
    override func setupConstraints() {
        super.setupConstraints()
        
//        duringWorkoutView.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//            $0.height.equalTo(70)
//        }
        
        contentScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        // 캘린더 view
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        ///기록하기 view
        recordBaseView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(576)
        }
        ///운동하기 view
        workoutBaseView.snp.makeConstraints {
            $0.top.equalTo(recordBaseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        ///운동 결과
        workoutResultBaseView.snp.makeConstraints {
            $0.top.equalTo(workoutBaseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(182)
            $0.bottom.equalToSuperview()
        }
        
    }
    override func setupBinding() {
        super.setupBinding()
        output.weightData.drive(recordBaseView.weightInputLabel.rx.text)
            .disposed(by: disposeBag)
        output.skeletalMusleMassData.drive(recordBaseView.skeletalMuscleMassInputLabel.rx.text)
            .disposed(by: disposeBag)
        output.fatPercentageData.drive(recordBaseView.fatPercentageInputLabel.rx.text)
            .disposed(by: disposeBag)
        output.imageData.drive(recordBaseView.bodyImageView.rx.image)
            .disposed(by: disposeBag)
        
        calendarView.collectionView.rx.itemSelected
            .bind { _ in
                guard let dateInt = self.calendarView.selectDate?.dateToInt() else { return }
                self.selectedDate.onNext(dateInt)
            }
            .disposed(by: disposeBag)

        selectedDate.onNext(Date().dateToInt())
    }
    
    override func actions() {
        super.actions()
        recordBaseView.workoutDoneCameraButton.addTarget(self, action: #selector(workoutDoneCameraButtonTapped), for: .touchUpInside)
        recordBaseView.bodyDataEntryButton.addTarget(self, action: #selector(bodyDataEntryButtonTapped), for: .touchUpInside)
        workoutBaseView.workoutRoutineChoiceButton.addTarget(self, action: #selector(workoutRoutineChoiceButtonTapped), for: .touchUpInside)
        workoutResultBaseView.workoutResultButton.addTarget(self, action: #selector(workoutResultButtonTapped), for: .touchUpInside)
    }
    @objc func workoutDoneCameraButtonTapped() {
        let imageSelectionViewController = ImageSelectionViewController()
        imageSelectionViewController.rootView = self
        imageSelectionViewController.modalTransitionStyle = .crossDissolve
        imageSelectionViewController.modalPresentationStyle = .overFullScreen
        imageSelectionViewController.selectedDate = calendarView.selectDate?.dateToInt()
        imageSelectionViewController.completionHandler = { [weak self] dateValeu in
            guard let self else { return }
            self.selectedDate.onNext(dateValeu)
        }
        present(imageSelectionViewController, animated: true)
    }
    @objc func bodyDataEntryButtonTapped() {
        let registerMyBodyInfoViewController = RegisterMyBodyInfoViewController()
        registerMyBodyInfoViewController.selectedDate = calendarView.selectDate?.dateToInt()
        registerMyBodyInfoViewController.modalTransitionStyle = .crossDissolve
        registerMyBodyInfoViewController.modalPresentationStyle = .overFullScreen
        present(registerMyBodyInfoViewController, animated: true)
        registerMyBodyInfoViewController.completionHandler = { [weak self] dateValue in
            guard let self else { return }
            self.selectedDate.onNext(dateValue)
        }
    }
    @objc func workoutRoutineChoiceButtonTapped() {
        let workoutViewController = WorkoutViewController()
        workoutViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(workoutViewController, animated: true)
    }
    @objc func workoutResultButtonTapped() {
//        let workoutResultViewController = WorkoutResultViewController()
//        navigationController?.pushViewController(workoutResultViewController, animated: true)
        //MARK: - Todo 추후에 다시 코드 변경하기
        let duringWorkoutViewController = DuringWorkoutViewController()
        let navigationController = UINavigationController(rootViewController: duringWorkoutViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
//    func setWorkOutDoneImage() {
//        recordBaseView.bodyImageView.image = frameImageViewModel.loadImageFromRealm(date: calendarView.selectDate ?? Date())
//    }
//    @objc func showDuringWorkoutViewController(_ notification: Notification) {
//        print("showDuringWorkoutViewController")
//        self.tabBarController?.tabBar.isHidden.toggle()
//    }
}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UserDefaultsManager.shared.isMonthlyCalendar {
            if scrollView.contentOffset.y > CGFloat(monthlyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .color7442FF
            }
        } else {
            if scrollView.contentOffset.y > CGFloat(weeklyCalendarHeight) {
                view.backgroundColor = .colorFFFFFF
            } else {
                view.backgroundColor = .color7442FF
            }
        }
    }
}

extension HomeViewController : CalendarViewDelegate {
    func didSelectedCalendarDate() {
//        setWorkOutDoneImage()
    }
}
