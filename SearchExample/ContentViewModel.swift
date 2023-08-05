//
//  ContentViewModel.swift
//  SearchExample
//
//  Created by MAHESHWARAN on 05/08/23.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject, Identifiable {
  
  var records: [String] = [] {
    didSet {
      filteredRecords = records
    }
  }
  @Published var searchText = ""
  @Published var filteredRecords: [String] = []
  @Published var selectedItem: String?
  
  var cancelBag = Set<AnyCancellable>()
  
  init() {
    setupRecords()
    setupSearch()
  }
  
  private func setupRecords() {
    records = (1...20).map { String("Example \($0)") }
  }
  
  private func setupSearch() {
    $searchText.map { $0.lowercased() }
      .sink { [weak self] searchText in
        guard let self else { return }
        
        if searchText.isEmpty {
          self.filteredRecords = self.records
        } else {
          let filteredRecords = self.records.filter {
            $0.lowercased().localizedCaseInsensitiveContains(searchText)
          }
          self.filteredRecords = filteredRecords
        }
      }
      .store(in: &cancelBag)
  }
}
