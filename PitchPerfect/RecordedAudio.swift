//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by melody5417 on 25/05/2017.
//  Copyright © 2017 melody5417. All rights reserved.
//

import UIKit

class RecordedAudio: NSObject {
    
    var filePathURL: URL!
    var title: String!
    
    init(title: String, filePath: URL) {
        self.title = title
        self.filePathURL = filePath
    }
}
