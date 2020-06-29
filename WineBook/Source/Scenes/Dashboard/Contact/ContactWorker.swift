//
//  ContactWorker.swift
//  WineBook
//
//  Created by Konrad on 6/25/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: ContactWorker
class ContactWorker {
    func contact(message: String?,
                 onSuccess: @escaping () -> Void,
                 onError: @escaping (NetworkError) -> Void) {
        let content = NetworkMethods.contact.contact.Content(
            message: message)
        NetworkMethods.contact.contact(content)
            .call(onSuccess: { _ in
                onSuccess()
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
