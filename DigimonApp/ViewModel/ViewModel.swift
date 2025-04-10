//
//  ViewModel.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import Foundation
import Combine

enum State {
    case loading
    case loaded([Digimon])
    case error(Error)
}
     

class ViewModel : ObservableObject {
    
    
    @Published var digimons: [Digimon]  = []
    private var oriDigimons: [Digimon] = []
    
    @Published var state: State = .loading
    @Published var searchWord: String = ""
    
    private var cancelables = Set<AnyCancellable>()
    
    let apiManager: APIService
    
    private var coreDataManager: CoreDataManagerProtocol
    
    
    init(apiManager: APIService, coreDataManager: CoreDataManagerProtocol) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
        
        setUpSearchBinding()
    }
    
    // search function with filter by words
    func setUpSearchBinding() {
        $searchWord
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] searchWord in
                self?.filterDigimons(searchText: searchWord)
            }.store(in: &cancelables)
    }
    
    func filterDigimons(searchText: String) {
        if searchText.isEmpty {
            self.digimons = self.oriDigimons
            self.state = .loaded(self.digimons)
            return
        }
        self.digimons = self.oriDigimons.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        self.state = .loaded(self.digimons)
    }
    
    // call api and get response via Model
    func getList() {
        self.apiManager.fetchData(url: APIConstants.baseURL, modelType: [Digimon].self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Finished")
                    
                    case .failure(let error):
                        self.state = .error(error)
                        switch error {
                        default:
                            print(error.localizedDescription)
                        }
                }
                
            } receiveValue: { list in
                // print(list)
                self.digimons = list
                self.oriDigimons = list
                self.state = .loaded(list)
                
                
                // save in DB
                self.coreDataManager.saveDataInDB(digimons: list)
                let path = self.getSqlitePath()
                print("DB path: \(path)")
                
            }.store(in: &cancelables)
            
    }
    
    private func getSqlitePath() -> String {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let documentDirectoryUrl = urls[0]
        let fileUrl = documentDirectoryUrl.appendingPathComponent("digimon.sqlite")
        return fileUrl.path
    }
    
}
