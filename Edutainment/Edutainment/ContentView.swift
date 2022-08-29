//
//  ContentView.swift
//  Edutainment
//
//  Created by Calum Haddow on 25/08/2022.
//

import SwiftUI

struct ContentView: View {
    
  
    
    var body: some View {
        Game()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
