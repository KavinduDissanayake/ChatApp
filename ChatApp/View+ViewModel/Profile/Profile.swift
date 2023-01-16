//
//  ProfileScreen.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile: View {
    
    @State var isShowLogout = false
    
    
    //MARK: - PROPERITY
    @StateObject var vm = ProfileVM()
    
    
    var body: some View {
        
        ZStack {
            backgroundColor
            VStack{
                
                

                ZStack{
                    Image("splash_bg_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: Double.infinity,height: 259)
                    
                    VStack(spacing:5) {
                        
                        WebImage(url: URL(string: vm.user?.avatarURL ?? "" ))
                            .placeholder(Image("Icon_placeholder"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(grayColor, lineWidth: 2)
                            )
                        
                        Text(vm.user?.name ?? "N/A")
                            .font(.customFont(.RalewaySemiBold, 18))
                            .foregroundColor(whiteColor)
                        
                        Text("\(vm.calculateAge(fromDOB: (vm.user?.dob ?? "N/A"))) Years Old")
                            .font(.customFont(.DMSansRegular, 14))
                            .foregroundColor(whiteColor)
                    }
                    .padding(.top,30)
                    // .background(Color.red)
                    
                }//;ZStack
                .background(themeColor)
                .cornerRadius(20)
                
                
                
                GeometryReader { geometry in
                    
                    ScrollView(.vertical , showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            
                            MenuItemView(destinationView: Text("My Profile"), title: "My Profile")
                            
                            MenuItemView(destinationView: Text("Settings"), title: "Settings")
                            
                            MenuItemView(destinationView: Text("Change Password"), title: "Change Password")
                            
                            MenuItemView(destinationView: Text("Privacy policy"), title: "Privacy policy")
                            
                            MenuItemView(destinationView: Text("Terms and conditions"), title:"Terms and conditions")
                            
                            MenuItemView(destinationView: Text("About us"), title:"About us")
                            
                            
                            Button {
                                isShowLogout.toggle()
                            } label: {
                                MenuItem(title: "Logout ")
                                    .foregroundColor(redColor)
                            }
                        
                            
                            Spacer()
                            
                        }//:VStack
                        .frame(minHeight: geometry.size.height)
                    }//:ScrollView
                    .frame(width: geometry.size.width)
                }//:GeometryReader
            }//:VStack
            
            
            //alert logout
            CustomAlert(isShowAlert: $isShowLogout, alertTitle: "Logout", alertMessage:"Are you sure, Do you want logout?",actionSecond:{
                logoutAPI()
            }, alertButtonOneTitle: "Cancel",alertButtonTwoTitle: "Logout")
            
            
            //MARK: - ALERT
            CustomAlert(isShowAlert: $vm.isShowAlert, alertTitle: vm.alertTitle, alertMessage:vm.alertMessage)
            
            Text("")
                .onAppear{
                    startLoading()
                    vm.getProfileRequest { status in
                      stopLoading()
                    }
                }
        }//:ZStack
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
    func logoutAPI(){
        
        //logout api call
        PersistenceController.shared.deleteUserData()
        
        ViewRouter.shared.currentRoot =  .signIn
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}



//struct TodayView: View {
//
//    var body: some View {
//
//        ZStack {
//            colorBackground
//
//            VStack{
//
//                GeometryReader { geometry in
//
//                    ScrollView(.vertical , showsIndicators: false) {
//                        VStack(alignment: .center, spacing: 20) {
//
//                            Text("TodayView")
//                        }//:VStack
//                        .frame(minHeight: geometry.size.height)
//                    }//:ScrollView
//                    .frame(width: geometry.size.width)
//                }//:GeometryReader
//            }//:VStack
//
//        }//:ZStack
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea(.all)
//    }
//}
