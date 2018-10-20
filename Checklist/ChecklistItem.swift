//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Dominik Wieners on 20.10.18.
//  Copyright © 2018 Dominik Wieners. All rights reserved.
//

import Foundation

class Checklistitem{
    var text = ""
    var checked = false
    
    func toggleChecked(){
        self.checked = !checked
    }
}
