//
//  Home.swift
//  ezyList
//
//  Created by Quantum on 17/8/2565 BE.
//

import SwiftUI
import Firebase

//import FirebaseFirestoreSwift



struct Home: View {
    
    @ObservedObject var model = InventoryViewModel()
    
    @State var item = ""
    // MARK: - Log Status
  

    
   
    // MARK: - Firebstorequery
    var body: some View {
        Text("Home")
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
