//
//  HapticFeedback.swift
//  Tamil Lit
//
//  Created by Selvarajan on 09/08/24.
//

import UIKit

func performSoftHapticFeedback() {
    let impactFeedback = UIImpactFeedbackGenerator(style: .soft)
    impactFeedback.impactOccurred()
}

func performRigidHapticFeedback() {
    let impactFeedback = UIImpactFeedbackGenerator(style: .rigid)
    impactFeedback.impactOccurred()
}

func performMediumHapticFeedback() {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    impactFeedback.impactOccurred()
}

func performHeavyHapticFeedback() {
    let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
    impactFeedback.impactOccurred()
}
