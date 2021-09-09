//
//  Date + Diff.swift
//  AVITO_JSON
//
//  Created by admin on 09.09.2021.
//  Copyright © 2021 ZanLabEngine. All rights reserved.
//

import Foundation

extension Date {
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}
