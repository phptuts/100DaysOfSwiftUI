//
//  ContentView.swift
//  BetterRest
//
//  Created by Noah Glaser on 5/14/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    
    @State private var sleepAmount = 8.0
    
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    
    @State private var alertMessage = ""
    
    @State private var showAlert = false
    
    var sleepAmountOptions: [Double] {
        var options = [Double]()
        var currentOption: Double = 4.0
        while currentOption <= 12.0 {
            options.append(currentOption)
            currentOption += 0.25
        }
        
        return options
    }
    
   private var suggestedBedTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let predicton = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            return wakeUp - predicton.actualSleep
            
        } catch  {
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bed time"
            showAlert = true
        }
   
       return Self.defaultWakeTime
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Desired amount of sleep") {
                    Picker("\(sleepAmount.formatted()) hours", selection: $sleepAmount) {
                        ForEach(sleepAmountOptions, id: \.self) {
                            Text(String($0.formatted()))
                        }
                    }
                }
                Section("Daily coffee intake") {
                Stepper(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
                Section("Bed Time") {
                    Text("\(suggestedBedTime.formatted(date: .omitted, time: .shortened))").font(.largeTitle)
                        .bold()
                }
            }
            .navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedtime)
//            }.alert(alertTitle, isPresented: $showAlert) {
//                Button("OK") {
//
//                }
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let predicton = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - predicton.actualSleep
            alertTitle = "Your ideal bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch  {
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bed time"
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
