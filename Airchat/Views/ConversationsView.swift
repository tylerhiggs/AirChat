//
//  ConversationsView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/26/22.
//

import SwiftUI
import CoreData

struct ConversationsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var currentUserId: String
    
    @ObservedObject var user: User
    
    private var chats: [Chat] {
        let set = user.chats as? Set<Chat> ?? []
        return set.sorted {
            $0.timestamp! < $1.timestamp!
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chats) { chat in
                    NavigationLink {
                        MessageView(messenger: chat.recipientName ?? "Unknown messenger", chat: chat)
                        Text("something")
                    } label: {
                        Text(chat.recipientName ?? "Unknown messenger")
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newChat = Chat(context: viewContext)
            newChat.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView(currentUserId: .constant(Constants.userId.uuidString), user: getMockData(viewContext: PersistenceController.preview.container.viewContext)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
