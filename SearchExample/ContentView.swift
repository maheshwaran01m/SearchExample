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
      listView
    }
  }
  
  private var listView: some View {
    List(viewModel.filteredRecords, id: \.self, selection: $viewModel.selectedItem) { item in
      selectionRows(for: item)
    }
    .listStyle(.plain)
    .navigationTitle("Search")
    .searchable(text: $viewModel.searchText)
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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      ContentView()
    }
  }
}

