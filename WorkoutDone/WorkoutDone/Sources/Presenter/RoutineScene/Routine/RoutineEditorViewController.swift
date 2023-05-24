//
//  RoutineEditorViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class RoutineEditorViewController: BaseViewController {
    private let nameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "이 루틴의 이름은 무엇인가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.colorCCCCCC])
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.color7442FF.cgColor
        $0.layer.cornerRadius = 15
        $0.addLeftPadding(padding: 21)
        $0.font = .pretendard(.regular, size: 16)
    }
    
    private let routineTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(RoutineEditorCell.self, forCellReuseIdentifier: "routineEditorCell")
        $0.separatorStyle = .none
        $0.sectionHeaderHeight = 0
        $0.sectionFooterHeight = 0
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
    }
    
    override func actions() {
     
    }
}

extension RoutineEditorViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineEditorCell", for: indexPath) as? RoutineEditorCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
}
