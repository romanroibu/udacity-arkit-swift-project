//
//  SceneKit+Extensions.swift
//  MagicTrick
//
//  Created by Roman Roibu on 14.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import SceneKit

extension SCNVector3 {

    fileprivate func apply(_ op: (Float, Float) -> Float, _ scalar: Float) -> SCNVector3 {

        let other = SCNVector3(x: scalar, y: scalar, z: scalar)

        return self.apply(op, other)
    }

    fileprivate func apply(_ op: (Float, Float) -> Float, _ other: SCNVector3) -> SCNVector3 {

        return SCNVector3(x: op(self.x, other.x),
                          y: op(self.y, other.y),
                          z: op(self.z, other.z))
    }
}

func +(lhs: SCNVector3, rhs: Float) -> SCNVector3 { return lhs.apply(+, rhs) }
func -(lhs: SCNVector3, rhs: Float) -> SCNVector3 { return lhs.apply(-, rhs) }
func *(lhs: SCNVector3, rhs: Float) -> SCNVector3 { return lhs.apply(*, rhs) }
func /(lhs: SCNVector3, rhs: Float) -> SCNVector3 { return lhs.apply(/, rhs) }

func +(lhs: Float, rhs: SCNVector3) -> SCNVector3 { return rhs.apply(+, lhs) }
func -(lhs: Float, rhs: SCNVector3) -> SCNVector3 { return rhs.apply(-, lhs) }
func *(lhs: Float, rhs: SCNVector3) -> SCNVector3 { return rhs.apply(*, lhs) }
func /(lhs: Float, rhs: SCNVector3) -> SCNVector3 { return rhs.apply(/, lhs) }

func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 { return lhs.apply(+, rhs) }
func -(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 { return lhs.apply(-, rhs) }
func *(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 { return lhs.apply(*, rhs) }
func /(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 { return lhs.apply(/, rhs) }
