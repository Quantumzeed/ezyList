//
//  ItemDetail.swift
//  ezyList
//
//  Created by Quantum on 1/9/2565 BE.
//

import SwiftUI
import Combine
import FirebaseStorage

struct ItemDetailView: View {
    // MARK: - properties
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var model = InventoryViewModel()
    let models : InventoryItem
    
    @State var id = ""
    @State var item = ""
    @State var name = ""
    @State var quantity = 0
    @State var buyprice = 0.00
    @State var sellprice = 0.00
    @State var image = ""
    @State var retriveImage = UIImage()

    
    var action: () -> Void
    
    // MARK: - body
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Detail ID is \(id)" )
                if image != "" {
                    Image(uiImage: retriveImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                
                

                
                
                Text("Path is \(image)")
                TextField("item", text: $item)
                    .textFieldStyle(.roundedBorder)

                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("quantity", value: $quantity, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                TextField("buyprice", value: $buyprice, format: .currency(code: "THB"))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    
                TextField("sellprice", value: $sellprice, format: .currency(code: "THB"))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Spacer()


                
                    
            }//:VSTACK
            .padding()
            .onAppear(perform: {
                self.id = models.id
                self.item = models.item
                self.name = models.name
                self.quantity = models.quantity
                self.buyprice = models.buyprice
                self.sellprice = models.sellprice
                self.image = models.image
                self.getImageEvent(imagePath: self.image, completion: { theImage in
                    retriveImage = theImage
//                    print("got the image!")
                })
//                retrivePhoto()
                
            })
        }//:ZSTACK
        .onTapGesture {
            hideKeyboard()
        }
        
        .navigationBarTitle("Detail" , displayMode:  .inline)
        .navigationBarItems(trailing: trailing)
    }
    var trailing: some View{
        HStack{
            Button(action: {
                
                model.updateData(id: id, item: item, name: name, quantity: quantity, buyprice: buyprice, sellprice: sellprice)
                presentationMode.wrappedValue.dismiss()
                self.action()
                
            }, label: {
                Text("Save")
            })
            
            Button(action: {
                self.action()
                model.deleteData(inventoryItemDelete: models)
                presentationMode.wrappedValue.dismiss()
            
            }, label: {
                Image(systemName: "trash")
            
            })
        
        }
        
    }
    
    func getImageEvent (imagePath: String, completion: @escaping(UIImage) -> Void) {
        var _ : UIImageView?
        let storageRef =  Storage.storage().reference()
        let fileRef = storageRef.child(imagePath)
    
        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                if let myImage = UIImage(data: data) {
                    completion(myImage)
                }
            }
        }
    }
//    func retrivePhoto(){
//        // MARK: - get a referance to storage
//        let storageRef = Storage.storage().reference()
//
//
//        // MARK: - specify the path
//        let fileRef = storageRef.child(image)
//
//        // MARK: -  retirve the data
//        fileRef.getData(maxSize: 50 * 1024 * 1024 ){ data,error in
//
//            // MARK: -  check for error
//            if error == nil {
//                // MARK: - Create a UIImage and put it into our arrey for display.
//            } else {
//                // Data for "images/island.jpg" is returned
//                if let image = UIImage(data: data!){
//                    DispatchQueue.main.sync {
//                    }
//                }
//            }
//
//        }
//    }
    
}


// MARK: - preview
//struct ItemDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailView()
//    }
//}
