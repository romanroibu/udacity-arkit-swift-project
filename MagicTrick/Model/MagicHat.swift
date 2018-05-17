//
//  MagicHat.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import SceneKit
import class ARKit.ARPlaneAnchor

extension SCNNode {

    var cylinder: SCNNode {
        return self.childNode(withName: "cylinder", recursively: true)!
    }

    static func magicHat(on anchor: ARPlaneAnchor) -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/hat.scn")!
        let node = scene.rootNode.childNode(withName: "hat", recursively: true)!
        let height = node.boundingBox.max.y - node.boundingBox.min.y
        node.position = SCNVector3(anchor.center.x, height/2, anchor.center.z)
        return node
    }

    func magicHatContains(_ other: SCNNode) -> Bool {
        return self.cylinder.contains(node: other)
    }

    private func contains(node other: SCNNode) -> Bool {

        let position = other.presentation.worldPosition

        var size: SCNVector3 {
            let (min, max) = self.presentation.boundingBox
            return max - min
        }

        let min = self.worldPosition - size / 2
        let max = self.worldPosition + size / 2

        return (min.x...max.x).contains(position.x)
            && (min.y...max.y).contains(position.y)
            && (min.z...max.z).contains(position.z)
    }
}
