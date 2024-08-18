//
//  SpeakButtonView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import SwiftUI

struct SpeechContent: Hashable {
    let title: String
    let content: String
}

struct SpeakButtonView: View {
    @StateObject var speechSynthesizer = SpeechSynthesizer()
    
    @Binding var textContent: String
    @Binding var subContentList: [SpeechContent]?
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking()
            } else {
                //Content clean up
                let content = textContent.replacingOccurrences(of: ":", with: ". \n")
                
                // if we dont find Tamil voice then instruct the user to enable the setting..
                speechSynthesizer.speak(text: content) { success in
                    if !success {
                        showAlert = true
                    }
                }
            }
        } label: {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.caption)
//                Text(speechSynthesizer.isSpeaking ? "நிறுத்து" : "வாசி")
                Text(speechSynthesizer.isSpeaking ? "Stop" : "Speak")
            }
            .font(.subheadline)
            .foregroundStyle(Color("TextColor"))
        }
        .contextMenu {
            if let subContentList = subContentList {
                // for explanations
                ForEach(subContentList, id:\.self) { subContent in
                    Button(action: {
                        if speechSynthesizer.isSpeaking {
                            speechSynthesizer.stopSpeaking()
                        } else {
                            //Content clean up
                            let content = subContent.content.replacingOccurrences(of: ":", with: ". \n")
                            
                            // if we dont find Tamil voice then instruct the user to enable the setting..
                            speechSynthesizer.speak(text: content) { success in
                                if !success {
                                    showAlert = true
                                }
                            }
                        }
                    }) {
                        Image(systemName: "speaker.wave.2")
                        Text("\(subContent.title)")
                    }
                }
            }
        }
        .padding(.trailing, size10)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Tamil Voice Not Available"),
                message: Text("To enable Tamil text-to-speech, go to Settings > Accessibility > Spoken Content > Voices > Tamil and download the Tamil voice."),
                primaryButton: .default(Text("Open Settings"), action: {
                    openMainSettings()
                }),
                secondaryButton: .default(Text("OK"))
            )
        }
        .onChange(of: textContent) { newValue in
            // Stop speaking when the content changes
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking()
            }
        }
        .onDisappear {
            speechSynthesizer.stopSpeaking()
        }
    }
    
    func openMainSettings() {
        guard let url = URL(string: "App-Prefs:root=General") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
