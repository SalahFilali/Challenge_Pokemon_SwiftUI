//
//  Date+extension.swift
//  Pokemon
//
//  Created by Salah Filali on 11/5/2022.
//

import Foundation

extension Date {
    
    func dateToString(with format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateWithFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: Date())
        return dateFormatter.date(from: dateString)
    }
    
}

