//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Noah Glaser on 5/10/22.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    
    
    var body: some View {
        VStack(spacing: 10) {
            Text("HELLO")
                .modifier(Title())
            Text("BLUE")
                .titleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
