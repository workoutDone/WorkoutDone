//
//  GalleryViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/09.
//

import UIKit
import SwiftData

struct GalleryViewModel {
    func loadImagesForMonth() -> [String: [(String, UIImage)]] {
        let sortByDate = [SortDescriptor(\WorkOutDoneData.date, order: .reverse)]
        let descriptor = FetchDescriptor<WorkOutDoneData>(sortBy: sortByDate)
        let workOutDoneData: [WorkOutDoneData] = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
        var monthImages = [String: [(String, UIImage)]]()
        
        for workOutDone in workOutDoneData {
            if let date = workOutDone.date.yyMMddToDate(), let imageData = workOutDone.frameImage?.image, let image = UIImage(data: imageData) {
                monthImages[isCurrentYear(date: date) ? date.MToString() : date.yyyyMMToString(), default: []].append((date.yyyyMMddToString(), image))
            }
        }
        
        return Dictionary(uniqueKeysWithValues: monthImages.sorted(by: {$0.key > $1.key}))
    }
    
    func loadImagesForFrame(frameIndex: Int) -> [(String, UIImage)] {
        let predicate = #Predicate<WorkOutDoneData> { $0.frameImage?.frameType == frameIndex }
        let sortByDate = [SortDescriptor(\WorkOutDoneData.date, order: .reverse)]
        let descriptor = FetchDescriptor<WorkOutDoneData>(predicate: predicate, sortBy: sortByDate)
        let workOutDoneData = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
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
        let predicate = #Predicate<WorkOutDoneData> { $0.date == date }
        var descriptor = FetchDescriptor<WorkOutDoneData>(predicate: predicate)
        descriptor.fetchLimit = 1
        guard let imageData = try? SwiftDataManager.shared.context.fetch(descriptor).first,
              let frameImage = imageData.frameImage else { return }
        SwiftDataManager.shared.deleteData(data: frameImage)
    }
}
