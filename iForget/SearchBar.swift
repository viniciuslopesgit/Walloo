//
//  SearchBar.swift
//  iForget
//
//  Created by Vinícius Lopes on 23/07/2020.
//  Copyright © 2020 Vinícius Lopes. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange
            searchText: String) {
            text = searchText
            searchBar.backgroundColor = .clear
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
    }
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) ->
        UISearchBar {
            let searchBar = UISearchBar(frame: .zero)
            searchBar.delegate = context.coordinator
            searchBar.placeholder = "Search in iForget"
            searchBar.barTintColor = UIColor.blue
            searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            searchBar.backgroundColor = UIColor.clear
            searchBar.becomeFirstResponder()
            return searchBar
            
    }
    func updateUIView(_ uiView: UISearchBar, context:
        UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
