//
//  DigimonDetailView.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/25/25.
//

import SwiftUI

struct DigimonDetailView: View {
    
    let digimon: Digimon
    
    
    var body: some View {
        VStack() {
            Group {
                if let url = URL(string: digimon.img) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 300, height: 300)
                            .cornerRadius(20)
                            
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .accessibilityElement()
            .accessibilityAddTraits(.isImage)
            .accessibilityLabel(Text("This is \(digimon.name) image !!!!"))
            
            
            Text(digimon.name)
                .font(.largeTitle)
                .accessibilityAddTraits(.isStaticText)
                .accessibilityLabel(Text("This is \(digimon.name) !!!"))
            
            Text(digimon.level)
                .font(.title2)
                .accessibilityAddTraits(.isStaticText)
                .accessibilityLabel(Text("This is \(digimon.level) !!!"))
            
        }
        .navigationTitle("Details")
        // .accessibilityHint(Text("Tap on the image to see it in full screen"))
    }
}

#Preview {

    DigimonDetailView(digimon: Digimon(name: "Koromon", img: "https://digimon.shadowsmith.com/img/koromon.jpg", level: "In Training"))
}
