//
//  EmployeeView.swift
//  EmployeesList
//
//  Created by Miha on 16/10/2024.
//

import SwiftUI

struct EmployeeView: View {
    @State var name: String = ""
    @State var lastName: String = ""
    @State var age: String = ""
    private let saveFunction: (Employee) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    init(saveFunction: @escaping (Employee) -> Void) {
        self.saveFunction = saveFunction
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0){
            TextField("Enter name", text: $name)
                .frame(height: 50)
                .padding(.horizontal, 10.0)
                .border(.gray, width: 2.0)
                
            TextField("Enter last name", text: $lastName)
                .frame(height: 50)
                .padding(.horizontal, 10.0)
                .border(.gray, width: 2.0)
            
            TextField("Enter age", text: $age)
                .frame(height: 50)
                .padding(.horizontal, 10.0)
                .border(.gray, width: 2.0)
                .keyboardType(.numberPad)
        }
        .padding(.horizontal, 16.0)
        Button("Save data") {
            if !name.isEmpty && !lastName.isEmpty && !age.isEmpty {
                saveFunction(.init(id: UUID(),
                                   name: name,
                                   lastName: lastName,
                                   age: Int(age) ?? 0))
                dismiss()
            }
        }
        
        Spacer()
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView(saveFunction: { employee in
            print(employee)
        })
    }
}

