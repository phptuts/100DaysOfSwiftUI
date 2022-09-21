//
//  ProspectView.swift
//  HotProspects
//
//  Created by Noah Glaser on 9/15/22.
//

import SwiftUI
import CodeScanner

struct ProspectView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortOption {
        case name, date, none
    }
    
    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    
    @State private var showError = false
    @State private var showSortOptions = false
    @State private var sortOption = SortOption.none
    

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredAndSorted) { prospect in
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            if filter == .none {
                               
                                if prospect.isContacted {
                                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                        .foregroundColor(.green)
                                    } else {
                                        Image(systemName: "person.crop.circle.badge.xmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                
                        }
                        
                        
                    }.swipeActions {
                        if prospect.isContacted {
                            Button {
                                do {
                                   try prospects.toggle(prospect)
                                } catch {
                                    showError = true
                                }
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                                    
                            }.tint(.blue)
                        } else {
                            Button {
                                do {
                                   try prospects.toggle(prospect)
                                } catch {
                                    showError = true
                                }
                                
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                                    
                            }.tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "ball")
                            }.tint(.orange)
                        }
                    }
                }
            }
            
            .navigationTitle(title + " \(showError)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSortOptions = true
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
               
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "\(["Bill", "Fred", "Ash", "Last"].randomElement() ??  "Fred")\nglaserpower@gmail.com", completion: handleScan)
            }
            .alert("Error Saving", isPresented: $showError) {
                Button("OK") {
                    
                }
            }
            .confirmationDialog("Sort By", isPresented: $showSortOptions) {
                Button("Name") {
                    sortOption = .name
                }
                Button("Newest Contact") {
                    sortOption = .date
                }
                Button("None") {
                    sortOption = .none
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var filteredAndSorted: [Prospect] {
        var peeps = [Prospect]()
        switch filter {
        case .none:
            peeps = prospects.people
        case .contacted:
            peeps = prospects.people.filter{ $0.isContacted}
        case .uncontacted:
            peeps = prospects.people.filter { !$0.isContacted }
        }
        
        switch sortOption {
        case .name:
            return peeps.sorted(by: { $0.name < $1.name })
        case .date:
            return peeps.sorted(by: { $0.created > $1.created })
        case .none:
            return peeps
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else  { return }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            do {
               try prospects.add(person)
            } catch {
                showError = true
            }
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(
                    options: [.alert, .badge, .sound],
                    completionHandler: { success, error  in
                        if success {
                            addRequest()
                        } else {
                            print("Failed permission")
                        }
                    })
                }
            }
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectView(filter: .none)
            .environmentObject(Prospects())
    }
}
