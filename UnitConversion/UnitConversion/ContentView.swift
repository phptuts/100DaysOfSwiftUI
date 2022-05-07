//
//  ContentView.swift
//  UnitConversion
//
//  Created by Noah Glaser on 5/6/22.
//

import SwiftUI

enum Temperature: String, Equatable, CaseIterable, Comparable {
    static func < (lhs: Temperature, rhs: Temperature) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case Fahrenheit = "Fahrenheit"
    case Celcius = "Celcius"
    case Kelvin = "Kelvin"
}

struct ContentView: View {
    
    let unitTypes: [Temperature] = [.Celcius, .Fahrenheit, .Kelvin]
    
    @State var temperature: Double = 77
    
    @State var startingUnit: Temperature = .Fahrenheit
    
    @State var endingUnit: Temperature = .Celcius
    
    @FocusState var keyboardOn: Bool
    
    var outputTemp: Double {
        if (startingUnit == .Celcius && endingUnit == .Fahrenheit) {
            return (temperature * 9/5) + 32

        } else if (startingUnit == .Celcius && endingUnit == .Kelvin) {
            return temperature + 273.15
        } else if (startingUnit == .Kelvin && endingUnit == .Fahrenheit) {
            return (temperature - 273.15) * 9/5 + 32
        } else if (startingUnit == .Kelvin && endingUnit == .Celcius) {
            return temperature - 273.15
        } else if (startingUnit == .Fahrenheit && endingUnit == .Celcius) {
            return (temperature - 32) * (5/9)
        } else {
            return (25 - 32) * 5/9 + 273.15
        }
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardOn)

                } header: {
                    Text("Starting Temperature")
                }.navigationBarTitle("Temp Convertor")
                Section {
                    Picker("Start Units", selection: $startingUnit) {
                        ForEach(unitTypes.sorted(), id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Starting Units")
                }
                Section {
                    Picker("Ending Units", selection: $endingUnit) {
                        ForEach(unitTypes.filter { $0 != startingUnit }.sorted(), id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Ending Units")
                }
                Section {
                    Text(round(outputTemp * 1000) / 1000 , format: .number)
                } header: {
                    Text("Converted temperature")
                }
            }.toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        keyboardOn = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
