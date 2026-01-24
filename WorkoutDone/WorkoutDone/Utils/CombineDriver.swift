//
//  CombineDriver.swift
//  WorkoutDone
//
//  Created by Codex on 2025/02/14.
//

import Combine
import Foundation

public struct Driver<Element> {
    public let publisher: AnyPublisher<Element, Never>

    public init(_ publisher: AnyPublisher<Element, Never>) {
        self.publisher = publisher
    }

    public static func just(_ value: Element) -> Driver<Element> {
        Driver(Just(value).eraseToAnyPublisher())
    }

    public func map<T>(_ transform: @escaping (Element) -> T) -> Driver<T> {
        Driver<T>(publisher.map(transform).eraseToAnyPublisher())
    }

    public func drive(onNext: @escaping (Element) -> Void) -> AnyCancellable {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: onNext)
    }

    public static func combineLatest<A, B, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        resultSelector: @escaping (A, B) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.CombineLatest(a.publisher, b.publisher)
                .map(resultSelector)
                .eraseToAnyPublisher()
        )
    }

    public static func combineLatest<A, B, C, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        _ c: Driver<C>,
        resultSelector: @escaping (A, B, C) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.CombineLatest3(a.publisher, b.publisher, c.publisher)
                .map(resultSelector)
                .eraseToAnyPublisher()
        )
    }

    public static func combineLatest<A, B, C, D, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        _ c: Driver<C>,
        _ d: Driver<D>,
        resultSelector: @escaping (A, B, C, D) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.CombineLatest4(a.publisher, b.publisher, c.publisher, d.publisher)
                .map(resultSelector)
                .eraseToAnyPublisher()
        )
    }

    public static func combineLatest<A, B, C, D, E, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        _ c: Driver<C>,
        _ d: Driver<D>,
        _ e: Driver<E>,
        resultSelector: @escaping (A, B, C, D, E) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.CombineLatest4(a.publisher, b.publisher, c.publisher, d.publisher)
                .combineLatest(e.publisher)
                .map { resultSelector($0.0, $0.1, $0.2, $0.3, $1) }
                .eraseToAnyPublisher()
        )
    }

    public static func zip<A, B, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        resultSelector: @escaping (A, B) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.Zip(a.publisher, b.publisher)
                .map(resultSelector)
                .eraseToAnyPublisher()
        )
    }

    public static func zip<A, B, C, R>(
        _ a: Driver<A>,
        _ b: Driver<B>,
        _ c: Driver<C>,
        resultSelector: @escaping (A, B, C) -> R
    ) -> Driver<R> {
        Driver<R>(
            Publishers.Zip(a.publisher, b.publisher)
                .combineLatest(c.publisher)
                .map { resultSelector($0.0, $0.1, $1) }
                .eraseToAnyPublisher()
        )
    }
}

public extension Publisher where Failure == Never {
    func asDriver() -> Driver<Output> {
        Driver(
            self
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        )
    }
}
