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
    
    private let image = UIImageView().then {
        $0.backgroundColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF09
    }
    
    override func setupLayout() {
        view.addSubview(image)
    }
    
    override func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(178.5)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first!.location(in: self.view).y < image.frame.minY || touches.first!.location(in: self.view).y > image.frame.maxY {
            dismiss(animated: false)
        }
    }
}

