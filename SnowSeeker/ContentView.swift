//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Derya Antonelli on 17/04/2023.
//

import SwiftUI

struct User: Identifiable {
    var id = "5454654"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(isPresented: $isShowingUser) {
                Text(selectedUser!.id)
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
