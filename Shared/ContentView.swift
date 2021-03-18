//
//  ContentView.swift
//  Shared
//
//  Created by Mafalda on 3/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
        List {
            Text("Brandon")
            Text("Adelita")
        }
            .navigationTitle("Contacts")
            Image("FixMe")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
