import SwiftData
import Foundation

final class SwiftDataManager: DataManager {
    static let shared = SwiftDataManager(context: SwiftDataStack.shared.context)

    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func createData<T: PersistentModel>(data: T) {
        context.insert(data)
        saveContext()
    }

    func createData<T: PersistentModel>(data: [T]) {
        data.forEach { context.insert($0) }
        saveContext()
    }

    func readData<T: PersistentModel & IntIdentifiable>(id: Int, type: T.Type) -> T? {
        let predicate = #Predicate<T> { $0.id == id }
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func readData<T: PersistentModel & StringIdentifiable>(id: String, type: T.Type) -> T? {
        let predicate = #Predicate<T> { $0.id == id }
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func updateData<T: PersistentModel>(data: T, updateBlock: (T) -> Void) {
        updateBlock(data)
        saveContext()
    }

    func deleteData<T: PersistentModel>(data: T) {
        context.delete(data)
        saveContext()
    }

    func fetchAll<T: PersistentModel>(_ type: T.Type) -> [T] {
        let descriptor = FetchDescriptor<T>()
        return (try? context.fetch(descriptor)) ?? []
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
