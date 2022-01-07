//
//  ToDoView.swift
//  ToDoAppCoreData
//
//  Created by Ahmed on 31/12/21.
//

import SwiftUI

/// This is the home or main view of our app
struct ToDoHome: View {
    
    // MARK: Properties
    @StateObject private var todoViewModel: ToDoViewModel = ToDoViewModel.instance
    @State private var showBlur: Bool = false
    @State private var selectedIndex: Int = 0
    
    private let canvasColor: Color = Color(hex: 0xFFFEF9)
    private let pageTransition: AnyTransition = .asymmetric(
        insertion: .scale(scale: 0.8),
        removal: .opacity)
    
    // MARK: Body
    var body: some View {
        ZStack {
            canvasColor
                .ignoresSafeArea( edges: .all)
            VStack(spacing: 0.0) {
                if selectedIndex == 0 {
                    ToDoCalendar(canvasColor: canvasColor)
                        .transition(pageTransition)
                } else {
                    DoneToDosView()
                        .transition(pageTransition)
                }
                BottomNavigationBar($selectedIndex)
            }
            .foregroundColor(Color(hex: 0x6D6D6D))
            .blur(radius: showBlur ? 3 : 0)
            
            if showBlur {
                Color(.white).opacity(0.0)
            }
            DraggableSheet(showBlur: $showBlur)
        }
        .environmentObject(todoViewModel)
        
    }
}

// MARK: Previews
struct ToDoHome_Previews: PreviewProvider {
    static var previews: some View {
        ToDoHome()
    }
}





