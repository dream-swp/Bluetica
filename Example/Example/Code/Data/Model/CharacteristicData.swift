//
//  CharacteristicData.swift
//  Example
//
//  Created by Dream on 2025/10/16.
//

import Foundation


struct CharacteristicData {
    var data = Data()
}

extension CharacteristicData {
    var decimal: String { data.convert.decimal }

    var value: String { data.convert.value }

    var hexBig: String { data.convert.hex }
    
    var hexSmall: String { data.convert.hex { (false, " ")} }

    var binary: String { data.convert.binary }

    var ascii: String { data.convert.ascii }

    var base64: String { data.convert.base64 }
}
