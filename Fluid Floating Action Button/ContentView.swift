//
//  ContentView.swift
//  Fluid Floating Action Button
//
//  Created by Afeez Yunus on 19/02/2025.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    var fab = RiveViewModel(fileName: "menu_interaction", stateMachineName: "State Machine 1", artboardName: "Main")
    var body: some View {
        ZStack(alignment:.leading) {
            VStack (alignment:.leading){
                Spacer()
                VStack(alignment:.leading){
                    Text("23 days")
                    Text("Sober")
                        .opacity(0.5)
                }
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .font(.system(size: 40, weight: .bold, design: .default))
                VStack(spacing:16){
                    StatIconView(label: "7", image: "flame.fill", color: Color.orange, value: 17)
                        StatIconView(label: "2", image:"heart.fill", color: Color.pink, value: 12)
                    
                }
                Spacer()
            }
            .padding(.top)
            VStack {
                Spacer()
                fab.view()
                    .frame(height:500)
            }
        }
        .padding()
        .background(Color("BG"))
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

struct StatIconView: View {
    var label: String
    var image: String
    var color: Color
    var value:Int
    var body: some View {
        HStack ( spacing:8){
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:20)
            Text(label)
                .font(.title3 )
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray)
                .contentTransition(.numericText())
        }
        .foregroundStyle(value > 0 ? color : Color.gray)
    }
}
