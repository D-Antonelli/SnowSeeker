//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Derya Antonelli on 17/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
