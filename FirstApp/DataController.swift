//
//  DataController.swift
//  FirstApp
//
//  Created by Udrea Alexandru-Iulian-Alberto on 12.06.2022.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}


