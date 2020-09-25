//
//  ObservableType.swift
//  Gojek
//
//  Created by Neeraj Solanki on 26/09/20.
//  Copyright © 2020 Mr.Solanki. All rights reserved.
//

import UIKit

enum ObserverTypeEnum {
      case dataLoading
      case dataLoaded
      case dataFailed
      case noNetwork
}

typealias ObserverBlock = ((_ observerType:ObserverTypeEnum)->Void)?
protocol ObservableProtocol {
    var observerBlock:ObserverBlock{ get }
}

class ObservableType: NSObject,ObservableProtocol {
    var observerBlock: ObserverBlock = nil
    
    override init() {
        super.init()
    }
}
