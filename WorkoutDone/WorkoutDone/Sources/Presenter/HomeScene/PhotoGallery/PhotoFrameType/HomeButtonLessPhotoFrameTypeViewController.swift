//
//  HomeButtonLessPhotoFrameTypeViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/01.
//

import UIKit
import RxSwift
import RxCocoa


class HomeButtonLessPhotoFrameTypeViewController : BaseViewController {
    typealias frame = PhotoFrameType
    var selectedImage : UIImage?
    private var doubleCheckButtonStatus : Int?
    
    private var viewModel = PhotoFrameTypeViewModel()
    

    private var saveData = PublishSubject<Void>()
    private var selectedFrameType = PublishSubject<Int>()
    private var selectedFrameTypeButtonStatus = BehaviorSubject(value: false)
    private var selectedPhoto = PublishSubject<UIImage>()
    private var selectedDate = PublishSubject<Int>()
    
    private lazy var input = PhotoFrameTypeViewModel.Input(
        frameTypeButtonStatus: selectedFrameTypeButtonStatus.asDriver(onErrorJustReturn: false),
        selectedFrameType: selectedFrameType.asDriver(onErrorJustReturn: 0),
        selectedPhoto: selectedPhoto.asDriver(onErrorJustReturn: UIImage()),
        selectedDate: selectedDate.asDriver(onErrorJustReturn: 0),
        saveButtonTapped: saveData.asDriver(onErrorJustReturn: ()))
    private lazy var output = viewModel.transform(input: input)
    
