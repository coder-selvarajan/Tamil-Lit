//
//  TamilKeyboardInstructionView.swift
//  Tamil Lit
//
//  Created by Selvarajan on 31/07/24.
//

import SwiftUI

struct TamilKeyboardInstructionView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Enable \nTamil Keyboard on iPhone")
                    .font(.title2) // Smaller title
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                InstructionStepView(
                    stepNumber: 1,
                    instruction: "Open the Settings app on your iPhone."
                )
                
                InstructionStepView(
                    stepNumber: 2,
                    instruction: "Go to General."
                )
                
                InstructionStepView(
                    stepNumber: 3,
                    instruction: "Tap on Keyboard."
                )
                
                InstructionStepView(
                    stepNumber: 4,
                    instruction: "Select Keyboards."
                )
                
                InstructionStepView(
                    stepNumber: 5,
                    instruction: "Tap on Add New Keyboard."
                )
                
                InstructionStepView(
                    stepNumber: 6,
                    instruction: "Scroll down and select Tamil."
                )
                
                InstructionStepView(
                    stepNumber: 7,
                    instruction: "If you see a list of keyboards within Tamil, select the appropriate one (e.g., Tamil99 or Anjal). If not, the Tamil keyboard will be enabled directly."
                )
                
                Text("You're all set! You can now use the Tamil keyboard in any app that allows text input.")
                    .font(.headline)
                    .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Tamil Keyboard")
    }
}

struct InstructionStepView: View {
    let stepNumber: Int
    let instruction: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Step \(stepNumber)")
                .font(.title3) // Smaller step title
                .fontWeight(.bold)
            
            Text(instruction)
                .font(.body)
                .padding(.bottom, 10)
            
            Divider()
        }
    }
}

struct TamilKeyboardInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        TamilKeyboardInstructionView()
    }
}
