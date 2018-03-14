//
//  Ball.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import SceneKit

extension SCNNode {

    static func ball() -> SCNNode {

        let material: SCNMaterial = {
            let material = SCNMaterial()
            material.diffuse.contents = UIColor(white: 1.0, alpha: 1.0)
            material.specular.contents = UIColor(white: 1.0, alpha: 1.0)
            return material
        }()

        let geometry: SCNGeometry = {
            let geometry = SCNSphere(radius: 0.03)
            geometry.materials = [material]
            return geometry
        }()

        let physics: SCNPhysicsBody = {
            let physics = SCNPhysicsBody(type: .dynamic, shape: nil)
            physics.mass = 1.0
            physics.friction = 0.5
            physics.rollingFriction = 0.6
            physics.damping = 0.3
            physics.angularDamping = 0.5
            return physics
        }()

        let ball = SCNNode()
        ball.geometry = geometry
        ball.physicsBody = physics
        return ball
    }
}
