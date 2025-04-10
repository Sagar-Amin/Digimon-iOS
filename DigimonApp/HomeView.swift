//
//  HomeView.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject private var viewModel = ViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager())
    
    // Data from Coredata
    @FetchRequest(entity: DigimonEntity.entity(), sortDescriptors: [])
    var digimonsDB : FetchedResults<DigimonEntity>
    var request: NSFetchRequest<DigimonEntity> = DigimonEntity.fetchRequest()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .error(let error):
                    showError(error: error)
                case .loaded(let digimons):
                    showList(list: digimons)
                }
                
                
               
                
            }
            .searchable(text: $viewModel.searchWord, prompt: "Search ...")
            .accessibilityAddTraits(.isSearchField)
            .onAppear {
                // viewModel.getList() // get data from API
            }
            .navigationTitle(Text("Digimon List"))
        }
    }
    
    @ViewBuilder
    fileprivate func showList(list: [Digimon]) -> some View {
        List(digimonsDB) { digimon in
            NavigationLink {
                DigimonDetailView(digimon: Digimon(name: digimon.name ?? "",
                                                   img: digimon.img ?? "",
                                                   level: digimon.level ?? ""))
            } label: {
                DigimonCell(digimon: Digimon(name: digimon.name ?? "",
                                             img: digimon.img ?? "",
                                             level: digimon.level ?? ""))
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Name is \(digimon.name ?? "") and his level is \(digimon.level ?? "")")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("Please tap here to see more details about \(digimon.name ?? "")")
            }
            
                                    
        }
//        List(list) { digimon in
//            NavigationLink {
//                EmptyView()
//            } label: {
//                HStack {
//                    DigimonCell(digimon: digimon)
//                }
//            }
//            
//        }
    }
    
    @ViewBuilder
    fileprivate func showError(error: Error) -> some View {
        Text("\(error.localizedDescription)")
    }
}

#Preview {
    HomeView()
}
