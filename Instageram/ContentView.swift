//
//  ContentView.swift
//  Instageram
//
//  Created by Muhammad Fikri Hadian on 25/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
                VStack{
                    GridHorizontal(
                        image1: "img_mount2",
                        image2: "img_landscape",
                        image3: "img_mount1").padding(1)
                    GridVertical(
                        image1: "img_forest",
                        image2: "img_mount3").padding(1)
                    GridHorizontal(
                        image1: "img_beach1",
                        image2: "img_sky",
                        image3: "img_beach2").padding(1)
                }
            .navigationTitle("My Gallery")
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GridHorizontal: View{
    var image1, image2, image3 : String
    
    var body: some View{
        GeometryReader{
            geo in
            HStack{
                NavigationLink(destination: DetailPost(image: image1)){
                    Image(image1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width/3, height: geo.size.height)
                        .clipped()
                }
                NavigationLink(destination: DetailPost(image: image2)){
                    Image(image2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width/3, height: geo.size.height)
                        .clipped()
                }
                NavigationLink(destination: DetailPost(image: image3)){
                    Image(image3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width/3, height: geo.size.height)
                        .clipped()
                }
            }
        }
    }
}

struct GridVertical: View{
    var image1, image2 : String
    
    var body: some View{
        GeometryReader{
            geo in
            VStack{
                NavigationLink(destination: DetailPost(image: image1)){
                    Image(image1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geo.size.height/2)
                        .clipped()
                }
                NavigationLink(destination: DetailPost(image: image2)){
                    Image(image2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geo.size.height/2)
                        .clipped()
                }
            }
        }
    }
}

struct DetailPost: View{
    var image : String
    @State var isLoved : Bool = false
    @State var isShowed = false
    @State var offset = CGSize.zero
    
    var body: some View{
        let drag = DragGesture()
            .onChanged{
                gesture in
                self.offset = gesture.translation
            }
            .onEnded{
                value in
                self.offset = CGSize.zero
                self.isShowed = false
            }
        
        return NavigationView{
            ZStack{
                VStack{
                    VStack{
                        HStack{
                            Image("ic_profile")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            Text("muhfikrihadian")
                            Spacer()
                            Image("ic_menu").resizable().frame(width: 25, height: 25)
                        }.padding()
                        
                        Image(image).resizable().frame(width: 400, height: 400)
                        
                        HStack{
                            if(!isLoved){
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(1)
                                    .onTapGesture {
                                        self.isLoved = true
                                    }
                            }else{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(1)
                                    .foregroundColor(Color.red)
                                    .onTapGesture {
                                        self.isLoved = false
                                    }
                            }
                            Image(systemName: "message")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(1)
                            Button(action: {
                                withAnimation{
                                    self.isShowed.toggle()
                                }
                            }){
                                Image(systemName: "paperplane")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(1)
                            }
                            Spacer()
                            Image(systemName: "bookmark")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(1)
                        }.padding()
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.").padding()
                        
                    }
                    Spacer()
                }
                if self.isShowed{
                    SendPost()
                        .transition(.move(edge: .bottom)).animation(.default)
                        .offset(y:self.offset.height)
                        .gesture(drag)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SendPost: View{
    var body: some View{
        ScrollView{
            VStack(){
                HStack(alignment: .center){
                    Image("ic_dash").resizable().frame(width: 100, height: 30)
                }
                HStack(){
                    Image("ic_profile").resizable().frame(width: 30, height: 30).clipShape(Circle())
                    Text("Tulis pesan...")
                }.frame(alignment: .leading)
                User(name: "Claes", image: "ic_user1")
                User(name: "Alardo", image: "ic_user2")
                User(name: "Carolos", image: "ic_user3")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct User: View{
    var name:String = ""
    var image:String = ""
    
    var body: some View{
        HStack{
            Image(image).resizable().frame(width: 30, height: 30).clipShape(Circle())
            Text(name).bold().font(.callout)
            Spacer()
            Button(action: {}){
                Text("Kirim").background(Color.blue).foregroundColor(Color.white).padding()
            }.frame(width: 100, height: 40)
        }
    }
}
