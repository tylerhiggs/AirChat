//
//  SignupView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/25/22.
//

import SwiftUI
import PhotosUI
import CoreData

struct SignupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var validatePassword: String = ""
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var userSelectedImage: Data?
    
    @Binding var currentUserId: String
    @Binding var presentingSheet: Bool
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 1,
                matching: .images
            ) {
                if let data = userSelectedImage, let uiimage = UIImage(data: data) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .frame(width: 128, height: 128)
                        .clipShape(Circle())
                        .padding(.top)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 128, height: 128)
                        .foregroundColor(.gray)
                        .padding(.top)
                }
            }
            .onChange(of: selectedItems) { newValue in
                guard let item = selectedItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self.userSelectedImage = data
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let error):
                        print("fatal error: \(error)")
                    }
                }
            }
            VStack {
                TextField("Name", text: $name)
                    .padding(.vertical)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.givenName)
                TextField("Email", text: $email)
                    .padding(.bottom)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .padding(.bottom)
                    .textFieldStyle(.roundedBorder)
                SecureField("Repeat Password", text: $validatePassword)
                    .padding(.bottom)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Button {
                        addUser()
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
                Spacer()
            }
        }
        .padding()
    }
    
    private func addUser() {
        // add user to db
        let newUser = User(context: viewContext)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        newUser.photo = userSelectedImage
        let id = UUID()
        newUser.id = UUID()
        do {
            try viewContext.save()
        } catch {
            print("There was an error saving the user")
            return
        }
        // if successful, add info to user defaults
        currentUserId = id.uuidString
        presentingSheet = false
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(currentUserId: .constant(""), presentingSheet: .constant(true)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
