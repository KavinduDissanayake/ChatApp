//
//  UserContactCard.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-15.
//

import SwiftUI
import SDWebImageSwiftUI


struct UserContactCard: View {
    var userModel:User
    var body: some View {
        HStack {
            ZStack {
                
                WebImage(url: URL(string: userModel.avatarURL ?? "" ))
                    .placeholder(Image("Icon_placeholder"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("#E3E3E3"), lineWidth: 2)
                     )
                
                  VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if userModel.isOnline ?? false {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(Color("#43a061"))
                                .padding(.leading,10)
                        }
                     
                    }//;HStack
                }
                
            }
            .frame(width: 40, height: 40, alignment: .center)
            
            VStack(alignment: .leading){
                Text(userModel.name ?? "N/A")
                    .font(.customFont(.DMSansBold, 14))
                Text("\(calculateAge(fromDOB:userModel.dob ?? "")) age")
                    .font(.customFont(.DMSansMedium, 12))
            }
            .padding(.horizontal,10)
            
            Spacer()
            Image("ic_nav_foward")
                .resizable()
                .foregroundColor(grayColor)
                .frame(width: 30,height: 30)
        }
        .padding(.horizontal,20)
        .padding(.vertical,10)
    }
    
    func calculateAge(fromDOB dobString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dob = dateFormatter.date(from: dobString) else { return 0 }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob, to: Date())
        return ageComponents.year ?? 0
    }
}

struct UserContactCard_Previews: PreviewProvider {
    static var previews: some View {
        UserContactCard(userModel: dummyUse1)
    }
}
