//
//  CombineDisposeBag.swift
//  WorkoutDone
//
//  Created by Codex on 2025/02/14.
//

import Combine

public final class DisposeBag {
    private var cancellables = Set<AnyCancellable>()

    public init() {}

    public func store(_ cancellable: AnyCancellable) {
        cancellables.insert(cancellable)
    }
}

public extension AnyCancellable {
    func disposed(by bag: DisposeBag) {
        bag.store(self)
    }
}
