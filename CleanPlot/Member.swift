//
//  MemberModel.swift
//  CleanPlot
//
//  Created by Mutakin on 26/03/25.
//
import Foundation
import SwiftData

@Model
class Member {
    var imagePath: String
    @Attribute(.unique) var name: String
    var phone: String
    var address: String
    
    init(imagePath: String = "ProfilePicture", name: String, phone: String, address: String) {
        self.imagePath = imagePath
        self.name = name
        self.phone = phone
        self.address = address
    }
    
    
    static var defaults: [Member] {
        [
            .init(name: "Udin", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 1", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 2", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 3", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 4", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 5", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 6", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 7", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 8", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 9", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 10", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 11", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 12", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 13", phone: "000000000000", address: "Jakarta"),
            .init(name: "Udin 14", phone: "000000000000", address: "Jakarta"),
        ]
    }
}
