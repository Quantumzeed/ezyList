//
//  InventoryItem.swift
//  ezyList
//
//  Created by Quantum on 18/8/2565 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct InventoryItem: Identifiable {
    
//    @DocumentID var id: String?
//    @ServerTimestamp var createAt: Date?
//    @ServerTimestamp var updateAt: Date?
    var id: String
    var item: String
    var name: String
    var quantity : Int
    
//    var quantity: Int
//    var company: String
    var buyprice: Double
    var sellprice: Double
    var image: String
    var createAt : Date?
    
    var formatterCreateAt: String {
        createAt?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
//    var user: String
    
}
