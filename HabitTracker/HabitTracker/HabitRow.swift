//
//  HabitRow.swift
//  HabitTracker
//
//  Created by Noah Glaser on 6/21/22.
//

import SwiftUI

struct HabitRow: View {
    
        
    @ObservedObject var habitList: HabitStore
    
    @Binding var habit: Habit
    
    var body: some View {
        VStack {
            NavigationLink {
                EditHabitForm(habitList: habitList, habit: $habit)
                } label: {
                    HStack {
                        Text(habit.name)
                        Spacer()
                    }
            }
            Stepper("Streak \(habit.streak)", value: $habit.streak)
            GeometryReader { geo in
                Rectangle()
                    .frame(width: geo.size.width, height: 2)
                    .background(.black)
            }
        }.listRowSeparator(.hidden)
        
    }
}

struct HabitRow_Previews: PreviewProvider {
    @State static var habit = Habit(name: "Habit", description: "Description", streak: 0)
    @State static var store = HabitStore()

    static var previews: some View {
        


        return HabitRow( habitList: store, habit: $habit)
    }
}
