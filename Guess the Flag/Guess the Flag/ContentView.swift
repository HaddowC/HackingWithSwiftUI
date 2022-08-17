//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Calum Haddow on 03/08/2022.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // CHALLENGE 1
    @State private var score = 0
    
    // CHALLENGE 3
    @State private var gameCounter = 0
    @State private var gameOver = false
    
    var body: some View {
        
        ZStack {
            /*
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            */
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                    Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    } // End of VStack 1
                
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                        }
                        
                    } // End of ForEach
                    
                } // End of Main VStack
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
               
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
        } // End of ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score)")
        }
        
        // CHALLENGE 3
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("You Scored \(score) out of 8")
        }
        
    }
    
    
    func flagTapped(_ number: Int) {
        if gameCounter != 7 {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            gameCounter += 1
        } else {
            // CHALLENGE 2
            scoreTitle = "Wrong thats \(countries[number])"
            
            gameCounter += 1
        }
        
        showingScore = true
        } else {
            gameOver = true
        } // CHALLENGE 3
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // CHALLENGE 3
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        score = 0
        gameCounter = 0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
