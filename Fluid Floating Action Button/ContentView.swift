//
//  ContentView.swift
//  Fluid Floating Action Button
//
//  Created by Afeez Yunus on 19/02/2025.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @StateObject private var fab = fabView()
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
                    StatIconView(label: "7", image: "flame.fill", color: Color.orange, value: 7)
                        StatIconView(label: "2", image:"heart.fill", color: Color.pink, value: 2)
                    
                }
                Spacer()
            }
            .padding(.leading)
            VStack {
                Spacer()
                VStack{
                    fab.view()
                }
                    .frame(height:500)
                    .scaleEffect(1.1, anchor: .bottomTrailing)
                    .offset(x: 10, y:30)
                    .onChange(of: fab.Stage1) { oldValue, newValue in
                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                                    
                        print("Stage 1 is \(newValue)")
                    }
                    .onChange(of: fab.Stage2) { oldValue, newValue in
                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                        print("Stage 2 is \(newValue)")
                    }
                    .onChange(of: fab.Stage3) { oldValue, newValue in
                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                        print("Stage 3 is \(newValue)")
                    }
                    .onChange(of: fab.isActive) { oldValue, newValue in
                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                        print(newValue)
                    }
            }
        }
        .padding(.vertical)
        .background(Color("BG"))
        .ignoresSafeArea(.all)
        /*
        .onAppear{
            do {
                try  fab.setTextRunValue("Stage2Opt1", path: "Stage 2", textValue: "Ok, let me go")
            } catch {
                
            }
        } */
    }
}

#Preview {
    ContentView()
}

class fabView: RiveViewModel {
    @Published var Stage1 = ""
    @Published var Stage2 = ""
    @Published var Stage3 = ""
    @Published var isActive = false

    init() {
        super.init(fileName: "menu_interaction", stateMachineName: "State Machine 1", artboardName: "Main")
    }
    
    func view() -> some View {
        super.view()
    }
    // Subscribe to Rive events
    @objc func onRiveEventReceived(onRiveEvent riveEvent: RiveEvent) {
        if let generalEvent = riveEvent as? RiveGeneralEvent {
            let eventProperties = generalEvent.properties()
            
            if let Stage1Value = eventProperties["Phase1"] as? String {
                Stage1 = Stage1Value
            }
            if let Stage2Value = eventProperties["Phase2"] as? String {
                Stage2 = Stage2Value
            }
            if let Stage3Value = eventProperties["Phase3"] as? String {
                Stage3 = Stage3Value
            }
            if let isFabActive = eventProperties["isActive?"] as? Bool {
                isActive = isFabActive
            }
        }
    }
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
