//
//  BouncyButton.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 01/01/22.
//

import SwiftUI



/// Custom button with scale animation when tapped
struct BouncyButton: View {
    // MARK: Properties
    let title: String
    let color: Color
    let action: () -> Void

    // MARK: Body
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
        }
        .buttonStyle(BouncyStyle(color: color))
 
    }
}

// MARK: Previews
struct BouncyButton_Previews: PreviewProvider {
    static var previews: some View {
        BouncyButton(title: "Button", color: Color.accentColor) {}
    }
}


/// Button style
private struct BouncyStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .background(color)
            .cornerRadius(16)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
