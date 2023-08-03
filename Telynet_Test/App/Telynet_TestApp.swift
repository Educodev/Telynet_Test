//
//  Telynet_TestApp.swift
//  Telynet_Test
//
//  Created by Eduardo Herrera on 3/8/23.
//

import SwiftUI

@main
struct Telynet_TestApp: App {
    //Instance global viewModel
    @ObservedObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //dependency injection
                .environmentObject(viewModel)
                .tint(.purple)
                .font(.system(size: 18, weight: .bold, design: .serif))
        }
        
    }
}
