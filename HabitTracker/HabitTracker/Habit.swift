//
//  Habit.swift
//  HabitTracker
//
//  Created by Noah Glaser on 6/20/22.
//

import Foundation

struct Habit: Codable, Identifiable {
    
    var id: UUID
    var name: String
    var description: String
    var streak: Int
    
    init(name: String, description: String, streak: Int) {
        self.name = name
        self.description = description
        self.streak = streak
        self.id = UUID()
    }
    
}

class HabitStore: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            self.save()
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        let defaults = UserDefaults.standard
        if let jsonString = defaults.data(forKey: "habits") {
            if let newHabits = try? decoder.decode([Habit].self, from: jsonString) {
                habits = newHabits
            }
        }
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
    
    func editHabit(_ habit: Habit) {
        habits = habits.map { h in
            if (h.id == habit.id) {
                return habit
            }
            
            return h
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let habitString = try? encoder.encode(habits) {
            UserDefaults.standard.set(habitString, forKey: "habits")
        }
        print("SAVED CALLED")
    }
}
