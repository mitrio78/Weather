//
//  StorageProvider.swift
//  Weather
//
//  Created by Mitrio on 05.05.2022.
//

import Foundation
import CoreData

class StorageProvider {
    let persistantContainer: NSPersistentContainer
    static let shared = StorageProvider()
    
    init() {
        persistantContainer = NSPersistentContainer(name: "Model")
        persistantContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData store failed to load with error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveCoordinates(lat: Double, lon: Double) {
        let coordinates = Coordinates(context: persistantContainer.viewContext)
        coordinates.latitude = lat
        coordinates.longitude = lon
        
        do {
            print("saving coords")
            try persistantContainer.viewContext.save()
        } catch {
            self.persistantContainer.viewContext.rollback()
            print("Failed to save coordinates \(error.localizedDescription)")
        }
    }
    
    func getAllCoordinates() -> [Coordinates] {
        let fetchRequest: NSFetchRequest<Coordinates> = Coordinates.fetchRequest()
        do {
            print("getting saved")
            return try persistantContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch coordinates: \(error.localizedDescription)")
            return []
        }
    }
    func deleteCoordinates(_ coordinate: Coordinates) {
        persistantContainer.viewContext.delete(coordinate)
        do {
            try persistantContainer.viewContext.save()
        } catch {
            persistantContainer.viewContext.rollback()
            print("Failed to delete coordinates in context: \(error.localizedDescription)")
        }
    }
}
