//
//  ContentView.swift
//  HabitTracker
//
//  Created by Noah Glaser on 6/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var habitList =  HabitStore()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(habitList.habits) { h in
                        let index = habitList.habits.firstIndex(where: { $0.id == h.id}) ?? 0
                        
                        HabitRow(habitList: habitList, habit: $habitList.habits[index])
                    }.onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                    .ignoresSafeArea(.all, edges: .horizontal)
                    

            }
            .navigationTitle("Habit List")
                .toolbar {
                    ToolbarItem {
                        NavigationLink{
                            AddHabitForm(habitList: habitList)
                        } label: {
                            Text("Add Habit")
                        }
                    }
                }
        }
    }
    func delete(at offsets: IndexSet) {
        habitList.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let habitList = HabitStore();
        habitList.addHabit(Habit(name: "Fish", description: "", streak: 3))
        habitList.addHabit(Habit(name: "Swim", description: "", streak: 3))
        return ContentView(habitList: habitList)
    }
}
