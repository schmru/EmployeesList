//
//  Double+Extensions.swift
//  EmployeesList
//
//  Created by Miha on 19/10/2024.
//

import Foundation

extension Double {
    func trunc(_ decimal:Int) -> Double {
        var temp = self
        let multiplier = pow(10, Double(decimal))
        temp = Double(Int(temp*multiplier))/multiplier
        return temp
    }
}
