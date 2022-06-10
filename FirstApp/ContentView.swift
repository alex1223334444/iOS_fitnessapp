//
//  ContentView.swift
//  FirstApp
//
//  Created by Udrea Alexandru-Iulian-Alberto on 08.06.2022.
//

import SwiftUI
struct SecondView: View {
    @State var username=""
    @State var password=""

    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Profile"))
                {
                    TextField("Username:" , text: $username)
                    SecureField("Password:" , text: $password)

                }
                Section {
                                   Button(action: {
                                       print("username: \(username)  password:\(password)")
                                   }) {
                                       Text("Submit")
                                   }
                               }
        }.navigationTitle("Create your account")
    }
}
}

struct ContentView: View {

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
                Divider().background(Color.white)
                Text("Do you need to lose some fat or improve your fitness? This app comes in your help! Create an account and start your journey!")
                Divider().background(Color.white)
                NavigationLink(destination: SecondView()) {
                Text("Register now!")
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 64)
           
        }
    }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
