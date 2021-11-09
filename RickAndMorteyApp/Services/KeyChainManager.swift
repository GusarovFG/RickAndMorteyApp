//
//  KeyChainManager.swift
//  RickAndMorteyApp
//
//  Created by Фаддей Гусаров on 06.11.2021.
//

import Foundation
import Locksmith

class KeyChainManager {

    static let shared = KeyChainManager()

    private init() {}

    let login: String = "Rick"
    let password: String = "Morty"


    func checkLoginCredentials(login: String, password: String) -> Bool {

        var checkCredentials = false
            do {
                try Locksmith.saveData(data: ["login" : self.login, "password" : self.password], forUserAccount: "RickAndMorteyAccount")
            } catch {
                print("Unable to save data")
            }

        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "RickAndMorteyAccount")

        if login == dictionary?["login"] as! String, password == dictionary?["password"] as! String {
            checkCredentials = true
        } else {
            checkCredentials = false
        }
        return checkCredentials
    }













//    func saveData(key: String, data: Data) -> OSStatus {
//
//        let query = [kSecClass as String : kSecClassGenericPassword as String,
//                     kSecAttrAccount as String : key,
//                     kSecValueData as String : data] as [String : Any]
//
//        SecItemDelete(query as CFDictionary)
//
//        return SecItemAdd(query as CFDictionary, nil)
//
//    }
//
//    func getKeyChainInData(key: String) -> Data? {
//
//        let query = [kSecClass as String: kSecClassGenericPassword as String,
//                     kSecAttrAccount as String : key,
//                     kSecReturnData as String : kCFBooleanTrue!,
//                     kSecMatchLimit as String : kSecMatchLimitOne] as [String : Any]
//
//        var dataTypeRef: AnyObject? = nil
//        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
//        if status == noErr {
//            return dataTypeRef as! Data?
//        } else {
//            return nil
//        }
//
//    }
}
