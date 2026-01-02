import SwiftData

protocol DataManager {
    func createData<T: PersistentModel>(data: T)
    func createData<T: PersistentModel>(data: [T])
    func readData<T: PersistentModel & IntIdentifiable>(id: Int, type: T.Type) -> T?
    func readData<T: PersistentModel & StringIdentifiable>(id: String, type: T.Type) -> T?
    func updateData<T: PersistentModel>(data: T, updateBlock: (T) -> Void)
    func deleteData<T: PersistentModel>(data: T)
}
