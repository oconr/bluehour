//
//  DataController.swift
//  Blue Hour
//
//  Created by Ryan O'Connor on 12/12/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentCloudKitContainer(name: "BlueHour")
        
        if (inMemory){
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
