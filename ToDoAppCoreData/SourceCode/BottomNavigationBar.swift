//
//  BottomNavigationBar.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 02/01/22.
//

import SwiftUI

/// Very basic bottom navigation bar helps to switch between views
struct BottomNavigationBar: View {
    
    // MARK: Properties
    @Binding private var selectedIndex: Int
    
    // MARK: init
    init(_ selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            Color(hex: 0xFFFAC9)
                .ignoresSafeArea( edges: .bottom)
            HStack {
                buildButton("calendar", 0)
                Spacer()
                buildButton("checklist", 1)
            }
            .font(.system(size: 24))
            .padding(.horizontal, 10)
        }
        .frame(height: 60)
    }
    
    // MARK: Functions
    /// Each button of the navigation bar
    @ViewBuilder
    func buildButton (_ name: String, _ index: Int) -> some View {
        Image(systemName: name)
            .frame(width: 100, height: 60)
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.4)) {
                    selectedIndex = index
                }
            }
    }
}

// MARK: Previews
struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBar(.constant(0))
    }
}
