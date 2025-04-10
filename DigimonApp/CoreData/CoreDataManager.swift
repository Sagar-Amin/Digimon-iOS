//
//  CoreDataManager.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/11/25.
//


import Foundation

protocol CoreDataManagerProtocol {
    func saveDataInDB(digimons: [Digimon])
    func getDataFromDB() async throws -> [Digimon]
}

class CoreDataManager: CoreDataManagerProtocol {
    let viewContext = PersistenceController.shared.container.viewContext
    
    func saveDataInDB(digimons: [Digimon]) {
        digimons.forEach { (digimon) in
            let digimonEntity = DigimonEntity(context: viewContext)
            
            digimonEntity.name = digimon.name
            digimonEntity.img = digimon.img
            digimonEntity.level = digimon.level
        }

        do {
            try viewContext.save()
            print("saveDataInDB =========")
        } catch {
            print(error.localizedDescription)
        }

    }
    
        
    func getDataFromDB() async throws -> [Digimon] {
        return []
    }
}

        
