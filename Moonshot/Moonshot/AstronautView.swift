//
//  AustronautView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/10/22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .foregroundColor(.white)
                    .padding()
                
            }
        }.background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AustronautView_Previews: PreviewProvider {
    
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["chaffee"]!)
    }
}
