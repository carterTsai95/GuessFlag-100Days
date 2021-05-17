//
//  ContentView.swift
//  GuessFlag-100Days
//
//  Created by Hung-Chun Tsai on 2021-01-08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var countryUserTap = ""
    //To observe the user tapping status
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 20) {
                Text("Tap the flag of")
                    .foregroundColor(.white)

                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        //Note: The renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button.
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .gray, radius: 3)
                    }
                }
                
                Text("Current Score: \(userScore)")
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background(Color.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your socre is \(userScore)") + Text(countryUserTap),
                  dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "-Correct Answer-"
            userScore += 1
            countryUserTap = ""
        } else {
            scoreTitle = "-Wrong Answer-"
            countryUserTap = "\nThe flag you tap is '\(countries[number])'"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

//Challenge

/*

 1. -(DONE)- Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert.
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
