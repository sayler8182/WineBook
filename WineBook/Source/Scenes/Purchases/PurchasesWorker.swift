//
//  PurchasesWorker.swift
//  WineBook
//
//  Created by Konrad on 6/26/20.
//  Copyright © 2020 Limbo. All rights reserved.
//

import FormsNetworking
import Foundation

// MARK: PurchasesWorker
class PurchasesWorker {
    func purchases(onSuccess: @escaping (PurchasesResponse) -> Void,
                   onError: @escaping (NetworkError) -> Void) {
        NetworkMethods.purchases.purchases()
            .call(onSuccess: { (data: PurchasesResponse) in
                onSuccess(data)
            }, onError: { (error) in
                onError(error)
            }, onCompletion: nil)
    }
}
