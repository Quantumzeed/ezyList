//
//  InventoryViewModel.swift
//  ezyList
//
//  Created by Quantum on 18/8/2565 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class InventoryViewModel: ObservableObject {
    
    @Published var list = [InventoryItem]()
    let uid = LoginViewModel().getUid()


    
    
//    func updateData(inventoryiItemUpdate: InventoryItem) {}
    func updateData(id: String, item: String, name: String, quantity: Int, buyprice: Double, sellprice: Double) {

        //Get a reference to the database
       let db = Firestore.firestore()
        
        // Specify the document to update
        db.collection("ezyList").document(self.uid).collection("inStock").document(id).setData(["item": item,"name": name, "quantity": quantity, "buyprice":buyprice,"sellprice":sellprice ,"sellAt":""], merge: true) {error in
            
            //check errors
            if error == nil {
                //no error
                self.getData()
            } else {
                //hendel error
            }
        }
    }//: Update
    
    func deleteData(inventoryItemDelete: InventoryItem){
        //Get a reference to the database
       let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("ezyList").document(self.uid).collection("inStock").document(inventoryItemDelete.id).delete { error in
            
            //check for error
            if error == nil {
                //no error
                
                DispatchQueue.main.async {
                    //remove the InventoryItem
                    self.list.removeAll { InventoryItem in
                        
                        //call check for the Inventory Item to remove
                        return InventoryItem.id == inventoryItemDelete.id
                    }
                }
            } else {
                //:handle error
            } //:if
            
        }//db.colection
        
    }//func deleteData
    
    func addData(item: String, name: String, quantity: Int, buyprice: Double, sellprice: Double, image:String) {
        
        
         //Get a reference to the database
        let db = Firestore.firestore()
        
        //Add adocument to a specific path
        db.collection("ezyList").document(self.uid).collection("inStock").addDocument(data: ["item":item, "name":name, "uid":self.uid, "quantity":quantity, "buyprice":buyprice,"sellprice":sellprice, "image":image, "createAt":Date()]) { error in
            
            //check error
            if error == nil {
                
                // no error
                
                //Call get data to retrieve latest data
                self.getData()
                
            } else {
                
                // Handle the error
                
            }//:if error
        }
        
//        db.collection("ezyList").document(self.uid).collection("inStock").addDocument(data: ["item":item, "name":name, "uid":self.uid, "quantity":quantity, "buyprice":buyprice,"sellprice":sellprice, "image":image, "createAt":Date()]) {error in
//
//        }
        
    } //: addData
    func getData() {
        
        //Get a referance to the database
        let db = Firestore.firestore()
        
        
        
        //Read the document at a specific path
        db.collection("ezyList").document(self.uid).collection("inStock").getDocuments { snapshot, error in
//        db.collection("Inventory").getDocuments
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    // update the list property in the main thread
                    DispatchQueue.main.async {
                        //Getall the document and create Inventory
                       self.list = snapshot.documents.map { d in
                           //Create a InventoryItem for each document returned
                           return InventoryItem(id: d.documentID,
                                                item: d["item"] as? String ?? "",
                                                name: d["name"] as? String ?? "",
                                                quantity: d["quantity"] as? Int ?? 0,
                                                buyprice: d["buyprice"] as? Double ?? 0.00,
                                                sellprice: d["sellprice"] as? Double ?? 0.00,
                                                image: d["image"] as? String ?? "",
                                                createAt:(d["createAt"] as? Timestamp)?.dateValue()
                           )
                       }
                    }
                }
            }else{
                //handle the error
            }
        }//:db.collection
    }//GetData
}//:Class
