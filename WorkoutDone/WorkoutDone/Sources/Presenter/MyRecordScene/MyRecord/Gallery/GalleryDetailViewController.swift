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
    
    var deltaValue: CGFloat = 0
    
    private let image = UIImageView().then {
        $0.image = UIImage(named: "testImage")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        performImageClickAnimation()
    }
    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF09
    }
    
    override func setupLayout() {
        view.addSubview(image)
    }
    
    override func setupConstraints() {
        image.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(frameY + 73)
            $0.leading.equalToSuperview().offset(frameX)
            $0.width.height.equalTo(size)
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
        scaleY = 487 / size
        
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
}
