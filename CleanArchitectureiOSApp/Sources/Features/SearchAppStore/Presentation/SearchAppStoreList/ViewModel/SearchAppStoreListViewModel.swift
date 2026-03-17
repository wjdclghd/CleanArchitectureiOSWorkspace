//
//  SearchAppStoreListViewModel.swift
//  CleanArchitectureiOSApp
//
//  Created by jch on 3/17/26.
//

import Foundation
import SwiftUI

final class SearchAppStoreListViewModel: ObservableObject {
    let searchKeyword: String
    
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
}
