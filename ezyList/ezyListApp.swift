//
//  ezyListApp.swift
//  ezyList
//
//  Created by Quantum on 17/8/2565 BE.
//

import SwiftUI
import Firebase
@main
struct ezyListApp: App {
    
    
    
    // MARK: - Initialize Firebase
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
