//
//  Utils.swift
//  Better Password
//
//  Created by Dominic Kolbe on 14/01/2022.
//

import SwiftUI

struct Utils {
  
  struct Clipboard {
    static func set(value: String) {
      UIPasteboard.general.string = value;
    }
  }
  
}

