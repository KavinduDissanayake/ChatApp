//
//  ChatRoom.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ChatRoom: View {
    
    @StateObject  var vm = ChatRoomVM()
    
    @State private var showFilePickerAlert = false
    
    
    
    @State private var showFilePicker = false
    @State private var showImagePicker = false
    
    @State var activeUIType:UTType = .image
    
    
    
    @Namespace var bottomID
    
    var body: some View {
        
        ZStack {
            
            VStack{
                
                ChatRoomHeader(title:"Sanduni")
                
                
                
                
                
//                ScrollView(.vertical, showsIndicators: false) {
//                    ScrollViewReader { value in
//                        LazyVStack(spacing: 0.5) {
//
//                            ForEach(Array(vm.sectionsList.enumerated()), id: \.offset) { index, section in
//
//                                Text(section.title ?? "")
//                                    .font(.customFont(.DMSansBold, 14))
//                                    .padding(8)
//                                    .background(themeColor)
//                                    .foregroundColor(whiteColor)
//                                    .cornerRadius(5, corners: .allCorners)
//
//
//                                ForEach(Array(( section.messages  ).enumerated()), id: \.offset) { index, message in
//
//                                    getMessage(message: message)
//
//
//                                }//:ForEach
//                                .onChange(of: vm.sectionsList) { _ in
//
//
//                                    if  vm.sectionsList.count > 0 {
//                                        withAnimation{
//                                            value.scrollTo(bottomID)
//                                        }
//                                    }else{
//                                        print("pass error 0")
//                                    }
//                                }
//
//
//                            }
//                            Rectangle()
//                                .frame(height: 50, alignment: .center)
//                                .foregroundColor(Color.clear)
//                                .id(bottomID)
//                            //.id(scrollToid)//padding from bottom
//                            //  Scroll(reader: reader)
//                        }
//                    }
//                }
                
                
                                VStack {
                
                                    GeometryReader { geometry in
                
                                        //MARK:- CustomScrollView
                                        CustomScrollView(scrollToEnd: true) {
                
                
                                            LazyVStack {
                
                                                ForEach(Array(vm.sectionsList.enumerated()), id: \.offset) { index, section in
                
                                                    Text(section.title ?? "")
                                                        .font(.customFont(.DMSansBold, 14))
                                                        .padding(8)
                                                        .background(themeColor)
                                                        .foregroundColor(whiteColor)
                                                        .cornerRadius(5, corners: .allCorners)
                
                
                                                    ForEach(Array(( section.messages  ).enumerated()), id: \.offset) { index, message in
                
                                                        getMessage(message: message)
                
                
                                                    }//:ForEach
                
                
                                                }//:ForEach
                                            }//:LazyVStack
                
                
                                        }//:CustomScrollView
                
                
                                    }//:GeometryReader
                
                                }
                                .background(  chatBackgroundColor)
                                .padding(.bottom,50)
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
                                    
                                    
                                }, cancelTapCallback: {
                                    
                                    showFilePickerAlert.toggle()
                                })
                            )
            )
            
        }//:ZStack
        .navigationBarHidden(true)
        
    }
    
    
    func sendMessage() async{
        startLoading()
        vm.chatMessage(){ status in
            stopLoading()
            if status {
                
            }
        }
    }
    
    
    func  getMessage(message:Message) -> AnyView{
        if message.idFrom == vm.currentUser._id ?? "" {
            return AnyView(SenderTextMessageCellView(message:message))
        }else{
            return AnyView(ReceiveMessageCellView(message:message))
        }
    }
  
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom()
    }
}









