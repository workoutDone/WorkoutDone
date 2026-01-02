import SwiftData

final class MockSwiftDataProvider: SwiftDataContextProviding {
    private let container: ModelContainer

    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try! ModelContainer(
            for: WorkOutDoneData.self,
            FrameImage.self,
            BodyInfo.self,
            Routine.self,
            WeightTraining.self,
            WeightTrainingInfo.self,
            MyRoutine.self,
            MyWeightTraining.self,
            TemporaryRoutine.self,
            configurations: configuration
        )
    }

    func makeContext() -> ModelContext {
        return ModelContext(container)
    }
}
