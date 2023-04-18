//
//  MockData.swift
//  Airchat
//
//  Created by Tyler Higgs on 12/10/22.
//

import Foundation
import CoreData

func getMockData(viewContext: NSManagedObjectContext) -> User {
    let messageTo = Message(context: viewContext)
    let messageFrom = Message(context: viewContext)
    messageTo.id = UUID()
    messageFrom.id = UUID()
    messageTo.sent = false
    messageFrom.sent = true
    messageTo.text = "You up?"
    messageFrom.text = "🍆"
    messageTo.timestamp = Date()
    messageFrom.timestamp = Date()
    let newChat = Chat(context: viewContext)
    newChat.id = Constants.chatId
    newChat.timestamp = Date()
    newChat.recipientName = "Cindy"
    newChat.messages = [messageFrom, messageTo]
    messageTo.chat = newChat
    messageFrom.chat = newChat
    let newUser = User(context: viewContext)
    newUser.id = Constants.userId
    newUser.name = "Tyler"
    newUser.email = "tyler@tyler.com"
    newUser.password = "password"
    newUser.chats = [newChat]
    return newUser
}

func getChat(viewContext: NSManagedObjectContext) -> Chat {
    let messageTo = Message(context: viewContext)
    let messageFrom = Message(context: viewContext)
    messageTo.id = UUID()
    messageFrom.id = UUID()
    messageTo.sent = false
    messageFrom.sent = true
    messageTo.text = "You up?"
    messageFrom.text = "🍆"
    messageTo.timestamp = Date()
    messageFrom.timestamp = Date()
    let newChat = Chat(context: viewContext)
    newChat.id = Constants.chatId
    newChat.timestamp = Date()
    newChat.recipientName = "Cindy"
    newChat.messages = [messageFrom, messageTo]
    messageTo.chat = newChat
    messageFrom.chat = newChat
    return newChat
}
