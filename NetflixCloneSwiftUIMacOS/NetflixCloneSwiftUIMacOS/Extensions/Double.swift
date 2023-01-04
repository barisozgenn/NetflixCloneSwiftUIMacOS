//
//  Double.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 4.01.2023.
//

import Foundation

extension Double {
  func toHhMmSs(style: DateComponentsFormatter.UnitsStyle) -> String {
    let dcf = DateComponentsFormatter()
    dcf.allowedUnits = [.hour, .minute, .second, .nanosecond]
    dcf.unitsStyle = style
    return dcf.string(from: self) ?? "0hr 0min 0sec"
  }
}
