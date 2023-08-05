//
//  ContentView.swift
//  SearchExample
//
//  Created by MAHESHWARAN on 05/08/23.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    NavigationStack {
      mainView
        .navigationTitle("Search")
        .searchable(text: $viewModel.searchText)
    }
  }
  
  @ViewBuilder
  private var mainView: some View {
    if !viewModel.filteredRecords.isEmpty {
      listView
    } else {
      placeholderView
    }
  }
  
  private var listView: some View {
    List(viewModel.filteredRecords, id: \.self, selection: $viewModel.selectedItem) { item in
      selectionRows(for: item)
    }
    .listStyle(.plain)
  }
  
  private func selectionRows(for item: String) -> some View {
    Text(String(describing: item))
      .listRowSeparator(.hidden)
      .listRowBackground(Color.clear)
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .frame(maxWidth: .infinity, alignment: .leading)
      .listRowInsets(.init(top: 8, leading: 8, bottom: 0, trailing: 8))
      .background(viewModel.selectedItem == item ? Color.blue.opacity(0.3) : Color.secondary.opacity(0.1))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .onTapGesture {
        viewModel.selectedItem = item
      }
  }
  
  // MARK: - Placeholder View
  
  private var placeholderView: some View {
    ZStack {
      Color.secondary.opacity(0.1)
      VStack(spacing: 16) {
        iconView
        titleView
      }
    }
    .ignoresSafeArea(.container, edges: .bottom)
  }
  
  private var titleView: some View {
    Text("No Examples")
      .font(.title3)
      .frame(minHeight: 22)
      .multilineTextAlignment(.center)
      .foregroundStyle(.secondary)
  }
  
  private var iconView: some View {
    Image(systemName: "square.on.square.badge.person.crop")
      .font(.title3)
      .foregroundStyle(Color.secondary)
      .frame(minWidth: 20, minHeight: 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ContentView()
    }
  }
}

