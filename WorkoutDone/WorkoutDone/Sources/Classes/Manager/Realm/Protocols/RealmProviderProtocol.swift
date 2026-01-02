import SwiftData

protocol SwiftDataContextProviding {
    func makeContext() -> ModelContext
}
