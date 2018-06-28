//
//  Comment.swift
//  Instagram
//
//  Created by 小島 彬 on 2018/06/24.
//  Copyright © 2018年 小島 彬. All rights reserved.
//

import UIKit

class CommentData: Codable {
    var name: String?
    var comment: String?
    var date: Date
    
    init() {
        self.name = nil
        self.comment = nil
        self.date = Date()
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
