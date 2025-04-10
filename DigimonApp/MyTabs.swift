//
//  MyTabs.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import SwiftUI

struct MyTabs: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
        }
    }
}

#Preview {
    MyTabs()
}
