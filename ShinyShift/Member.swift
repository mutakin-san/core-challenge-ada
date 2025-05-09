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
    var status: Bool
    init(imagePath: String = "ProfilePicture", name: String, phone: String, address: String, status: Bool = true) {
        self.imagePath = imagePath
        self.name = name
        self.phone = phone
        self.address = address
        self.status = status
    }
    
    
    static var defaults: [Member] {
        [
            .init(name: "Maman", phone: "+6287678593933", address: "Jakarta"),
            .init(name: "Budi", phone: "+6287678593933", address: "Depok"),
            .init(name: "Nanang", phone: "+6287678593933", address: "Bandung"),
            .init(name: "Tatang", phone: "+6287678593933", address: "Tangsel"),
            .init(name: "Mahmud", phone: "+6287678593933", address: "BSD"),
            .init(name: "Rahmat", phone: "+6287678593933", address: "Bekasi"),
            .init(name: "Herman", phone: "+6287678593933", address: "Jaksel"),
            .init(name: "Suparman", phone: "+6287678593933", address: "Jaktim"),
            .init(name: "Supardi", phone: "+6287678593933", address: "Depok"),
            .init(name: "Gunawan", phone: "+6287678593933", address: "Bogor"),
            .init(name: "Suherman", phone: "+6287678593933", address: "Tasik"),
            .init(name: "Bambang", phone: "+6287678593933", address: "Pamulang"),
            .init(name: "Ujang", phone: "+6287678593933", address: "Serpong"),
            .init(name: "Dodi", phone: "+6287678593933", address: "Rawa Buntu"),
            .init(name: "Rahman", phone: "+6287678593933", address: "Serang"),
        ]
    }
}
