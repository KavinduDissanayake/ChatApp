//
//  ContactList.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import SwiftUI

struct ContactList: View {
    
    //MARK: - PROPERITY
    @StateObject var vm = ContacVM()
    
    var body: some View {
        ZStack {
            
            backgroundColor
            

            VStack{

                
                HeaderView(title: "Contact List")
                
                
               
                SearchTextBar(searchText: $vm.searchText) {
                    getUserList(page: 1,isSerachOn: true)
                }
                
        
                
                GeometryReader { geometry in
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            LazyVStack {
                                
                                ForEach(Array(vm.contactList.enumerated()), id: \.offset) { index, contactUser in
                                    
                                    UserContactCard(userModel: contactUser)
                                        .onAppear {
                                            self.paginationWithCard(user: contactUser)
                                        }
                                    
                                }
                            }
                            
        
                           Spacer()
                            
                        }//:VStack
                        .frame(minHeight: geometry.size.height)
                    }//:ScrollView
                    .frame(width: geometry.size.width)
                }//:GeometryReader
            }//:VStack
            
            
            //MARK: - ALERT
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
            
            //MARK: - onAppear
            Text("")
                .onAppear{
                    getUserList(page: 1)
                }
            
            
        }//:ZStack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)

    }
    
    
   
    func paginationWithCard(user:User){
        if user.id == self.vm.contactList.last?.id{
               if vm.currentPage < vm.lastPage{
                let nextPage = (vm.currentPage) + 1
                self.getUserList(page: Int(nextPage), isPaging: true)
            }
        }
    }
    
    func getUserList(page:Int,perPage:Int = 20,isPaging:Bool = false,isSerachOn:Bool = false){
        
        if !isSerachOn{
           self.startLoading()
            vm.currentPage = 0
            vm.lastPage = 0
        }
        
        vm.getProfileListRequest(page: page ,perPage: perPage,isPaging: isPaging){ success in
            self.stopLoading()
              
        }
    }
        
      
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList()
    }
}
