//
//  ContentView.swift
//  Cahoot
//
//  Created by Yuhan Du on 15/6/22.
//

import SwiftUI

struct Question {
    var qn: String
    var option1: String
    var option2: String
    var option3: String
    var option4: String
    var image: String
    var answer: String
}

struct SummaryView: View {
    @State var image = ""
    @State var text = ""
    var qnCorrect: Int
    var curtime: Int
    var body: some View {
        ZStack{
            Color.black
            VStack{
                if qnCorrect == 0{
                Image("0:4")
                    .resizable()
                    .scaledToFit()
                    Text("Aww man go google a link to watch paw patrol free online (pirating ahem)")
                        .foregroundColor(.white)
                        .padding()
                }
                else if qnCorrect == 1{
                Image("1:4")
                    .resizable()
                    .scaledToFit()
                    Text("Aww man go google a link to watch paw patrol free online (pirating ahem)")
                        .foregroundColor(.white)
                        .padding()
                }
                else if qnCorrect == 2{
                Image("2:4")
                    .resizable()
                    .scaledToFit()
                    Text("You passed, congratulations - but you still kinda suck :/")
                        .foregroundColor(.white)
                        .padding()

                }
                else if qnCorrect == 3{
                Image("3:4")
                    .resizable()
                    .scaledToFit()
                    Text("THE FATAL FLAW IN YOUR SEEMINGLY COMPLETE KNOWLEDGE HAS SURFACED GO TO THE WIKI AND PATCH IT UP - YOU WERE SO CLOSE TO PERFECTION SIGH")
                        .foregroundColor(.white)
                        .padding()

                }
                else if qnCorrect == 4{
                Image("4:4")
                    .resizable()
                    .scaledToFit()
                    Text("Your childhood has been certified to be amazing, perfect and marvellous")
                        .foregroundColor(.white)
                        .padding()

                }
            }
        }
    }
}


struct ContentView: View {
    
    let Quiz = [
            Question(qn: "Where does the Paw Patrol live?", option1: "Rescue Bay", option2: "Foggy Bottoms", option3: "Adventure Bay", option4: "Meriden", image: "q1", answer: "Adventure Bay"),
            Question(qn: "What's the name of the Mayor?", option1: "Mayor Goodway", option2: "Mayor Alex", option3: "Mayor Jeff", option4: "Mayor Mickey", image: "q2", answer: "Mayor Goodway"),
            Question(qn: "What kind of pet does Mayor Goodway have?", option1: "Dog", option2: "Chicken" , option3: "Horse", option4: "Cat", image: "q3", answer: "Chicken"),
            Question(qn: "Which pup hates the water?", option1: "Zoomer", option2: "Skye", option3: "Rubble", option4: "Rocky", image: "q4", answer: "Rocky")
        ]
        
        @State var questionIndex = 0
        @State var correctans = false
        @State var wrongans = false
        @State var qnCorrec = 0
        @State var isSheet = false
        @State var timeRemaining = 60
           let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var ages = UserDefaults.standard.object(forKey: "ages") as? [Int] ?? []
    
    @State var users = UserDefaults.standard.object(forKey: "users") as? [String] ?? []
    @State var passwords = UserDefaults.standard.object(forKey: "passwords") as? [String] ?? []
    
    
    
    @State var age = ""
    @State var user = ""
    @State var password = ""
    @State var notice = false
    @State var passwordTooLong = false
    @State var signedUp = false
    @State var notOldEnough = false
    @State var showSheet = false
    @State var loginUser = ""
    @State var loginPassword = ""
    @State var isLoggedOn = false
    @State var isLoggedIn = false

   
    
    
    var body: some View {
        
        
        
        VStack {
            Spacer()
            
            
            
            
            Text("Sign up.")
                .bold()
                .font(.largeTitle)
            Text("It's simple.")
                .bold()
                .font(.largeTitle)
            
            Spacer()
            
            
            VStack {
                
                
                Divider()
                TextField("Username:", text: $user)
                
                Divider()
                
                TextField("Age:", text: $age)
                
                Divider()
                SecureField("Password:", text: $password)
                
                Divider()
            }
            
            Spacer()
            
            
            
            
            Button {
                
                
                if Int(age) != nil {
                    
                    let num = Int(age) ?? 0
                    
                    if num > 6 {
                        
                        if password.count >= 8 {
                            
                            
                            ages.append(Int(age) ?? 0)
                            users.append(user)
                            passwords.append(password)
                            
                            UserDefaults.standard.set(ages, forKey: "ages")
                            
                            UserDefaults.standard.set(users, forKey: "users")
                            
                            UserDefaults.standard.set(passwords, forKey: "passwords")
                            
                            
                            
                            signedUp = true
                        } else {
                            passwordTooLong = true
                        }
                    } else {
                        notOldEnough = true
                    }
                    
                } else {
                    notice = true
                }
            } label: {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(colors: [ .gray, .black], startPoint: .bottomLeading, endPoint: .topLeading))
                        .frame(width: 200, height: 50)
                    
                    Text("Sign up")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    
                }
            }
            .alert("You're signed up", isPresented: $signedUp) {
                
            } message: {
                Text("Login to get started!")
            }
            .alert("Please enter a real age", isPresented: $notice) {
                
            } message: {
                Text("The age you entered isn't even a number.")
            }
            .alert("Your password is too short.", isPresented: $passwordTooLong) {
                
            } message: {
                Text("It must be at least 8 characters long.")
            }
            .alert("You're not old enough!", isPresented: $notOldEnough) {
                
            } message: {
                Text("You must be at least 7 years old to join.")
            }
            
