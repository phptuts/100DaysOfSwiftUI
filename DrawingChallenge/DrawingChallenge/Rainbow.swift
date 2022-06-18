//
//  Rainbow.swift
//  DrawingChallenge
//
//  Created by Noah Glaser on 6/17/22.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    
    let amount: Double
    let steps = 100
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(LinearGradient(colors: [
                    color(for: value, brightness: 1),
                    color(for: value, brightness: 0.5)
                    ], startPoint: startPoint, endPoint: endPoint))
            }
        }.drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        
        let color = Color(hue: targetHue, saturation: 1, brightness: brightness)
                
        return color
    }
}

struct Rainbow: View {
    
    @State  private var startPoint: UnitPoint = .top
    @State  private var endPoint: UnitPoint = .bottom
    @State private var amount = 0.0
    var unitPoints = [
        (point: UnitPoint.top, string: "top"),
        (point: UnitPoint.center, string: "center"),
        (point: UnitPoint.bottom, string: "bottom")
     ]
    
    var body: some View {
        ColorCyclingRectangle(amount: amount, startPoint: startPoint, endPoint: endPoint)
            .frame(width: 300, height: 300)
        Picker("Start Point", selection: $startPoint) {
            ForEach(unitPoints, id: \.point) {
                Text("\($0.string)")
            }
        }
        Picker("End Point", selection: $endPoint) {
            ForEach(unitPoints, id: \.point) {
                Text("\($0.string)")
            }
        }
        Slider(value: $amount)
    }
}

struct Rainbow_Previews: PreviewProvider {
    static var previews: some View {
        Rainbow()
    }
}
