//
//  SpeakButtonView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 06/08/24.
//

import SwiftUI

struct SpeakButtonView: View {
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    
    @Binding var textContent: String
    @State var textReading: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            if textReading {
                speechSynthesizer.stopSpeaking()
            } else {
                // if we dont find Tamil voice then instruct the user to enable the setting..
                speechSynthesizer.speak(text: textContent) { success in
                    if !success {
                        showAlert = true
                    }
                }
            }
            textReading = !textReading
        } label: {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.caption)
                Text(textReading ? "நிறுத்து" : "வாசி")
            }
            .font(.subheadline)
            .foregroundStyle(Color("TextColor"))
        }
        .padding(.horizontal, size10)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Tamil Voice Not Available"),
                message: Text("To enable Tamil text-to-speech, go to Settings > Accessibility > Spoken Content > Voices > Tamil and download the Tamil voice."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onDisappear {
            speechSynthesizer.stopSpeaking()
        }
    }
}

