//
//  MainTableViewModel.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class MainTableViewModel: NSObject {

    var dataSource:[String] = ["多线程技术","自动归档解归档","混合编程"]
    static let shared = MainTableViewModel()

}
