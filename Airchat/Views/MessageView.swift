//
//  MesssageView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/26/22.
//

import SwiftUI
import CoreData

struct MessageView: View {
    var messenger: String
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var chat: Chat
    
    private var messagesSorted: [Message] {
        let set = chat.messages as? Set<Message> ?? []
        return set.sorted {
            $0.timestamp! < $1.timestamp!
        }
    }
    
        
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.messagesSorted, id: \.id) { (message: Message) in
                    if message.sent {
                        HStack {
                            Spacer()
                            Text(message.text ?? "")
                                .foregroundColor(.black)
                                .padding(.vertical, 2)
                                .padding(.horizontal)
                                .background {
                                    Capsule(style: .continuous)
                                        .stroke(.black)
                                }
                                .padding()
                        }
                    } else {
                        HStack {
                            Text(message.text ?? "")
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                                .padding(.horizontal)
                                .background(
                                    Capsule(style: .continuous)
                                )
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle(messenger)

    }
}

struct MesssageView_Previews: PreviewProvider {
    
    static var previews: some View {
        MessageView(messenger: "Cindy", chat: getChat(viewContext: PersistenceController.preview.container.viewContext)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
