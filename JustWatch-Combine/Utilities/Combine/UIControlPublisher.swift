//
//  UIControlPublisher.swift
//  JustWatch-Combine
//
//  Created by cleanmac-ada on 01/09/22.
//

import UIKit
import Combine

struct UIControlPublisher<Control: UIControl>: Publisher {
    
    typealias Output = Control
    typealias Failure = Never
    
    let control: Control
    let controlEvent: UIControl.Event
    
    init(control: Control, event: UIControl.Event) {
        self.control = control
        self.controlEvent = event
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output{
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvent)
        subscriber.receive(subscription: subscription)
    }
}
