//
//  Application.swift
//  WeatherApp
//
//  Created by Vladislav Sosiuk on 2/4/19.
//  Copyright © 2019 Vladislav Sosiuk. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class Application: UIApplication {
    private let assemblies = [MainAssembly()]
    private var assembler: Assembler!
    
    var strongDelegate: UIApplicationDelegate?
    
    override init() {
        super.init()
        
        assembler = createAssembler(container: SwinjectStoryboard.defaultContainer)
        
        strongDelegate = AppDelegate()
        delegate = strongDelegate
    }
    
    private func createAssembler(container: Container) -> Assembler {
        return Assembler(assemblies, container: container)
    }
}
