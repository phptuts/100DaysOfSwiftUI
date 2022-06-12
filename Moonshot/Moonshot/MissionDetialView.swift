//
//  MissionDetialView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/11/22.
//

import SwiftUI

struct MissionDetialView: View {
    
    let mission: Mission
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding()
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
            
        }.padding(.horizontal)
    }
}

struct MissionDetialView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionDetialView(mission: missions.first!)
    }
}
