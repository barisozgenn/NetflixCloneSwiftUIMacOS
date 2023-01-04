//
//  NSImage+Base64String.swift
//  NetflixCloneSwiftUIMacOS
//
//  Created by Baris OZGEN on 4.01.2023.
//

import SwiftUI

extension String {
    func convertBase64ToNSImage () -> NSImage {
        guard let imageData = Data(base64Encoded: self) else {return NSImage(imageLiteralResourceName: "netflix-clone-swifui-barisozgen–app") }
        let image = NSImage(data: imageData) ?? NSImage(imageLiteralResourceName: "netflix-clone-swifui-barisozgen–app")
            return image
        
        
    }
}
