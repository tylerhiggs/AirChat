//
//  SettingsView.swift
//  Airchat
//
//  Created by Tyler Higgs on 11/30/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var currentUserId: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    currentUserId = ""
                } label: {
                    Text("Logout")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.all, 8)
                }
                .foregroundColor(.white)
                .background {
                    Capsule(style: .continuous)
                        .foregroundColor(.red)
                }
                .padding()
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(currentUserId: .constant(""))
    }
}
