//
//  FrameImageViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/01.
//

import UIKit
import SwiftData

class FrameImageViewModel {
    private let dataManager = SwiftDataManager.shared

    func saveImageToRealm(date: Date, frameType: Int, image: UIImage) {
        guard let imageData = image.pngData() else { return }
        let id = date.dateToInt()
        if let existingWorkOutDone = dataManager.readData(id: id, type: WorkOutDoneData.self) {
            dataManager.updateData(data: existingWorkOutDone) { updatedData in
                updatedData.frameImage = FrameImage(frameType: frameType, image: imageData)
            }
        } else {
            let workOutDone = WorkOutDoneData(id: id, date: date.yyyyMMddToString(), frameImage: FrameImage(frameType: frameType, image: imageData))
            dataManager.createData(data: workOutDone)
        }
    }

    func loadImageFromRealm(date: Date) -> UIImage? {
        let dateString = date.yyyyMMddToString()
        let predicate = #Predicate<WorkOutDoneData> { $0.date == dateString }
        var descriptor = FetchDescriptor<WorkOutDoneData>(predicate: predicate)
        descriptor.fetchLimit = 1
        let workOutDone = try? dataManager.context.fetch(descriptor).first
        guard let frameImage = workOutDone?.frameImage else { return nil }
        return UIImage(data: frameImage.image!)
    }
}
