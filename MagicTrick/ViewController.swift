//
//  ViewController.swift
//  MagicTrick
//
//  Created by Roman Roibu on 06.03.18.
//  Copyright © 2018 Roman Roibu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!


    private var magicHat: SCNNode?

    private var floor: SCNNode?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene()

        // Set the scene to the view
        sceneView.scene = scene

        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.automaticallyUpdatesLighting = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Enable horizontal plane detection
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }

        guard self.magicHat == nil, self.floor == nil else {
            return
        }

        self.floor = {
            let floor = SCNNode.floor(anchor)
            node.addChildNode(floor)
            return floor
        }()

        self.magicHat = {
            let hat = SCNNode.magicHat()
            hat.position = SCNVector3(x: anchor.center.x, y: hat.size.y / 2, z: anchor.center.z)
            hat.isHidden = false
            node.addChildNode(hat)
            return hat
        }()
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard let anchor = anchor as? ARPlaneAnchor,
            let floor = node.childNodes.first(where: { $0.name == "Floor" })
            else { return }

        floor.updateFloor(anchor)
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user

    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay

    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required

    }
}
