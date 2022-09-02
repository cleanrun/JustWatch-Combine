//
//  UIControlSubscription.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import UIKit
import Combine

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    
    private var subscriber: SubscriberType?
    private let control: Control
    
    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) {
        // Do nothing because we only want to send events
    }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }
}
