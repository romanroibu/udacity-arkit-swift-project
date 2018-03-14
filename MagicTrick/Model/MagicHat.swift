//
//  MagicHat.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import SceneKit

extension SCNNode {

    var cylinder: SCNNode {
        return self.childNode(withName: "cylinder", recursively: true)!
    }

    static func magicHat() -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/hat.scn")!
        let node = scene.rootNode.childNode(withName: "hat", recursively: true)!
        return node
    }
}
