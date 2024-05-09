//
//  DoubleExtension.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import Foundation
extension Double{
    var currencyString: String{
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        var formattedString = ""
        if let convertedString = formatter.string(from: NSNumber(value: self)){
            formattedString = convertedString
        }else{
            formattedString = String(self)
        }

         return formattedString
    }
}
