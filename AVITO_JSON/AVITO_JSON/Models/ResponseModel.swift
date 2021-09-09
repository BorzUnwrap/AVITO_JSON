//
//  ResponseModel.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import UIKit
import Foundation

struct ResponseModel: Codable {
    var company: Company
}

struct Employee: Codable {
    var name: String
    var employees: [Employee]
}

struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
        
    }

