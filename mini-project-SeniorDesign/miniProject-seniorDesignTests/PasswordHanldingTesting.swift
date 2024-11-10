//
//  PasswordHanldingTesting.swift
//  miniProject-seniorDesign
//
//  Created by Jacob Fernandez on 11/9/24.
//
import Testing
import SwiftUI
@testable import miniProject_seniorDesign

struct PasswordHanldingTesting
{
    var salt: String
       var password: String
       var storedHash: String

    init() {
        // Sample password and salt for testing
        password = "Thisisuncrackable4258"
        salt = createSalt()
        storedHash = hashSaltPassword(password: password, salt: salt)
    }
    
    @Test func testCreateSalt()
    {
        let validCharacters = "abcdefghijklmnopqrtsuvwxyz0123456789"
        for char in salt{
            #expect(validCharacters.contains(char))
        }
    }
    @Test func testHashSaltPassword()
    {
        //should return the same thing everytime with the same password and salt
        let hashedPassword = hashSaltPassword(password: password, salt: salt)
        #expect(hashedPassword == storedHash)
    }
    
    @Test func testVerifyPasswordCorrect()
    {
        let isCorrect = verifyPassword(input: password, storedHash: storedHash, salt: salt)
        #expect(isCorrect == true)
    }
    @Test func testVerifyPasswordWrong()
    {
        let isWrong = verifyPassword(input: "Icancrackthis", storedHash: storedHash, salt: salt)
        #expect(isWrong == false)
    }
}
