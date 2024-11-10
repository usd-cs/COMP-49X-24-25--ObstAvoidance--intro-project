//
//  PasswordHander.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/9/24.
//


import SwiftUI
import SwiftData
import Foundation
import CryptoKit



func createSalt()->String
{
    let characters = "abcdefghijklmnopqrtsuvwxyz0123456789"
    var salt = ""
    var i = 0
    while i <= 15
    {
        let index = Int(arc4random_uniform(UInt32(characters.count)))
        let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: index)]
        salt.append(randomCharacter)
        i+=1
    }
    return salt
}

func hashSaltPassword(password:String, salt: String) ->String
{
    //Converts the password to Data to store it in bytes
    let passwordData = Data(password.utf8)
    let saltData = Data(salt.utf8)
    var saltPassword = passwordData
    saltPassword.append(saltData)
    //hashes password
    let hash = SHA256.hash(data: saltPassword)
    //takes bytes and converts them to strings
    let byteConverter = hash.compactMap{ String(format: "%02x", $0)}
    //Combines all invidual strings to a single string
    let hashedPassword = byteConverter.joined()
    
    return hashedPassword
}

func verifyPassword(input: String, storedHash: String, salt: String)-> Bool
{
    let hashSaltPassword = hashSaltPassword(password: input, salt: salt)
    return hashSaltPassword == storedHash
}