            Spacer()
            
            Button("Already have an account? Login!") {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                Spacer()
                Text("Login")
                    .bold()
                    .font(.largeTitle)
                
                Divider()
                TextField("Username:", text: $loginUser)
                Divider()
                Divider()
                
                SecureField("Password:", text: $loginPassword)
                Divider()
                
                Button(action: {
                    if user == loginUser {
                        if password == loginPassword {
                            isLoggedIn = true
                        }
                    }
                }) {
                    Text("Log in")
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                        .cornerRadius(7)
                        .foregroundColor(.white)
                        .background(.gray)
                    
                }
                .sheet(isPresented: $isLoggedIn) {
                    ZStack{
                                Color.purple
                                    .edgesIgnoringSafeArea(.all)
                                VStack{
                                    
                                 
                                    
                                    Text("\(timeRemaining)")
                                                .onReceive(timer) { _ in
                                                    if timeRemaining > 0 {
                                                        timeRemaining -= 1
                                                    }
                                                    
                                                    if timeRemaining == 0 {
                                                        isSheet = true
                                                    }
                                                    
                                                }
                                    
                                    Text("\(Quiz[questionIndex].qn)")
                                        .font(.largeTitle)
                                        .padding()
                                        .foregroundColor(.white)
                                    Image("\(Quiz[questionIndex].image)")
                                        .resizable()
                                        .scaledToFit()
                                    HStack{
                                        VStack{
                                            Button {
                                                if Quiz[questionIndex].option1 == Quiz[questionIndex].answer{
                                                    correctans = true
                                                    qnCorrec+=1
                                                }
                                                else{
                                                    wrongans = true
                                                }
                                            } label: {
                                                Text("\(Quiz[questionIndex].option1)")
                                                    .font(.system(size: 17))
                                                    .frame(width: 120)
                                                    .padding()
                                                    .background(Color.red)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    
                                            }
                                            Button {
                                                if Quiz[questionIndex].option2 == Quiz[questionIndex].answer{
                                                    correctans = true
                                                    qnCorrec+=1
                                                }
                                                else{
                                                    wrongans = true
                                                }
                                            } label: {
                                                Text("\(Quiz[questionIndex].option2)")
                                                    .font(.system(size: 17))
                                                    .frame(width: 120)
                                                    .padding()
                                                    .background(Color.yellow)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }

                                        }
                                        VStack{
                                            Button {
                                                if Quiz[questionIndex].option3 == Quiz[questionIndex].answer{
                                                    correctans = true
                                                    qnCorrec+=1
                                                }
                                                else{
                                                    wrongans = true
                                                }
                                            } label: {
                                                Text("\(Quiz[questionIndex].option3)")
                                                    .font(.system(size: 17))
                                                    .frame(width: 120)
                                                    .padding()
                                                    .background(Color.blue)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }

                                            Button {
                                                if Quiz[questionIndex].option4 == Quiz[questionIndex].answer{
                                                    correctans = true
                                                    qnCorrec+=1
                                                }
                                                else{
                                                    wrongans = true
                                                }
                                            } label: {
                                                Text("\(Quiz[questionIndex].option4)")
                                                    .font(.system(size: 17))
                                                    .frame(width: 120)
                                                    .padding()
                                                    .background(Color.green)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }

                                        }
                                    }
                                }
                            }
                            .alert("You're right! The answer is \(Quiz[questionIndex].answer).", isPresented: $correctans){
                                        Button (role: .cancel){
                                            if(questionIndex != 3){
                                                questionIndex+=1
                                            }
                                            else{
                                                isSheet = true
                                            }
                                        }label: {
                                            Text("OK")
                                        }
                            }
                            .alert("You're wrong! The answer is \(Quiz[questionIndex].answer).", isPresented: $wrongans){
                                        Button (role: .cancel){
                                            if(questionIndex != 3){
                                                questionIndex+=1
                                            }
                                            else{
                                                isSheet = true
                                            }
                                        }label: {
                                            Text("OK")
                                        }
                            }
                            .sheet(isPresented: $isSheet) {
                                SummaryView(qnCorrect: qnCorrec,curtime: timeRemaining)
                            }
                }
                
                Spacer()
            }
        }
        
       
        
    }
    
 
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
