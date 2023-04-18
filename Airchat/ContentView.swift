//
//  ContentView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/21/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("currentUserId") private var currentUserId = ""
    
    @State private var tab: Tab = .conversations
    
    enum Tab {
        case conversations
        case settings
    }
    
    var body: some View {
        if currentUserId.isEmpty {
            LoginView(currentUserId: $currentUserId)
        } else {
            TabView(selection: $tab) {
                ConversationsView(currentUserId: $currentUserId, user: getUser()!)
                    .tabItem {
                        Label("Messages", systemImage: "message")
                    }
                    .tag(Tab.conversations)
                
                SettingsView(currentUserId: $currentUserId)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(Tab.settings)
            }
            
        }
    }
    
    private func getUser() -> User? {
        let fetchRequest: NSFetchRequest<User>
        fetchRequest = User.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "id == %@", currentUserId
        )

        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                return user
            }
        } catch {
            print("bad")
            return nil
        }
        return nil
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
