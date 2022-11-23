//
//  SplashScreenView.swift
//  NC1
//
//  Created by Davide Ragosta on 23/11/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            Tab_View()
        } else {
            VStack {
                VStack {
                    Image("SplashScreen")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                        .shadow(radius: 10.0)
                    Text("TV Time")
                        .font(.title)
                        .opacity(0.80)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
