//
//  StatisticView.swift
//  EmployeesList
//
//  Created by Miha on 19/10/2024.
//

import SwiftUI

struct StatisticView: View {
    private var employees: [Employee]
    
    init(employees: [Employee]) {
        self.employees = employees
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Text(getAverageAge())
            Text(getPercentage())
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 10.0)
        Spacer()
    }
    
    private func getAverageAge() -> String {
        let count = employees.count
        var ageSum = 0.0
        let _ = employees.map({ageSum += Double($0.age)})
        return "Average age: \((ageSum/Double(count)).trunc(1))"
    }
    
    private func getPercentage() -> String {
        let men = employees.filter({ $0.gender == 1 })
        let menPercentage = Double(men.count)/Double(employees.count)*100
        
        return "Gender percentage: \(menPercentage.trunc(1))% men and \((100-menPercentage).trunc(1))% women"
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(employees: [])
    }
}
