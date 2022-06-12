//
//  AstronautListView.swift
//  Moonshot
//
//  Created by Noah Glaser on 6/11/22.
//

import SwiftUI

struct AstronautListView: View {
    
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Circle())
                                .overlay(Circle().strokeBorder(crewMember.role.contains("Command") ? .red : .white, lineWidth: 1))
                            
                            
                            VStack(alignment: .leading) {
                                
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(crewMember.role.contains("Command") ? .title.bold() : .headline)
                                Text(crewMember.role)
                                    .foregroundColor(crewMember.role.contains("Command") ? .white : .secondary)
                            }
                        }.padding(.horizontal)
                        
                    }
                }
            }
        }
    }
}

struct AstronautListView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautListView(crew: missions.first!.createCrewMembers(astronauts: astronauts))
    }
}
