//
//  ChatRoom.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//
import MapKit
import SwiftUI
import UniformTypeIdentifiers

struct ChatRoom: View {
    
    @StateObject  var vm :ChatRoomVM
    
    @State private var showFilePickerAlert = false
    
    @State private var showFilePicker = false
    @State private var showImagePicker = false
    @State private var showLocaionPicker = false
    
    @State var activeUIType:UTType = .image
    
    
    
    @Namespace var bottomID
    
    var body: some View {
        
        ZStack {
            
            backgroundColor
                .ignoresSafeArea(.all)
            
            VStack{
                
                ChatRoomHeader(title:vm.contactUser.name ?? "",isOnline: vm.contactUser.isOnline ?? false)
                
                VStack{
                    ScrollViewReader { proxy in
                        VStack{
                            ScrollView(showsIndicators: false) {
                                ForEach(Array(vm.sectionsList.enumerated()), id: \.offset) { index, section in
                                    
                                    Text(section.title ?? "")
                                        .font(.customFont(.DMSansBold, 14))
                                        .padding(8)
                                        .background(themeColor)
                                        .foregroundColor(whiteColor)
                                        .cornerRadius(5, corners: .allCorners)
                                    
                                    ForEach(Array(( section.messages ).enumerated()), id: \.offset) { index, message in
                                        getMessage(message: message)
                                    }
                                    
                                    
                                }
                                HStack {
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 30)
                                        .id(bottomID)
                                    Spacer()
                                }//:HStack
                                
                            }
                           
                        }//:VStack
                          .onChange(of: vm.lastMessageId) { id in
                            withAnimation {
                                proxy.scrollTo(bottomID, anchor: .bottom)
                            }
                        }
                        
                    }
                }
                .background(chatBackgroundColor)
                .padding(.bottom,70)
                
               
            }//:VStack
            
            VStack {
                
                Spacer()
                
                MessageInput(textMessage: $vm.textFiled, attachmentTapCallBack: {
                    showFilePickerAlert.toggle()
                }, sendTapCallBack:{
                    await sendMessage()
                })
                
                
            }//:VStack
            .onAppear{
                startLoading()
                vm.fetchData(){ status in
                    stopLoading()
                    
                }
            }
            
            
            //MARK: - ALERT
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
            
            //MARK: - FilePicker
            CustomFilePicker(isImporting: $showFilePicker, activeUIType:$activeUIType){
                result in
                
                do {
                    let url = try result.get()
                    startLoading()
                    vm.uploadFile(fileUrl: url, fileType: .pdf){ succes in
                        stopLoading()
                    }
                } catch{
                    print ("error reading: \(error.localizedDescription)")
                }
                
            }
            
            
            //MARK: - Image Picker
            ImagePickerView(showSheet:$showImagePicker){ (image,url) in
                startLoading()
                vm.uploadFile(fileUrl: url, fileType: .image){ succes in
                    stopLoading()
                }
            }
            
        
            
            
            
            BottomSheet(isShowing:$showFilePickerAlert, content:
                            AnyView(
                                BottomoOption(pdfTapCallback: {
                                    activeUIType = .pdf
                                    showFilePickerAlert.toggle()
                                    showFilePicker.toggle()
                                    
                                }, imageTapCallback: {
                                    
                                    showImagePicker.toggle()
                                    showFilePickerAlert.toggle()
                                }, locationTapCallback: {
                                    
                                    showLocaionPicker = true
                                    showFilePickerAlert.toggle()
                                    
                                }, cancelTapCallback: {
                                    
                                    showFilePickerAlert.toggle()
                                })
                            )
            )
            
            
           
            NewLocationPicker(isShowPicker: $showLocaionPicker){ location in
                self.sendLocation(location: location)
            }

           
        }//:ZStack
        .navigationBarHidden(true)
      
        
    }
    
    func sendLocation(location:CLLocationCoordinate2D?){
        if let location = location {
            startLoading()
            vm.chatMessageWithLocation(location: location){ status in
                stopLoading()
            }
        }
    }
    
    
    func sendMessage() async{
        startLoading()
        vm.chatMessage(){ status in
            stopLoading()
            if status {
                vm.cleanText()
            }
        }
    }
    
    
    func  getMessage(message:Message) -> AnyView{
        if message.idFrom == "\(vm.currentUser.id ?? 0 )"{
            return AnyView(SenderTextMessageCellView(message:message))
        }else{
            return AnyView(ReceiveMessageCellView(vm: ReceiveMessageCellVM(contactUser: vm.contactUser), message:message))
        }
    }
    
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(vm:ChatRoomVM(contactUser: dummyUser2))
    }
}









