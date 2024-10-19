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
    @State var gender: Int16 = 1
    private var id = UUID()
    private let saveFunction: (Employee) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    init(saveFunction: @escaping (Employee) -> Void,
         employee: Employee? = nil) {
        self.saveFunction = saveFunction
        if let employee = employee {
            id = employee.id
            _name = State(initialValue: employee.name)
            _lastName = State(initialValue: employee.lastName)
            _age = State(initialValue: "\(employee.age)")
            _gender = State(initialValue: employee.gender)
        }
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
            
            HStack {
                checkbox(index: 1)
                checkbox(index: 2)
            }
        }
        .padding(.horizontal, 16.0)
        
        Spacer()
            .frame(height: 10.0)
        
        Button("Save data") {
            if !name.isEmpty && !lastName.isEmpty && !age.isEmpty {
                saveFunction(.init(id: id,
                                   name: name,
                                   lastName: lastName,
                                   age: Int16(age) ?? 0,
                                   gender: gender))
                dismiss()
            }
        }
        
        Spacer()
    }
    
    @ViewBuilder
    func checkbox(index: Int16) -> some View {
        HStack{
            Image(systemName: gender == index ? "checkmark.square.fill" : "square")
                .foregroundColor(gender == index ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    gender = index
                }
            Text(index == 1 ? "Male" : "Female")
        }
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView(saveFunction: { employee in
            print(employee)
        })
    }
}

