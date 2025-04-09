//
//  JSONDecoderExtension.swift
//  the-movie-db
//
//  Created by Zan on 4/9/25.
//  Copyright © 2025 Zan. All rights reserved.
//

import Foundation

extension JSONDecoder {
    
    func setCustomDateDecodingStrategy() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.dateDecodingStrategy = .formatted(formatter)
    }
}
