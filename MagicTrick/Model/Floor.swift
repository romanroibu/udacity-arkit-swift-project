//
//  Floor.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import SceneKit
import ARKit

extension SCNNode {

    static func floor(_ anchor: ARPlaneAnchor) -> SCNNode {

        let material = SCNMaterial()
        material.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)

        let geometry = SCNPlane()
        geometry.materials = [material]

        let physics = SCNPhysicsBody()
        physics.type = .kinematic
        physics.friction = 0.8

        let floor = SCNNode()
        floor.name = "Floor"
        floor.geometry = geometry
        floor.physicsBody = physics
        floor.transform = SCNMatrix4MakeRotation(-.pi / 2, 1, 0, 0)
        floor.updateFloor(anchor)

        return floor
    }

    func updateFloor(_ anchor: ARPlaneAnchor) {
        self.position = SCNVector3(x: anchor.center.x, y: 0.01, z: anchor.center.z)

        if let geometry = self.geometry as? SCNPlane {
            geometry.width = CGFloat(anchor.extent.x)
            geometry.height = CGFloat(anchor.extent.z)
        }
    }
}
