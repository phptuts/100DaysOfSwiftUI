//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Noah Glaser on 6/20/22.
//

import SwiftUI

struct EditHabitForm: View {
    
    @ObservedObject var habitList: HabitStore
    
    @Binding var habit: Habit

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
                Form {
                    Section() {
                        TextField("Name", text: $habit.name)
                    }
                    Section {
                        TextField("Description", text: $habit.description)
                            .frame(height: 100)
                        
                    }
                    Section {
                        Stepper("Streak \(habit.streak)", value: $habit.streak)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button("Done") {
                                dismiss()
                            }
                            Spacer()
                        }
                        
                    }
                }
                .navigationTitle("Edit Habit")
    }
}

struct AddHabit_Previews: PreviewProvider {
    @State static var habit = Habit(name: "Habit", description: "Description", streak: 0)
    @State static var store = HabitStore()

    static var previews: some View {
        
        
        EditHabitForm(habitList: store, habit: $store.habits[0])
    }
}
