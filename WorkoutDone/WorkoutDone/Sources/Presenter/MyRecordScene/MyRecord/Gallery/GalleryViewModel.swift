//
//  GalleryViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/09.
//

import UIKit
import RealmSwift

struct GalleryViewModel {
    func loadImagesForMonth() -> [String: [UIImage]] {
        let realm = try! Realm()
        
        let workOutDoneData : [WorkOutDoneData] = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).compactMap{$0}
        var monthImages = [String: [UIImage]]()
        
        for workOutDone in workOutDoneData {
            if let date = workOutDone.date.yyMMddToDate(), let imageData = workOutDone.frameImage?.image, let image = UIImage(data: imageData) {
                monthImages[isCurrentYear(date: date) ? date.MToString() : date.yyyyMMToString(), default: []].append(image)
            }
        }
        
        return Dictionary(uniqueKeysWithValues: monthImages.sorted(by: {$0.key > $1.key}))
    }
    
    func loadImagesForFrame(frameIndex: Int) -> [UIImage] {
        let realm = try! Realm()
        
        let workOutDoneData = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).filter("frameImage.frameType == %@", frameIndex)
        let imagesData : [Data] = workOutDoneData.map{$0.frameImage?.image}.compactMap{$0}
         let images = imagesData.compactMap { UIImage(data: $0) }
        
        return images
    }
    
    func isCurrentYear(date: Date) -> Bool {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let currentYear = calendar.component(.year, from: Date())
        
        return year == currentYear
    }
}
