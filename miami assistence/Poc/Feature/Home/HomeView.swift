//
//  HomeView.swift
//  miami assistence
//
//  Created by Rodrigo Souza on 29/06/23.
//

import SwiftUI

struct HomeView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        ResponsiveView { prop in
            TabBar(tabSelection: $tabSelection, size: prop.size) {
                switch tabSelection {
                case 1:
                    ProfileView(safeArea: prop.safeArea, size: prop.size)
                case 2:
                    TaskView()
                case 3:
                    Text("Ttt")
                        .foregroundStyle(.miamiDarkGraySecond)
                default:
                    Text("Not defined")
                        .foregroundStyle(.miamiDarkGraySecond)
                }
            }
        }
        .ignoresSafeArea(.container, edges: [.top, .bottom])
    }
}
