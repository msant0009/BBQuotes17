//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Mark Santoro on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Better Call Saul", systemImage: "briefcase")
                }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
