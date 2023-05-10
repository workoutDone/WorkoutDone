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
            if let date = workOutDone.date.yyMMddToDate()?.MToString(), let imageData = workOutDone.frameImage?.image, let image = UIImage(data: imageData) {
                monthImages[date, default: []].append(image)
            }
        }
        
        return Dictionary(uniqueKeysWithValues: monthImages.sorted(by: {$0.key > $1.key}))
    }
    
    func loadImagesForFrame(frameIndex: Int) -> [UIImage] {
        let realm = try! Realm()
        
        let imagesData : [Data] = realm.objects(FrameImage.self).filter("frameType == %@", frameIndex).map{$0.image}.compactMap{$0}
        let images = imagesData.compactMap { UIImage(data: $0) }

        return images
    }
}