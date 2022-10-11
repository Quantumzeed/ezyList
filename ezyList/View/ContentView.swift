//
//  ContentView.swift
//  ezyList
//
//  Created by Quantum on 17/8/2565 BE.
//

import SwiftUI

struct ContentView: View {
        
    // MARK: - Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("use_face_id") var useFaceID: Bool = false
    
    
    var body: some View {
        NavigationView{
            if logStatus{
                TabView{
                    Home()
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                        }
                        
                    ItemListView()
                        .tabItem{
                            Label("Store", systemImage: "tray")
                        }
                    Profile()
                        .tabItem{
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                }
            } else {
                LoginPage()
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
        .background(.brown)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(InventoryViewModel())
    }
}
