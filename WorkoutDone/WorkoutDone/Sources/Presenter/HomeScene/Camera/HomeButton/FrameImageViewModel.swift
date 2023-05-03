//
//  FrameImageViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/01.
//

import UIKit
import RealmSwift

class FrameImageViewModel {
    func saveImageToRealm(date: Date, frameType: Int, image: UIImage) {
        guard let imageData = image.pngData() else { return }
        
        let workOutDone = WorkOutDoneData(id: date.dateToInt(), date: date.yyyyMMddToString())
        workOutDone.frameImage = FrameImage(frameType: frameType, image: imageData)
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(workOutDone)
        }
    }

    func loadImageFromRealm(date: String) -> UIImage? {
        let realm = try! Realm()
        
        let workOutDone = realm.objects(WorkOutDoneData.self).filter("date == %@", date)

        guard let frameImage = workOutDone.first?.frameImage else { return nil }
        
        print(workOutDone)

        return UIImage(data: frameImage.image!)
    }
}
