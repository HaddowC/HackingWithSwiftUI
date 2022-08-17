//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Calum Haddow on 06/08/2022.
//

import SwiftUI



struct ContentView: View {
    
    @State private var showingScore = false
    @State private var gameOver = false
    
    @State private var score = 0
    @State private var cpuScore = 0
    
    @State private var scoreTitle = ""
    @State private var gameOvertitle = ""
    
    @State private var playerChoice = 0
    @State private var cpuChoice = Int.random(in: 0...2)
    
    @State private var roundCounter = 1
    
    let choice = ["🪨", "📄", "✂️"]
   
    
    var body: some View {
        ZStack {
            
            RadialGradient(colors: [.red, .yellow], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Text("Rock, Paper, Scissors")
                    .foregroundColor(.black)
                    .font(.largeTitle.weight(.black))
                
                Text("Please pick one")
                    .foregroundColor(.black)
                    .font(.subheadline.weight(.bold))
                
                VStack(spacing: 20) {
                    
                    ForEach(0..<3, id: \.self) { number in
                        
                        Button {
                            emojiTapped(number, cpuChoice)
                        } label: {
                            Text("\(choice[number])")
                                .font(.system(size: 75))
                        }
                        
                    }
                }
                
                Bottomtext(text: "Round \(roundCounter) / 8")
               
                HStack {
                    Spacer()
                    
                    Bottomtext(text: "You: \(score)")
                    
                    Spacer()
                    
                    Bottomtext(text: "CPU: \(cpuScore)")
                    
                    Spacer()
                }
                
            } // END of VSTACK
            
        } // End of Zstack
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("score: \(score)")
        }
        
        .alert(score > cpuScore ? "Winner" : "Loser", isPresented: $gameOver) {
            Button("New Game", action: newGame)
        } message: {
            Text("Final Scores: You: \(score) | CPU: \(cpuScore)")
        }
    }
    
    
    func emojiTapped(_ selectedChoice: Int, _ computerChoice: Int) {
        
            if selectedChoice == 0 && computerChoice == 2 ||
                selectedChoice == 1 && computerChoice == 0 ||
                selectedChoice == 2 && computerChoice == 1 {
                
                score += 3
                scoreTitle = "Winner CPU chose \(choice[computerChoice])"
                
            } else if selectedChoice == 0 && computerChoice == 1 ||
                        selectedChoice == 1 && computerChoice == 2 ||
                        selectedChoice == 2 && computerChoice == 0 {
                
                cpuScore += 3
                scoreTitle = "Loser CPU chose \(choice[computerChoice])"
                
            } else {
                score += 1
                cpuScore += 1
                scoreTitle = "Draw"
            }
            
        if roundCounter < 8 {
            showingScore = true
            roundCounter += 1
        }
        else {
            gameOver = true
        }
    
    }
    
    func nextRound() {
        
        showingScore = false
        cpuChoice = Int.random(in: 0...2)
        
    }
    
    func newGame() {
        
        showingScore = false
        cpuChoice = Int.random(in: 0...2)
        
        score = 0
        cpuScore = 0
        roundCounter = 1
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
