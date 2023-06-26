//
//  GalleryDetailViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/01.
//

import UIKit
import SnapKit
import Then

class GalleryDetailViewController: BaseViewController {
    var frameX : CGFloat = 0
    var frameY : CGFloat = 0
    var size : CGFloat = 0
    
    var scaleX : CGFloat = 0
    var scaleY : CGFloat = 0
    
    var deleteButtonFrameY : CGFloat = 0

    var image = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let deleteButton = UIButton().then {
        $0.setTitle("사진 삭제", for: .normal)
        $0.setTitleColor(.colorF54968, for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 16)
        $0.backgroundColor = .colorFFEDF0
        $0.layer.cornerRadius = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupDeleteButtonConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performImageClickAnimation()
     
    }
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF.withAlphaComponent(0.9)
    }
    
    override func setupLayout() {
        view.addSubview(deleteButton)
        view.addSubview(image)
    }
    
    override func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(frameY + 73)
            $0.leading.equalToSuperview().offset(frameX)
            $0.width.height.equalTo(size)
        }
    }
    
    override func actions() {
        super.actions()
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    
    func setupDeleteButtonConstraints() {
        deleteButtonFrameY = view.frame.midY - ((view.frame.width * (4 / 3)) / 2) - 45.5
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(deleteButtonFrameY)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first!.location(in: self.view).y < image.frame.minY || touches.first!.location(in: self.view).y > image.frame.maxY {
           
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
                self.image.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                self.image.frame.origin.x = self.frameX
                self.image.frame.origin.y = self.frameY

            }, completion: { _ in
                self.dismiss(animated: false)
            })
        }
    }
    
    func performImageClickAnimation() {
        frameY = image.frame.minY
        scaleX = view.frame.width / size
        scaleY = view.frame.width / size
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.image.frame.origin.x = self.view.frame.midX - (self.size / 2)
            self.image.frame.origin.y = self.view.frame.midY - (self.size / 2)
            self.image.transform = CGAffineTransform(scaleX: self.scaleX + 0.2 , y: self.scaleY + 0.2)

        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                self.image.transform = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
            })
        })
    }
    
    @objc func deleteButtonTapped() {
        let deleteAlertVC = DeleteAlertViewController()
        deleteAlertVC.modalPresentationStyle = .overCurrentContext
        self.present(deleteAlertVC, animated: false)
    }
}
