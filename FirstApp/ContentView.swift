//
//  ContentView.swift
//  FirstApp
//
//  Created by Udrea Alexandru-Iulian-Alberto on 08.06.2022.
//


import SwiftUI
import CoreData

struct MainPage : View {
    var body: some View {
        Text("Account main page")
        .navigationBarBackButtonHidden(true)

    }
}


struct Login: View {
    @State var username=""
    @State var password=""
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    @State private var userFound = false

    var body: some View {
        
            NavigationView{
            Form{
                
                Section(header: Text("Profile"))
                {
                    TextField("Username:" , text: $username)
                    SecureField("Password:" , text: $password)

                }
                Section {
                    var count=0
                                   Button(action: {
                                       for user in users {
                                           if(user.username==username && user.password==password)
                                           {
                                               count=1
                                               print("found user \(user.username)  and password  \(user.password)")
                                               userFound=true
                                           }
                                           if(count==0)
                                           {
                                               print("user not found")
                                           }
                                                
                                                
                                       }
                                       print("username: \(username)  password:\(password)")
                                   }) {
//                                       Text("Submit")
//                                           .foregroundColor(.blue)
                                       NavigationLink("Submit", destination:  MainPage(), isActive: $userFound)

                                   }
                                
                               }
        }.navigationTitle("Login to your account")
                    .foregroundColor(.red)
                    .accentColor(.orange)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.orange]),
                        startPoint: .top, endPoint: .bottom))
                    .onAppear { // ADD THESE
                      UITableView.appearance().backgroundColor = .clear
                    }
                    .onDisappear {
                      UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
    }
            .navigationBarBackButtonHidden(true)

        }
        }


struct Register: View {

    @Environment(\.managedObjectContext) var moc
    @State var _username=""
    @State var _password=""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Profile"))
                {
                    TextField("Username:" , text: $_username)
                    SecureField("Password:" , text: $_password)

                }
                Section {
                                   Button(action: {
                                       print("username: \(_username)  password:\(_password)")
                                       let user = User(context: moc)
                                       user.id = UUID()
                                       user.username = "\(_username)"
                                       user.password = "\(_password)"
                                       try? moc.save()


                                   }) {
                                       Text("Submit")
                                           .foregroundColor(.blue)
                                   }
                               }
        }.navigationTitle("Create your account")
                .foregroundColor(.red)
                .accentColor(.orange)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.blue]),
                    startPoint: .top, endPoint: .bottom))
                .onAppear { // ADD THESE
                  UITableView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                  UITableView.appearance().backgroundColor = .systemGroupedBackground
                }
    }
}
}

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {

        ZStack {

        Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                
                Text("Count your macros!")
                    .font(.title)
                    .foregroundColor(.black)
                    .position(x: 150, y: 250)
                    .font(.system(size: 35))
                Divider().background(Color.white)
                Text("Do you need to lose some fat or improve your fitness? This app comes in your help! Create an account and start your journey!")
                    .foregroundColor(.black)
                    .position(x: 150, y: 100)
                    .font(.system(size: 23))
                

                Divider().background(Color.white)
                NavigationLink(destination: Register()) {
                Text("Register now!")
                        .padding()
                        .background(Color(red: 0.6, green: 0.4, blue: 0.2))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .font(.system(size: 25))

                }
                NavigationLink(destination: Login()) {
                Text("Login")
                        .padding()
                        .background(Color(red: 0.6, green: 0.4, blue: 0.2))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .font(.system(size: 25))
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 64)
           
        }
    }
    }
}
        
        /*VStack {
            List(users) { user in
                Text(user.username ?? "Unknown")
            }
        }
}
}
}*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                //.previewInterfaceOrientation(.portrait)
                //.previewInterfaceOrientation(.landscapeRight)
        }
    }
}
