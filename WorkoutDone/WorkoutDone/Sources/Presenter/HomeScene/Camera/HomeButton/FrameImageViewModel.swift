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
        
        let realm = try! Realm()
        if let existingWorkOutDone = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: date.dateToInt()) {
            try! realm.write {
                existingWorkOutDone.frameImage = FrameImage(frameType: frameType, image: imageData)
            }
        } else {
            let workOutDone = WorkOutDoneData(id: date.dateToInt(), date: date.yyyyMMddToString())
            workOutDone.frameImage = FrameImage(frameType: frameType, image: imageData)
            
            try! realm.write {
                realm.add(workOutDone)
            }
        }
    }

    func loadImageFromRealm(date: Date) -> UIImage? {
        let realm = try! Realm()
        let workOutDone = realm.objects(WorkOutDoneData.self).filter("date == %@", date.yyyyMMddToString())
        
        guard let frameImage = workOutDone.first?.frameImage else { return nil }
        return UIImage(data: frameImage.image!)
    }
}
