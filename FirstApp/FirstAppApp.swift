//
//  FirstAppApp.swift
//  FirstApp
//
//  Created by Udrea Alexandru-Iulian-Alberto on 08.06.2022.
//

import SwiftUI



@main
struct FirstAppApp: App {
    @StateObject private var dataController = DataController()


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        
    }
}