    // MARK: - PROPERTIES
    private let saveButton = GradientButton(colors: [UIColor.color7442FF.cgColor, UIColor.color8E36FF.cgColor]).then {
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 20)
        $0.layer.cornerRadius = 12
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
    }
    private var disEnabledSaveButton = UIButton().then {
        $0.setTitle("저장하기", for: .normal)
        $0.titleLabel?.font = .pretendard(.bold, size: 20)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .colorCCCCCC
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
    }
    private let selectedImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let photoFrameBackView = UIView()
    private let saveButtonAreaBackView = UIView()
    private let separateView = UIView().then {
        $0.backgroundColor = UIColor.colorDBDBDB
    }
    
    private let photoFrameButtonsScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let photoFrameButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 10
    }
    private let photoFrameButtonsScrollContentView = UIView()
    ///프레임 타입 버튼
    private let defaultFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let manWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanFirstUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanSecondUpperBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    
    private let womanWholeBodyFrameButton = UIButton().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .colorE2E2E2
    }
    private var frameButtons = [UIButton]()
    
    
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    override func setupBinding() {
        output.saveData.drive(onNext: {
            self.navigationController?.popToRootViewController(animated: true)
        })
        .disposed(by: disposeBag)
        
        output.saveButtonStatus.drive(onNext: { value in
            if value {
                self.saveButton.isHidden = false
                self.disEnabledSaveButton.isHidden = true
                print("활성")
            }
            else {
                self.saveButton.isHidden = true
                self.disEnabledSaveButton.isHidden = false
                print("비활")
            }
        })
        .disposed(by: disposeBag)
        
        
        
        saveButton.rx.tap
            .bind { value in
                self.saveData.onNext(())
                print("눌려따")
            }
            .disposed(by: disposeBag)
        

        
        guard let image = selectedImage else { return }
        let resizedImage = resizeImage(image: image, newSize: CGSize(width: view.frame.width, height: view.frame.width * 4 / 3))
        selectedPhoto.onNext(resizedImage)
        guard let homeVC = self.navigationController?.viewControllers.first as? HomeViewController else { return }
        let homeVCDate = homeVC.calendarView.selectDate ?? Date()
        selectedDate.onNext(homeVCDate.dateToInt())
    }
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        navigationItem.title = "프레임 선택"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.color121212]
        
        [defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton].forEach {
            frameButtons.append($0)
        }
        defaultFrameButton.tag = frame.defaultFrame.getFrameType()
        manFirstUpperBodyFrameButton.tag = frame.manFirstUpperBodyFrame.getFrameType()
        manSecondUpperBodyFrameButton.tag = frame.manSecondUpperBodyFrame.getFrameType()
        manWholeBodyFrameButton.tag = frame.manWholeBodyFrame.getFrameType()
        womanFirstUpperBodyFrameButton.tag = frame.womanFirstUpperBodyFrame.getFrameType()
        womanSecondUpperBodyFrameButton.tag = frame.womanSecondUpperBodyFrame.getFrameType()
        womanWholeBodyFrameButton.tag = frame.womanWholeBodyFrame.getFrameType()
    }
    
    override func setupLayout() {
        view.addSubviews(selectedImageView, separateView, saveButtonAreaBackView, photoFrameBackView)
        saveButtonAreaBackView.addSubviews(saveButton, disEnabledSaveButton)
        photoFrameBackView.addSubview(photoFrameButtonsScrollView)
        photoFrameButtonsScrollView.addSubview(photoFrameButtonsScrollContentView)
        photoFrameButtonsScrollContentView.addSubview(photoFrameButtonsStackView)
        photoFrameButtonsStackView.addArrangedSubviews(defaultFrameButton, manFirstUpperBodyFrameButton, manSecondUpperBodyFrameButton, manWholeBodyFrameButton, womanFirstUpperBodyFrameButton, womanSecondUpperBodyFrameButton, womanWholeBodyFrameButton)
    }
    
    override func setupConstraints() {
        selectedImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * 4 / 3)
        }
        photoFrameBackView.snp.makeConstraints {
            $0.top.equalTo(selectedImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(103)
        }
        separateView.snp.makeConstraints {
            $0.top.equalTo(photoFrameBackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        saveButtonAreaBackView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        saveButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        disEnabledSaveButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(58)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        photoFrameButtonsScrollView.snp.makeConstraints {
            $0.centerY.equalTo(photoFrameBackView)
            $0.height.equalTo(75)
            $0.leading.trailing.equalToSuperview()
        }
        photoFrameButtonsScrollContentView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        photoFrameButtonsStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        
        
        defaultFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manFirstUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manSecondUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        manWholeBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanFirstUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanSecondUpperBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
        womanWholeBodyFrameButton.snp.makeConstraints {
            $0.height.width.equalTo(75)
        }
    }
    
    func setImage() {
        if let image = selectedImage {
            selectedImageView.image = image
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
        frameButtons.forEach {
            $0.addTarget(self, action: #selector(frameButtonTapped(sender: )), for: .touchUpInside)
        }
    }
    @objc func frameButtonTapped(sender : UIButton) {
        for button in frameButtons {
            if button == sender {
                if doubleCheckButtonStatus == sender.tag {
                    button.layer.borderColor = .none
                    button.layer.borderWidth = 0
                    doubleCheckButtonStatus = nil
                    selectedFrameTypeButtonStatus.onNext(false)
                }
                else {
                    button.layer.borderColor = UIColor.color7442FF.cgColor
                    button.layer.borderWidth = 2
                    doubleCheckButtonStatus = sender.tag
                    selectedFrameTypeButtonStatus.onNext(true)
                    selectedFrameType.onNext(sender.tag)
                    print(sender.tag, "ddd")
                }
            }
            else {
                button.layer.borderColor = .none
                button.layer.borderWidth = 0
            }
        }
    }
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
// MARK: - EXTENSIONs

extension HomeButtonLessPhotoFrameTypeViewController {
    enum PhotoFrameType : Int {
        case defaultFrame = 0
        case manFirstUpperBodyFrame = 1
        case manSecondUpperBodyFrame = 2
        case manWholeBodyFrame = 3
        case womanFirstUpperBodyFrame = 4
        case womanSecondUpperBodyFrame = 5
        case womanWholeBodyFrame = 6
        
        func getFrameType() -> Int {
            switch self {
            case .defaultFrame:
                return PhotoFrameType.defaultFrame.rawValue
            case .manFirstUpperBodyFrame:
                return PhotoFrameType.manFirstUpperBodyFrame.rawValue
            case .manSecondUpperBodyFrame:
                return PhotoFrameType.manSecondUpperBodyFrame.rawValue
            case .manWholeBodyFrame:
                return PhotoFrameType.manWholeBodyFrame.rawValue
            case .womanFirstUpperBodyFrame:
                return PhotoFrameType.womanFirstUpperBodyFrame.rawValue
            case .womanSecondUpperBodyFrame:
                return PhotoFrameType.womanSecondUpperBodyFrame.rawValue
            case .womanWholeBodyFrame:
                return PhotoFrameType.womanWholeBodyFrame.rawValue
            }
        }
    }
}

