//
//  AddHabitForm.swift
//  HabitTracker
//
//  Created by Noah Glaser on 6/22/22.
//

import SwiftUI

struct AddHabitForm: View {
    
    @ObservedObject var habitList: HabitStore
    
    @State var name: String = ""
    
    @State var description = ""

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
                Form {
                    Section() {
                        TextField("Name", text: $name)
                    }
                    Section {
                        TextField("Description", text: $description)
                            .frame(height: 100)
                        
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button("Add Habit") {
                                if name.isEmpty {
                                    return
                                }
                                let habit = Habit(name: name, description: description, streak: 0)
                                habitList.addHabit(habit)
                                dismiss()
                            }
                            Spacer()
                        }
                        
                    }
                }
                .navigationTitle("Add Habit")
        
    }
}

struct AddHabitForm_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitForm(habitList: HabitStore())
    }
}
