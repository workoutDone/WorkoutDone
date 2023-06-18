//
//  WorkoutSequenceViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/31.
//

import UIKit

class WorkoutSequenceViewController: BaseViewController {
    var sampleData = ["벤치 프레스", "벤치 프레스2", "벤치 프레스3", "벤치 프레스4", "ㅠㅠ", "ㅠㅠㅠ", "ㅠ_ㅠ", "ㅠㅇㅠ", "ㅠㅅㅠ", "ㅠㅁㅠ", "ㅠㅂㅠ", "ㅠㅠㅠㅠㅠㅠㅠㅠ"]
    var isAddDeleteMode = false
    
    private var editButton = EditButton()
    
    private var weightTrainingTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(WorkoutSequenceCell.self, forCellReuseIdentifier: "workoutSequenceCell")
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorE6E0FF.cgColor
        
        $0.backgroundColor = .colorF8F6FF
    }
    
    private let startWorkoutButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("오늘의 운동 시작", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    private let createWeightTrainingButton = CreateWeightTrainingButton()
    
    private var adImage = UIImageView().then {
        $0.backgroundColor = .color3ED1FF.withAlphaComponent(0.2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .colorFFFFFF
       
        setNavigationBar()
        setBackButton()
    
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [weightTrainingTableView, startWorkoutButton,     createWeightTrainingButton, adImage].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        weightTrainingTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0)
        }

        startWorkoutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(adImage.snp.top).offset(-29)
            $0.height.equalTo(58)
        }
        
        createWeightTrainingButton.snp.makeConstraints {
            $0.top.equalTo(weightTrainingTableView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(62)
        }
        
        adImage.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    override func actions() {
        super.actions()
        
        startWorkoutButton.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
        createWeightTrainingButton.addTarget(self, action: #selector(createWeightTrainingButtonTapped), for: .touchUpInside)
    }
    
    override func setComponents() {
        super.setComponents()
        
        weightTrainingTableView.delegate = self
        weightTrainingTableView.dataSource = self
        
        weightTrainingTableView.dragDelegate = self
        weightTrainingTableView.dropDelegate = self
        weightTrainingTableView.dragInteractionEnabled = true
        
        createWeightTrainingButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        adjustTableViewHeight()
    }

    func setNavigationBar() {
        title = "운동하기"
        
        editButton = EditButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        editButton.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: editButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setBackButton() {
        let backButton = RoutineBackButton()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    func adjustTableViewHeight() {
        let height = min((15 * 2 + sampleData.count * 58), Int(view.frame.height - 119 - 113 - 58 - 26))
        weightTrainingTableView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        
        weightTrainingTableView.reloadData()
    }
    
    @objc func startWorkoutButtonTapped() {
        isAddDeleteMode = !isAddDeleteMode
        weightTrainingTableView.reloadData()
        
        if isAddDeleteMode {
            switchToAddDeleteMode()
        } else {
            switchToModifyMode()
        }
    }
    
    func switchToAddDeleteMode() {
        editButton.setText("수정 완료")
        startWorkoutButton.isHidden = true
        createWeightTrainingButton.isHidden = false
    }
    
    func switchToModifyMode() {
        editButton.setText("추가/삭제")
        startWorkoutButton.isHidden = false
        createWeightTrainingButton.isHidden = true
    }
    
    @objc func createWeightTrainingButtonTapped() {
        let workoutVC = WorkoutViewController()
        navigationController?.pushViewController(workoutVC, animated: false)
    }
}

extension WorkoutSequenceViewController : RemoveWorkoutDelegate {
    func removeButtonTapped(forCell cell: WorkoutSequenceCell) {
        guard let indexPath = weightTrainingTableView.indexPath(for: cell) else { return }
        
        sampleData.remove(at: indexPath.row)
        weightTrainingTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}

extension WorkoutSequenceViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutSequenceCell", for: indexPath) as? WorkoutSequenceCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegate = self
        
        cell.weightTrainingLabel.text = sampleData[indexPath.row]
        cell.editImage.isHidden = false
        cell.removeButton.isHidden = true
        
        if isAddDeleteMode {
            cell.editImage.isHidden = true
            cell.removeButton.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            sampleData.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = sampleData[sourceIndexPath.row]
        sampleData.remove(at: sourceIndexPath.row)
        sampleData.insert(moveCell, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}

