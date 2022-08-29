//
//  Game.swift
//  Edutainment
//
//  Created by Calum Haddow on 25/08/2022.
//

import SwiftUI

struct Game: View {
    
    // MARK: Game settings variables
    @State private var timesTable = 0
    @State private var question = "5"
    @State private var showingGame = false
    let numberOfquestions = ["5", "10", "15", "20"]
    
    // MARK: Game variables
    var questionArray = Questions()
    @State private var questionNumber = 0
    @State private var randomNumber = Int.random(in: 0...2)
    @State private var gameCounter = 1
    @State private var arrayOfAnimals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "elephant", "duck", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "zebra", "panda", "parrot", "whale"].shuffled()
    @State private var score = 0
    @State private var gameOver = false
    
    // MARK: EXTRA WORK
    @State private var arrayOfQs: [Question] = []
    @State private var arrayOfAnswers: [Int] = []
    @State private var isCorrectArray: [Bool] = []
    
 
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
            
                LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                
                VStack(alignment: .center) {
                
                    if !showingGame {
                        GameSettings()
                        
                    } else {
                        if !gameOver {
                            QuestionView()
                        } else {
                            withAnimation {
                                AnswerView(arrayOfQs,arrayOfAnswers, isCorrectArray)
                            }
                        }
                    }
                    
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .fill(.white.opacity(0.5))
                }
                .padding(.horizontal, 10)
                
            }
            .navigationTitle("Edutainment")
          
          
        } // end of NavigationView
    
    }
    
    // MARK: Game Settings
    @ViewBuilder
    func GameSettings()-> some View {
        
        VStack(spacing: 20) {
            
            Text("Pick Times Table")
                .font(.title2.bold())
            
            Picker("", selection: $timesTable) {
                ForEach(2..<21) {
                    Text("\($0)")
                        .font(.title2.bold())
                }
            } .pickerStyle(.wheel)
            
            Text("Number of questions?")
                .font(.title2.bold())
            
            Picker("Questions", selection: $question) {
                ForEach(numberOfquestions, id: \.self) { q in
                    Text(q)
                }
            }.pickerStyle(.segmented)
            
            Button {
                // Start Game
                startGame(question)
                
                
            } label: {
                Text("PLAY")
            }
            .blueButton()
            
            
        }
       
    }
    
    // MARK: Question View
    @ViewBuilder
    func QuestionView()-> some View {
        
        VStack(spacing: 20) {
            
            Text("Question \(gameCounter) out of \(questionNumber)")
                .font(.headline.bold())
            
            let number1 = questionArray.arrayOfQuestion[randomNumber].number1
            let number2 = questionArray.arrayOfQuestion[randomNumber].number2
            
            Text("\(number1) x \(number2) = ")
                .font(.title.bold())
            
            HStack {
            ForEach(0..<3) { number in
                
                Button {
                    checkAnswer(questionArray.arrayOfQuestion[number].answer)
                } label: {
                    AnimalButton(animal: arrayOfAnimals[number], number: questionArray.arrayOfQuestion[number].answer)
                    }
    
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
       
    }
    
    // MARK: ANSWER VIEW
    @ViewBuilder
    func AnswerView(_ numberOfQ: [Question], _ userAnswer: [Int], _ isCorrect: [Bool])-> some View {
        
        ScrollView {
            VStack(spacing: 20) {
             
                Text("Game Over!")
                    .font(.largeTitle.bold())
                
                Text("you scored \(score) out of \(questionNumber)")
                    .font(.headline.bold())
                
                ForEach(0..<numberOfQ.count, id: \.self) { question in
                    
                    HStack {
                        Spacer()
                        
                        Text("\(numberOfQ[question].number1) x \(numberOfQ[question].number2)")
                            .font(.headline.bold())
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                             Text("Your Answer: \(userAnswer[question])")
                            .foregroundColor(isCorrect[question] ? .green : .red)
                        
                            Text("Correct Answer: \(numberOfQ[question].answer)")
                        }
                        
                        Spacer()
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    Button("Play Again", action: PlayAgain).blueButton()
                        
                    Button("Home", action: resetGame).blueButton()
                    }
                
            }
        }
    }
    
    
    // MARK: Start Game
    func startGame(_ numberTxt: String)  {
        
        switch numberTxt {
        case "10":
                questionNumber = 10
        case "15":
                questionNumber = 15
        case "20":
                questionNumber = 20
        default:
                questionNumber = 5
            
        }
        questionArray.generateQuestions(questionNumber, timesTable + 2)
        showingGame.toggle()
    }
    
    
    // MARK: Answer Checker
    func checkAnswer(_ number: Int) {
        
    let q = questionArray.arrayOfQuestion[randomNumber]
        
        if number ==  q.answer {
            score += 1
            isCorrectArray.append(true)
        } else {
            isCorrectArray.append(false)
        }
        
        
        arrayOfQs.append(Question(number1: q.number1, number2: q.number2, answer: q.answer))
        arrayOfAnswers.append(number)
        
        
        if gameCounter < questionNumber {
        
            gameCounter += 1
            arrayOfAnimals.shuffle()
            questionArray.arrayOfQuestion.shuffle()
            randomNumber = Int.random(in: 0...2)
        } else {
            gameOver = true
        }
        
        
    }
     
   
    // MARK: PLAY AGAIN
    func PlayAgain() {
    
        gameOver = false
        gameCounter = 1
        score = 0
        arrayOfAnimals.shuffle()
        questionArray.arrayOfQuestion.shuffle()
        randomNumber = Int.random(in: 0...2)
        
        arrayOfAnswers.removeAll()
        arrayOfQs.removeAll()
        isCorrectArray.removeAll()
    
    }
   
  
    // MARK: RESET GAME
   func resetGame() {
       gameCounter = 1
       score = 0
       questionArray.arrayOfQuestion.removeAll()
       showingGame.toggle()
       
       gameOver = false
       arrayOfAnswers.removeAll()
       arrayOfQs.removeAll()
       isCorrectArray.removeAll()
    }
    

}
                               

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
