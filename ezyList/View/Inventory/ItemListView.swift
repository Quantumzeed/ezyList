//
//  InventoryView.swift
//  ezyList
//
//  Created by Quantum on 18/8/2565 BE.
//

import SwiftUI
//import FirebaseFirestoreSwift
//import FirebaseFirestore
import FirebaseCore



struct ItemListView: View {
    // MARK: - properties
    @ObservedObject var model = InventoryViewModel()
    @ObservedObject var login = LoginViewModel()
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State var isPresentedNewItem = false
    
    @State var id = 0
    @State var item = ""
    @State var name = ""
    @State var quantity = 0
    @State var buyprice = 0.00
    @State var sellprice = 0.00
    @State var image = ""
    
    

    
    
    //    @State var selected : InventoryViewModel
    init(){
        model.getData()
    }
    
    
    // MARK: - body
    var body: some View {
        NavigationView{
            List{
                ForEach(model.list){ item in
                    NavigationLink(destination: ItemDetailView(models: item, action: {model.getData()}),
                                   label: {
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                Text(String(item.quantity))
                                    .foregroundColor(.gray)
                                Text(item.formatterCreateAt)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                            }
                            Spacer()
                        }//:HSTACK
                    })
                }//:Loop ForEachnb
            }//:LIST
            .refreshable {
                //                model.getData()
            }
            .listStyle(InsetListStyle())
            .navigationBarTitle("List")
            .navigationBarItems(trailing: AddNewItem)
            
        }//:naviagtion
        .sheet(isPresented: $isPresentedNewItem, content: {
            NewItemView(isPresented: $isPresentedNewItem, item: $item, name: $name, quantity: $quantity,buyprice: $buyprice,sellprice: $sellprice, image: $image, action: {
                
                model.addData(item: item, name: name, quantity: quantity, buyprice: buyprice, sellprice: sellprice, image: image)
                id = 0
                item = ""
                name = ""
                quantity = 0
                buyprice = 0.00
                sellprice = 0.00
                image = ""
                
            })
        })
    }//:Body
    var AddNewItem: some View {
        Button(action: {
            isPresentedNewItem.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

// MARK: - preview

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
            .environmentObject(InventoryViewModel())
    }
}
