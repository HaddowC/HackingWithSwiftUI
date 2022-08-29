//
//  QuestionModel.swift
//  Edutainment
//
//  Created by Calum Haddow on 25/08/2022.
//

import Foundation
import SwiftUI

class Questions: ObservableObject {
    
    var arrayOfQuestion = [Question]()
   
        
    func generateQuestions(_ numberOfQuestions: Int, _ number1: Int) {
    
        var arrayOfNumbers = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20].shuffled()
        
            for _ in 1...numberOfQuestions {
               
                let randomNumber = arrayOfNumbers[0]
                
                arrayOfQuestion.append(Question(number1: number1, number2: randomNumber, answer: number1 * randomNumber))
                
                arrayOfNumbers.remove(at: 0)
                
            }
        
        // Re adding the numbers lost by the for loop
        arrayOfNumbers = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    }

}
