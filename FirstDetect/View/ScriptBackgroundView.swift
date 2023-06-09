//
//  ScriptBackgroundView.swift
//  FirstDetect
//
//  Created by Dongnuo Lyu on 3/25/23.
//

import SwiftUI

struct ScriptBackgroundView: View {
    let script: Script
    @State private var showMainView = false
    @StateObject var chatdb = ChatDB.shared
    @EnvironmentObject var scriptdb : ScriptDB

    
    var body: some View {
        ScrollView {
        VStack(alignment: .center) {
            Text("Your Mission")
                .font(.title)
                .fontWeight(.bold)

                Text(script.target)
                    .padding()
            Text("Background")
                .font(.title)
                .fontWeight(.bold)

                Text(script.background)
                    .padding()
                
                Spacer()
                Button(action: {
                    showMainView = true
                    chatdb.update(chats: script.chats)
                    chatdb.postChosenScript(scriptname: script.title){ result in
                        switch result {
                        case .success(let data):
                            if let jsonString = String(data: data, encoding: .utf8) {
                                print("Encoded JSON:\n\(jsonString)")
                            }
                            print("Chat object successfully posted. Server response: \(data)")
                        case .failure(let error):
                            print("Error posting chat object: \(error.localizedDescription)")
                        }
                    }
                }, label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                })
                .padding(.bottom, 16)
            }
        }
        .environmentObject(chatdb)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            Text(script.title)
                .font(.system(size: 24))
        )
        .fullScreenCover(isPresented: $showMainView, content: {
            MainView(script: script, sceneString: scriptdb.sceneString)
        })
    }
}


struct ScriptBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ScriptBackgroundView(script: Script(title: "Script 1", author: "Miumiu"))
    }
}
