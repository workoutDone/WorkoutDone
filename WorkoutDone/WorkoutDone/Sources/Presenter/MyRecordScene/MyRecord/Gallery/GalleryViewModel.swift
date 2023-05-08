//
//  GalleryViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/09.
//

import UIKit
import RealmSwift

struct GalleryViewModel {
    func loadImagesForMonth() -> [[WorkOutDoneData]] {
        let realm = try! Realm()
        
        let workOutDone = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).filter("frameImage != nil")
        
        for dateImage in workOutDone {
            
        }
        
        return [[]]
    }
    
    func loadImagesForFrame(frameIndex: Int) -> [Data] {
        let realm = try! Realm()
        
        let images : [Data] = realm.objects(FrameImage.self).filter("frameType == %@", frameIndex).map{$0.image}.compactMap{$0}

        return images
    }
}
