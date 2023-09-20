import RealmSwift

protocol DataManager {
    func createData<T>(data: T)
    func readData<T: Object>(id: Int, type: T.Type) -> T?
    func updateData<T: Object>(data: T, updateBlock: (T) -> Void)
    func deleteData<T>(data: T)
}
