//
//  ContentView.swift
//  FirstApp
//
//  Created by Udrea Alexandru-Iulian-Alberto on 08.06.2022.
//


import SwiftUI
import CoreData

var usern = ""

struct Settings : View {
    @State  var currentWeight = 0
    @State  var goalWeight = 0
    @State  var selectedHeight = 0
    @State  var selectedAge = 0
    @State  var selectedGender :String=""
    @State  var firstName :String=""
    @State  var lastName :String=""
    @State  var data=false
    @State private var userFound = false

    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    var body: some View {
        let heights = 100..<200
        let ages = 1..<100
        let genders=["male","female"]
        Form {
            Section(header: Text("Set your goals so I can personalize your calories intake:")){
                
                TextField("First name:" , text: $firstName)
                    .padding()
                TextField("Last name:" , text: $lastName)
                    .padding()
                Text("Set current weight")
                TextField("Current weight", value: $currentWeight,format: .number)
                    .textFieldStyle(.roundedBorder)
                Text("Set goal weight")
                TextField("Goal weight:" , value: $goalWeight,format: .number)
                    .textFieldStyle(.roundedBorder)
                
                //Text("Set your height")
                Menu("Height") {
                Picker(selection: $selectedHeight,label: Text("Select your height"))
                {
                
                    ForEach(heights, id: \.self) {
                        Text(String($0))

                                            }
                                        }
                    .pickerStyle(.menu)}
                
                //Text("Set your age")
                Menu("Age"){
                Picker(selection: $selectedAge,label: Text("Select age"))
                {
                
                    ForEach(ages, id: \.self) {
                        Text(String($0))

                                            }
                                        }
                    .pickerStyle(.menu)}
                
                //Text("Set your gender")
                Menu("Gender"){
                Picker(selection: $selectedGender,label: Text("Select gender"))
                {

                    ForEach(genders, id: \.self) {
                        Text(String($0))

                                            }
                                        }
                    .pickerStyle(.menu)}
                
            
        }
        }.navigationBarBackButtonHidden(true)
            .offset(y:-35)
        Button("Save data",action: {
            if(selectedHeight>0 && selectedAge>0 && !(selectedGender.isEmpty)  && !(firstName.isEmpty) && !(lastName.isEmpty) && currentWeight>0 && goalWeight>0){
                data=true
                for user in users {
                    if(user.username==usern)
                    {
                        userFound=true
                        user.currentWeight=Float(currentWeight)
                        user.goalWeight=Float(goalWeight)
                        user.firstName=firstName
                        user.lastName=lastName
                        user.height=Int16(selectedHeight)
                        user.age=Int16(selectedAge)
                        if(selectedGender=="male"){
                            user.gender=true
                        }
                        else{
                            user.gender=false
                        }
                        print(user)
                    }
                
            }
            print(data)

            }})
            
            NavigationLink("",destination:  MainPage(), isActive: $data )

        
}
}

               

struct MainPage : View {
    
    @State var food = ""
    var body: some View {
        
        Form {
        Text("Hello \(usern)")
        Text("Log what you have eaten")
        TextField("required", text: $food)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
        
        
        


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
                                               usern=user.username!
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
                                       NavigationLink("Submit", destination:  MainPage(), isActive: $userFound )

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

        }
        }


struct Register: View {

    @Environment(\.managedObjectContext) var moc
    @State var _username=""
    @State var _password=""
    @State private var userCreated = false
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
                                       userCreated=true
                                       try? moc.save()


                                   }) {
                                       
                                        NavigationLink("Submit", destination:  Settings(), isActive: $userCreated )
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
