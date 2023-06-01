//
//  WorkoutSequenceViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/31.
//

import UIKit

class WorkoutSequenceViewController: BaseViewController {
    var sampleData = ["벤치 프레스", "벤치 프레스2", "벤치 프레스3", "벤치 프레스4", "ㅠㅠ"]
    
    private let weightTraingsTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(RoutineEditorCell.self, forCellReuseIdentifier: "routineEditorCell")
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: -28, left: 0, bottom: -42, right: 0)
        $0.isEditing = true
        
        $0.backgroundColor = .colorF8F6FF
    }
    
    private let startWorkoutButton = GradientButton(colors: [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]).then {
        $0.setTitle("오늘의 운동 시작", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    private var adImage = UIImageView().then {
        $0.backgroundColor = .color3ED1FF.withAlphaComponent(0.2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .colorFFFFFF
       
        setNavigationBar()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [weightTraingsTableView, startWorkoutButton, adImage].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        weightTraingsTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(startWorkoutButton.snp.top)
        }
        
        startWorkoutButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(adImage.snp.top).offset(-29)
            $0.height.equalTo(58)
        }
        
        adImage.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
    
    override func actions() {
        super.actions()
        
        //startWorkoutButton.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
    }
    
    override func setComponents() {
        weightTraingsTableView.delegate = self
        weightTraingsTableView.dataSource = self
    }

    func setNavigationBar() {
        title = "운동하기"
        
        let addOrRemoveButton = AddOrRemoveButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        addOrRemoveButton.addTarget(self, action: #selector(startWorkoutButtonTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: addOrRemoveButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func startWorkoutButtonTapped() {
        print("hi")
    }
}

extension WorkoutSequenceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineEditorCell", for: indexPath) as? RoutineEditorCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.weightTrainingLabel.text = sampleData[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.colorC8B4FF.cgColor
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .colorFFFFFF
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // editing 버튼 제거
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // 버튼 여백 제거
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // 셀 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removed = sampleData.remove(at: sourceIndexPath.row)
        sampleData.insert(removed, at: destinationIndexPath.row)
    }
}

