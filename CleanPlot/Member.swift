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
}
