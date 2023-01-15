//
//  PDFMessageView.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2023-01-06.
//
import WebKit
import SwiftUI


struct CustomWKWebView: UIViewRepresentable {
    
    @Binding var urlString: String
        
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let url = URL(string: self.urlString) {
            uiView.load(URLRequest(url: url))
        }
    }
}



struct PDFMessageView: View {
    var message:Message
    var isSender = true
    
    @State var showViwer : Bool = false
    
    
    
    var body: some View {
       
        ZStack{
            
            VStack {
                Image("ic_pdf_view")
                    .resizable()
                    .frame(width:50,height:50)
               
            }
            HStack{
                Spacer()
                
                Image("ic_dowload")
                    .resizable()
                    .frame(width: 18,height: 18)
                    .foregroundColor(Color.black)
                    .padding(3)
                    .background(Color.white)
                    .cornerRadius(5)
                
            }
            .padding(.bottom,8)
            .padding(.trailing,5)
            .padding(.top,40)
            
            
            Text("")
                .sheet(isPresented: $showViwer) {
            
                    ZStack {
                        
                        CustomWKWebView(urlString:.constant(message.media?.sourceURL ?? ""))
                            .edgesIgnoringSafeArea(.vertical)
                        
                        VStack {
                            HStack {
                                VStack{
                                    CustomButton(iconName: "ic_close",btnTapCallback: {
                                        showViwer.toggle()
                                    },iconFillColor:whiteColor)
                                    .padding(.all,4)
                                }
                                .background(themeColor)
                                .cornerRadius(5)
                                .padding(.leading,10)
                                .padding(.top,10)
                              
                                Spacer()
                            }//:HStack
                            
                            Spacer()
                        }//:VStack
                    }
            }
            
        }//:VStack
        .background(Color("#e2574c").opacity(0.3))
        .frame(width:70,height: 80)
        .cornerRadius(12)
        .onTapGesture {
            showViwer.toggle()
        }
    }
}

struct PDFMessageView_Previews: PreviewProvider {
    static var previews: some View {
        PDFMessageView(message:dumyMessage)
    }
}
