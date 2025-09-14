//
//  AppSubscription.swift
//  Example
//
//  Created by Dream on 2025/9/1.
//


import Combine

class AppSubscription {}

extension AppSubscription {
    
    class Token {
        var cancellable: AnyCancellable?
        func unseal() { cancellable = nil }
    }
}

extension AnyCancellable {
    func seal(in token: AppSubscription.Token) {
        token.cancellable = self
    }
}
