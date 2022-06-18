//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Noah Glaser on 6/17/22.
//

import SwiftUI

struct Arrow:  Shape {
        
    
    
    var width: CGFloat
    
    var animatableData: CGFloat {
        get { width }
        set { width = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX , y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        path.addRect(CGRect(x: rect.midY - animatableData / 2, y: rect.midY, width: animatableData, height: rect.midY))

        return path
    }
    
    
}


struct ContentView: View {
    @State private var width = 30.0
    var body: some View {
        NavigationView {
            VStack {
                Text("Thickness: \(String(format: "%.2f", width))pts")
                    .font(.title)
                    .bold()
                let arrow = Arrow(width: width)
                    
                arrow.fill(.red)
                    .overlay(arrow.stroke(.blue, lineWidth: 5))
                     .frame(width: 200, height: 200)
                     .padding(20)
                
                Button("Animate Arrow") {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 2)) {
                        width = Double.random(in: 5.0...100.0)
                    }
                }
                NavigationLink {
                    Rainbow()
                        
                } label: {
                    Text("Rainbow Challenge")
                }
                
            }.navigationTitle("Shape Challenge")
        }
        
       
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
