//
//  GalleryViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/09.
//

import UIKit
import RealmSwift

struct GalleryViewModel {
    func loadImagesForMonth() -> [String: [(String, UIImage)]] {
        let realm = try! Realm()
        
        let workOutDoneData : [WorkOutDoneData] = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).compactMap{$0}
        var monthImages = [String: [(String, UIImage)]]()
        
        for workOutDone in workOutDoneData {
            if let date = workOutDone.date.yyMMddToDate(), let imageData = workOutDone.frameImage?.image, let image = UIImage(data: imageData) {
                monthImages[isCurrentYear(date: date) ? date.MToString() : date.yyyyMMToString(), default: []].append((date.yyyyMMddToString(), image))
            }
        }
        
        return Dictionary(uniqueKeysWithValues: monthImages.sorted(by: {$0.key > $1.key}))
    }
    
    func loadImagesForFrame(frameIndex: Int) -> [(String, UIImage)] {
        let realm = try! Realm()
        
        let workOutDoneData = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).filter("frameImage.frameType == %@", frameIndex)
        var images = [(String, UIImage)]()
        
        for dateImage in workOutDoneData {
            if let imageData = dateImage.frameImage?.image, let image = UIImage(data: imageData) {
                images.append((dateImage.date, image))
            }
        }
        
        return images
    }
    
    func isCurrentYear(date: Date) -> Bool {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let currentYear = calendar.component(.year, from: Date())
        
        return year == currentYear
    }
    
    func deleteImage(date: String) {
        let realm = try! Realm()
        
        let imageData = realm.objects(WorkOutDoneData.self).filter("date == %@", date).first!
        
        guard let frameImage = imageData.frameImage else { return }
        
        try! realm.write {
            realm.delete(frameImage)
        }
    }
}
