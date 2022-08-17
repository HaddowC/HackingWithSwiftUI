//
//  FlagImage.swift
//  Guess the Flag
//
//  Created by Calum Haddow on 05/08/2022.
//

import SwiftUI
import Foundation

struct FlagImage: View {
    
    var flag: String
    
    var body: some View {
        
       Image(flag)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
