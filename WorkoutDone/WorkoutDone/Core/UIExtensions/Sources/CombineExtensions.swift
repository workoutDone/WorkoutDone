//
//  CombineExtensions.swift
//  WorkoutDone
//
//  Created by Codex on 2025/02/14.
//

import Combine
import UIKit

public extension UIControl {
    func publisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        ControlEventPublisher(control: self, event: event)
            .eraseToAnyPublisher()
    }
}

public extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        publisher(for: .touchUpInside)
    }
}

public extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { [weak self] in self?.text ?? "" }
            .prepend(text ?? "")
            .eraseToAnyPublisher()
    }
}

private struct ControlEventPublisher: Publisher {
    typealias Output = Void
    typealias Failure = Never

    let control: UIControl
    let event: UIControl.Event

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
        let subscription = ControlEventSubscription(subscriber: subscriber, control: control, event: event)
        subscriber.receive(subscription: subscription)
    }
}

private final class ControlEventSubscription<S: Subscriber>: Subscription where S.Input == Void, S.Failure == Never {
    private var subscriber: S?
    private weak var control: UIControl?
    private let event: UIControl.Event

    init(subscriber: S, control: UIControl, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        self.event = event
        control.addTarget(self, action: #selector(handleEvent), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        // UIControl events are user-driven; no backpressure handling needed.
    }

    func cancel() {
        control?.removeTarget(self, action: #selector(handleEvent), for: event)
        subscriber = nil
    }

    @objc private func handleEvent() {
        _ = subscriber?.receive(())
    }
}
