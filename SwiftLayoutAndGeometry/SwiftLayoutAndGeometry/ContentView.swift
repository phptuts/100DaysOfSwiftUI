//
//  ContentView.swift
//  SwiftLayoutAndGeometry
//
//  Created by Noah Glaser on 10/18/22.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: (geo.frame(in: .global).midY / fullView.size.height) > 1 ? 1 : (geo.frame(in: .global).midY / fullView.size.height), saturation: 0.8, brightness: 0.9))
                            .opacity(geo.frame(in: .global).midY < 200 ?
                                     geo.frame(in: .global).midY / 500 : 1
                            )
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect( 0.5 + (geo.frame(in: .global).midY / fullView.frame(in: .global).size.height))
                            
                    }
                    .frame(height: 40)
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
