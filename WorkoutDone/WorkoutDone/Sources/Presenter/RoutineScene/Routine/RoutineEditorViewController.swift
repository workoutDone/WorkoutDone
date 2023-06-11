//
//  RoutineEditorViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class RoutineEditorViewController: BaseViewController {
    var routineViewModel = RoutineViewModel()
    var myRoutine = MyRoutine()
    var myWeightTraining = [MyWeightTraining]()
    var routineId: String?
    var draggedItem: String = ""
    
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
        
        setRoutineName()
        setRoutineStamp()
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
        setBackButton()
        
        routineTableView.delegate = self
        routineTableView.dataSource = self
        
        routineTableView.dragDelegate = self
        routineTableView.dropDelegate = self
        routineTableView.dragInteractionEnabled = true
        
        stampView.delegate = self
    }
    
    override func actions() {
        nameTextField.addTarget(self, action: #selector(self.didChangeTextField), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setBackButton() {
        let backButton = RoutineBackButton()
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setRoutineName() {
        guard let id = routineId else { return }
        nameTextField.text = routineViewModel.loadMyRoutineName(id: id)
    }
    
    func setRoutineStamp() {
        guard let id = routineId else { return }
        print(routineViewModel.loadMyRoutineStamp(id: id))
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
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
            routineViewModel.saveMyRoutine(id: routineId, name: nameTextField.text ?? "", stamp: "ㅠ", weightTraining: myWeightTraining)
            
            if let routineVC = self.navigationController?.viewControllers.first as? RoutineViewController {
                routineVC.loadMyRoutine()
            }
            
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

extension RoutineEditorViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWeightTraining.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routineEditorCell", for: indexPath) as? RoutineEditorCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.bodyPartLabel.text = myWeightTraining[indexPath.row].myBodyPart
        cell.weightTrainingLabel.text = myWeightTraining[indexPath.row].myWeightTraining
        cell.backgroundColor = .clear
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            myWeightTraining.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = myWeightTraining[sourceIndexPath.row]
        myWeightTraining.remove(at: sourceIndexPath.row)
        myWeightTraining.insert(moveCell, at: destinationIndexPath.row)
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
