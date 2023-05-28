//
//  RoutineEditorViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class RoutineEditorViewController: BaseViewController {
    var sampleData = ["벤치 프레스", "벤치 프레스2", "벤치 프레스3", "벤치 프레스4", "ㅠㅠ"]
    
    private let nameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "이 루틴의 이름은 무엇인가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.colorCCCCCC])
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.layer.cornerRadius = 15
        $0.addLeftPadding(padding: 21)
        
        $0.textColor = .color121212
        $0.font = .pretendard(.regular, size: 16)
    }
    
    private let routineTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(RoutineEditorCell.self, forCellReuseIdentifier: "routineEditorCell")
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: -28, left: 0, bottom: -42, right: 0)
        $0.isEditing = true
        
        $0.backgroundColor = .colorF8F6FF
    }
    
    private let stampView = StampView()
    
    private let saveButton = GradientButton(colors: [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]).then {
        $0.setTitle("이대로 할게요", for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .colorFFFFFF
        title = "루틴 만들기"
    }
    
    override func setupLayout() {
        [nameTextField, routineTableView, stampView, saveButton].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setupConstraints() {
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(136)
            $0.leading.equalTo(28)
            $0.trailing.equalTo(-28)
            $0.height.equalTo(62)
        }
        
        routineTableView.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(-28)
            $0.bottom.equalTo(stampView.snp.top).offset(-28)
        }
        
        stampView.snp.makeConstraints {
            $0.top.equalTo(routineTableView.snp.bottom).offset(28)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(saveButton.snp.top).offset(-19)
            $0.height.equalTo(73)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-55)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(58)
        }
    }
    
    override func setComponents() {
        routineTableView.delegate = self
        routineTableView.dataSource = self
        
        stampView.delegate = self
    }
    
    override func actions() {
        nameTextField.addTarget(self, action: #selector(self.didChangeTextField), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if nameTextField.text != "" {
            nameTextField.font = .pretendard(.bold, size: 16)
            
            if stampView.isSelectStampIndex >= 0 {
                saveButton.gradient.colors = [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
            }
        } else {
            nameTextField.font = .pretendard(.regular, size: 16)
            
            saveButton.gradient.colors = [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]
        }
    }
    
    @objc func saveButtonTapped() {
        if nameTextField.text != "" && stampView.isSelectStampIndex >= 0 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension RoutineEditorViewController : StampDelegate {
    func stampTapped() {
        if nameTextField.text != "" && stampView.isSelectStampIndex >= 0 {
            saveButton.gradient.colors = [UIColor.color8E36FF.cgColor, UIColor.color7442FF.cgColor]
        } else {
            saveButton.gradient.colors = [UIColor.colorCCCCCC.cgColor, UIColor.colorCCCCCC.cgColor]
        }
    }
}

extension RoutineEditorViewController : UITableViewDelegate, UITableViewDataSource {
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
