//
//  DigimonCell.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import SwiftUI

struct DigimonCell: View {
    
    let digimon: Digimon
    
    
    var body: some View {
        VStack() {
            HStack(spacing: 20) {
                if let url = URL(string: digimon.img) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(digimon.name)
                        .font(.largeTitle)
                    Text(digimon.level)
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {

    DigimonCell(digimon: Digimon(name: "Koromon", img: "https://digimon.shadowsmith.com/img/koromon.jpg", level: "In Training"))
}
