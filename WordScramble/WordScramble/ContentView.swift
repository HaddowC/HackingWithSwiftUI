//
//  ContentView.swift
//  WordScramble
//
//  Created by Calum Haddow on 13/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
        
            List {
                
                Section {
                    TextField("Enter you word", text: $newWord)
                        .autocapitalization(.none)
                } // End of Section 1
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        } // end of HStack
                    }
                } // End of Section 2
                
            } // end of List
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                // CHALLENGE 2
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Game") {
                        startGame()
                    }
                }
                
                // CHALLENGE 3
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Score: \(score) ")
                }
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role:   .cancel) { }
            } message: {
                Text(errorMessage)
            }
        } // End of NavigationView
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // CHALLENGE 1 from 0 to 3
        guard answer.count > 3 else {
            wordError(title: "Word needs to be longer than 3", message: "Get the thinking cap on")
            return
        }
        
        // Extra Validation to come
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already used", message: "be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You cant spell that word from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word Not Real", message: "That's not a real word!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += newWord.count
        newWord = ""
    } // END OF ADDNEWWORD
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // CHALLENGE 3
                usedWords.removeAll()
                score = 0
                return
            }
            
        }
        
        fatalError("Could not load from start.txt from bundle")
    } // END OF STARTGAME
    
    // CHECKS IF THE WORD IS ALREADY BEEN USED
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // CHECKS IF THE WORD IS POSSIBLE
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        // this shuffles through the rootword to see if the submiteed word is a match
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    // CHECKS IF THE WORD IS REAL
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    // ERROR HANDLER
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
