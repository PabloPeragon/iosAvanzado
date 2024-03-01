//
//  SecureDataProvider.swift
//  practicaIosAvanzado
//
//  Created by Pablo Jesús Peragón Garrido on 1/3/24.
//

import Foundation
import KeychainSwift


protocol SecureDataProtocol {
    func setToken(value: String)
    func getToken() -> String?
    func deleteToken()
    
}


class SecureDataKeychain: SecureDataProtocol {
    
    private let keyChain = KeychainSwift()
    private let keyToken = "keyToken"
    
    func setToken(value: String) {
        keyChain.set(value, forKey: keyToken)
    }
    
    func getToken() -> String? {
        keyChain.get(keyToken)
    }
    
    func deleteToken() {
        keyChain.delete(keyToken)
    }
}
