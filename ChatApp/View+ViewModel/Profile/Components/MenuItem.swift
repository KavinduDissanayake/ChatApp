//
//  MenuItem.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-25.
//

import SwiftUI


struct MenuItemView<Content: View>: View {
    var destinationView: Content
    var title: String

    init(destinationView: Content,  title: String) {
        self.destinationView = destinationView
        self.title = title
    }

    var body: some View {
        NavigationLink(destination: destinationView){
          //  LazyVStack(alignment:.leading){
                HStack{
            
                    Text(title)
                        .font(.customFont(.DMSansBold, 15))
                        .foregroundColor(Color.primary)
                    
                    Spacer()
                    
                    Image("ic_nav_foward")
                        .resizable()
                        .foregroundColor(grayColor)
                        .frame(width: 30,height: 30)
                    
                }//;HStack
          //  .padding()
                .padding(.horizontal,20)
                .padding(.vertical,5)
        }
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(destinationView: Text("View1"), title: "1st")
            .previewLayout(.sizeThatFits)
    }
}

struct MenuItem: View {
    var title:String
    var body: some View {
        HStack {
            Text(title)
                .font(.customFont(.DMSansBold, 15))
            Spacer()
            Image("ic_nav_foward")
                .resizable()
                .foregroundColor(grayColor)
                .frame(width: 30,height: 30)
        }
        .padding(.horizontal,20)
        //.padding(.vertical,10)
    }
}

//struct MenuItem_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItem(title: "Account")
//            .previewLayout(.sizeThatFits)
//    }
//}
