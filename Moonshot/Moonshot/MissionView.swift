//
//  MissionView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/10/22.
//

import SwiftUI

struct MissionView: View {
    
    
    
    let mission: Mission
    
    let crew: [CrewMember]
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                    if let launchDate = mission.launchDate {
                        Text(launchDate.formatted(date:.abbreviated, time: .omitted))
                            .padding()
                    }
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding()
                    MissionDetialView(mission: mission)
                    AstronautListView(crew: crew)
                    
                }.padding(.bottom)
            }
        }.navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = self.mission.createCrewMembers(astronauts: astronauts)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
