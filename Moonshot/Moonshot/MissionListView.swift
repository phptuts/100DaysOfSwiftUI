//
//  MissionListView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/11/22.
//

import SwiftUI

struct MissionListView: View {
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()

                          VStack {
                            Text(mission.displayName)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                            
                         }
                        
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(.lightBackground)
                }.clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                
            }
        }
    }
}

struct MissionListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionListView(missions: missions, astronauts: astronauts)
    }
}
