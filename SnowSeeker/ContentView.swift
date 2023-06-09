//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Derya Antonelli on 17/04/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum SortOption {
    case defaultSort
    case alphabeticalSort
    case countrySort
}

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var showFilterSheet = false
    
    @State private var sort: SortOption = .defaultSort
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                            
                        }
                        
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection: $sort, label: Text("Sorting options")) {
                            Text("Default").tag(SortOption.defaultSort)
                            Text("Alphabetical")
                                .tag(SortOption.alphabeticalSort)
                            Text("Country").tag(SortOption.countrySort)
                            
                        }
                    } label: {
                        Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            
            // secondary view for large screens
            WelcomeView()
        }
        // this is optional
        //        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
        
    }
    
    var filteredResorts: [Resort] {
        var filtered: [Resort] = []
        
        if searchText.isEmpty {
            filtered = resorts
        } else {
            filtered = resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        switch sort {
        case .defaultSort:
            break
            
        case .alphabeticalSort:
            filtered.sort { $0.name < $1.name }
            
        case .countrySort:
            filtered.sort { $0.country < $1.country }
        }
        
        return filtered
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
