import SwiftData

final class ProductionSwiftDataProvider: @MainActor SwiftDataContextProviding {
    @MainActor func makeContext() -> ModelContext {
        return SwiftDataStack.shared.context
    }
}
