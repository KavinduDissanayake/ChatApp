//
//  ChatList.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import SwiftUI
struct ChatList: View {
    
    //MARK: - PROPERITY
    @StateObject var vm = ChatListVM()
    @State var isActiveChatRoom = false
    
    var body: some View {
        ZStack {
            
            backgroundColor
            

            VStack{

                
                HeaderView(title: "Message")
                
                
                SearchTextBar(searchText: $vm.searchText) {
                    fetchData()
                }
                
                
                
                GeometryReader { geometry in
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 0) {
                            
                            ForEach(Array(vm.chatUserList.enumerated()), id: \.offset) { index, chatUser in
                                
                                ChatUserView(chatUser:chatUser){ selectedUser in
                                    vm.contactUserId = chatUser.connection ?? ""
                                    if let userModel = selectedUser {
                                        vm.selectedUserModel = userModel
                                        isActiveChatRoom.toggle()
                                    }
                                 
                                }
                                
                            }
                           
                            
                           
                            Spacer()
                           
                            
                        }//:VStack
                        .frame(minHeight: geometry.size.height)
                        .padding(.bottom,80)
                    }//:ScrollView
                    .frame(width: geometry.size.width)
                }//:GeometryReader
            }//:VStack
            
            
            Text("")
                .onAppear{
                    fetchData()
                }
            
            //MARK: - ALERT
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
            
            
            //MARK: - Navigation
            Text("")
                .navigationDestination(isPresented: $isActiveChatRoom) {
                    ChatRoom(vm:ChatRoomVM(contactUser: vm.selectedUserModel ?? dummyUser2))
                }

         
        }//:ZStack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
       
    }
    
    
    func fetchData(){
        vm.fetchData{ status in 
            
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
