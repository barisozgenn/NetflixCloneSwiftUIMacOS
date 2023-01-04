//
//  NSImage+Base64String.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 4.01.2023.
//

import SwiftUI

extension String {
    func convertBase64ToNSImage () -> NSImage {
        let imageData = Data(base64Encoded: self)
        let image = NSImage(data: imageData!)
        return image!
    }
}
