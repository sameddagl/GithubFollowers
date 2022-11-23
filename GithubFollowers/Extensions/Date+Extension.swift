//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by Samed Dağlı on 22.11.2022.
//

import UIKit

extension Date {
    func convertToMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
        
//        if #available(iOS 15.0, *) {
//            let convertedDate = formatted(.dateTime.month(.wide).year(.defaultDigits))
//            return String(convertedDate)
//
//        } else {
//
//        }
    }
}
