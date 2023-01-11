//
//  NewItem.swift
//  ezyList
//
//  Created by Quantum on 1/9/2565 BE.
//

import SwiftUI
import FirebaseStorage


struct NewItemView: View {
    // MARK: - properties
    @ObservedObject var model = InventoryViewModel()
    @Binding var isPresented: Bool
    

    
//    @Binding var id : Int
    @Binding var item: String
    @Binding var name: String
    @Binding var quantity: Int
    @Binding var buyprice:Double
    @Binding var sellprice:Double
    @Binding var image:String
    @State var isAlert = false
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    
    
    
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("New Item" )
                    // MARK: - select photo
                    VStack{
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 200, height:  200)
                        }
                        Button{
                            isPickerShowing = true
                        }label: {
                            Text("select a photo")
                        }
                        if selectedImage != nil {
                            Button{
                                uploadPhoto()
                            }label: {
                                Text("Upload photo")
                            }
                        }
                        
                    }
                    .padding()
                    
                    TextField("pathImage",text: $image)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 55)
                    
                    TextField("item", text: $item)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 55)
                    
                    TextField("Name", text: $name)
                        .frame(height: 55)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("quantity", value: $quantity, formatter: NumberFormatter())
                        .frame(height: 55)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    TextField("buyprice", value: $buyprice, format: .currency(code: "THB"))
                        .frame(height: 55)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        
                    TextField("sellprice", value: $sellprice, format: .currency(code: "THB"))
                        .frame(height: 55)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        
                    Spacer()
                        
                }//:VSTACK
                .padding()
                .alert(isPresented: $isAlert, content: {
                    let title = Text("No Data")
                    let message = Text("Please fill your date")
                    return Alert(title: title, message: message)
                })
            }//:ZSTACK
            
            .navigationBarTitle("New" , displayMode:  .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
            .sheet(isPresented: $isPickerShowing, onDismiss: nil){
                ImagePicker(image: $selectedImage)
            }
            
        }
    }
    var leading: some View{
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel")
        })
    }
    var trailing: some View{
        Button(action: {
            if item != "" {
                self.action()
//                model.addData(item: item, name: name, quantity: quantity)
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
//            model.addData(item: $item, name: $name, quantity: $quantity)
        }, label: {
            Text("Add")
        })
    }
    // MARK: - function
    func uploadPhoto(){
        
        // MARK: - make sure that the select image properties isn't nil
        guard selectedImage != nil else {
            return
        }
        
        // MARK: - Create storage reference
        let storageRef = Storage.storage().reference()
        
        // MARK: - turn out image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // MARK: - check that we were able to convert it to data
        guard imageData != nil else{
            return
        }
        
        // MARK: - Specify the file path and name
        image = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(image)

        // MARK: - upload that data
        _ = fileRef.putData(imageData!, metadata: nil){
            metadata, error in
            
            // MARK: - check for error
            if error == nil && metadata != nil {
                // MARK: - todo SAVE a reference to the file in firebase db
//                fileRef.downloadURL { link, error in
//                    image = String(link)
//                }
            }
        }
        
        // MARK: - Save a referance to the file in firestore DB
        
        
    }
}

// MARK: - preview

//struct NewItem_Previews: PreviewProvider {
//    static var previews: some View {
//        NewItem(isPresented: .constant(true))
//    }
//}
