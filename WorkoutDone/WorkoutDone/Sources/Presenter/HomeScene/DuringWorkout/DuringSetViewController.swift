//
//  DuringSetViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/26.
//

import UIKit
import RxCocoa
import RxSwift

final class DuringSetViewController : BaseViewController {
    lazy var weightTrainingArrayIndex = 0
    private lazy var weightTrainingInfoArrayIndex = 0
    private lazy var weightTrainingInfoCount = 0
    private var temporaryRoutine : Routine?
    private var weightTraining : WeightTraining?
    private lazy var weightTrainingInfoArray : [WeightTrainingInfo] = []
    
    // MARK: - ViewModel
    private let viewModel = DuringSetViewModel()
    private let didLoad = PublishSubject<Void>()
    let weightTrainingArrayIndexRx = PublishSubject<Int>()
    private let addWeightTrainingInfoTrigger = PublishSubject<Void>()
    private let addWeightTrainingInfoIndexTrigger = PublishSubject<Int>()
    private let deleteSetTrigger = PublishSubject<Void>()
    private let deleteSetIndex = PublishSubject<Int>()
    private let deleteWeightTrainingArrayIndex = PublishSubject<Int>()
    private lazy var input = DuringSetViewModel.Input(
        loadView: didLoad.asDriver(onErrorJustReturn: ()),
        weightTrainingArrayIndex: weightTrainingArrayIndexRx.asDriver(onErrorJustReturn: 0),
        addWeightTrainingInfoTrigger: addWeightTrainingInfoTrigger.asDriver(onErrorJustReturn: ()),
        addWeightTrainingInfoIndexTrigger: addWeightTrainingInfoIndexTrigger.asDriver(onErrorJustReturn: 0),
        deleteSetTrigger: deleteSetTrigger.asDriver(onErrorJustReturn: ()),
        deleteSetIndex: deleteSetIndex.asDriver(onErrorJustReturn: 0),
        deleteWeightTrainingArrayIndex: deleteWeightTrainingArrayIndex.asDriver(onErrorJustReturn: 0))
    private lazy var output = viewModel.transform(input: input)
    // MARK: - PROPERTIES
    
    private let tableBackView = UIView().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
    }
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
        $0.separatorStyle = .none
    }
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setupBinding() {
        super.setupBinding()
        
        output.weightTrainingInfoCount.drive { value in
            self.weightTrainingInfoCount = value
        }
        .disposed(by: disposeBag)
        
        output.weightTrainingInfo.drive { value in
            self.weightTrainingInfoArray = value

        }
        .disposed(by: disposeBag)
        
        output.addData.drive(onNext: { value in
            if value {
                self.weightTrainingArrayIndexRx.onNext(self.weightTrainingArrayIndex)
                self.tableView.reloadData()
            }
        })
        .disposed(by: disposeBag)
        
        output.deleteSetData.drive(onNext: { value in
            if value {
                self.weightTrainingArrayIndexRx.onNext(self.weightTrainingArrayIndex)
                self.tableView.reloadData()
            }
        })
        .disposed(by: disposeBag)
        
        output.weightTraining.drive(onNext: { value in
            self.weightTraining = value
        })
        .disposed(by: disposeBag)
        

        didLoad.onNext(())
        weightTrainingArrayIndexRx.onNext(0)
    }
    override func setComponents() {
        super.setComponents()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DuringSetTableViewCell.self, forCellReuseIdentifier: DuringSetTableViewCell.identifier)
        tableView.register(DuringSetFooterCell.self, forHeaderFooterViewReuseIdentifier: DuringSetFooterCell.footerViewID)
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(tableView)
    }
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(14)
            $0.leading.trailing.equalToSuperview().inset(26)
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        super.actions()
    }
}
// MARK: - EXTENSIONs

extension DuringSetViewController : UITableViewDelegate, UITableViewDataSource, DuringSetFooterDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteSetTrigger.onNext(())
            deleteSetIndex.onNext(indexPath.row)
            deleteWeightTrainingArrayIndex.onNext(weightTrainingArrayIndex)
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightTrainingInfoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DuringSetTableViewCell.identifier, for: indexPath) as? DuringSetTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureCell(weightTrainingInfoArray[indexPath.row])
        cell.checkCalisthenics(weightTraining ?? WeightTraining(bodyPart: "", weightTraining: "") )
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DuringSetFooterCell.footerViewID) as? DuringSetFooterCell else { return  nil }
            footerView.delegate = self
            return footerView
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func addWorkoutButtonTapped() {
        addWeightTrainingInfoTrigger.onNext(())
        addWeightTrainingInfoIndexTrigger.onNext(weightTrainingArrayIndex)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputWorkoutDataViewController = InputWorkoutDataViewController()
        inputWorkoutDataViewController.modalTransitionStyle = .crossDissolve
        inputWorkoutDataViewController.modalPresentationStyle = .overFullScreen
        inputWorkoutDataViewController.weightTrainingArrayIndex = weightTrainingArrayIndex
        inputWorkoutDataViewController.weightTrainingInfoArrayIndex = indexPath.row
        let isCalisthenics = Calisthenics.calisthenicsArray.contains(weightTraining?.weightTraining ?? "") ? true : false
        inputWorkoutDataViewController.isCalisthenics = isCalisthenics
        inputWorkoutDataViewController.completionHandler = { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }
        present(inputWorkoutDataViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 57
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제하기"
    }
}
