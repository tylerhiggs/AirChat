//
//  SwiftUIView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/25/22.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var presentingSheet: Bool = false
    
    @Binding var currentUserId: String
    
    var body: some View {
        VStack {
            Image(systemName: "airplane.circle")
                .font(.system(size: 128))
                .padding(.top)
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                HStack {
                    Button {
                        tryLogin()
                    } label: {
                        Text("Login")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.all, 8)
                    }
                    .foregroundColor(.black)
                    .background(
                        Capsule(style: .continuous)
                            .stroke(.black)
                    )
                    Button {
                        presentingSheet.toggle()
                    } label: {
                        Text("Sign up")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.all, 8)
                    }
                    .foregroundColor(.white)
                    .background(
                        Capsule(style: .continuous)
                    )
                    
                }
                .padding()
                Spacer()
            }
        }
        .sheet(isPresented: $presentingSheet) {
            SignupView(currentUserId: $currentUserId, presentingSheet: $presentingSheet)
        }
    }
    
    private func tryLogin() {
        let fetchRequest: NSFetchRequest<User>
        fetchRequest = User.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "email == %@", email
        )

        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                if user.password == password {
                    currentUserId = user.id?.uuidString ?? ""
                }
            }
        } catch {
            print("bad")
            return
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentUserId: .constant(""))
            .previewDisplayName("Login").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
