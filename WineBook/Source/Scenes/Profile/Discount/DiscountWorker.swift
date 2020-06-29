//
//  DiscountWorker.swift
//  WineBook
//
//  Created by Konrad on 6/24/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: DiscountWorker
class DiscountWorker {
    func discount(onSuccess: @escaping (DiscountResponse) -> Void,
                  onError: @escaping (NetworkError) -> Void) {
        NetworkMethods.profile.discount()
            .call(onSuccess: { (data: DiscountResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
