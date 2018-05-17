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

    lazy var throwButton = RoundedButton(title: "Throw", target: self, action: #selector(self.throwAction(_:)))

    lazy var buttonStack: UIStackView! = {
        let stack = UIStackView(arrangedSubviews: [
            self.throwButton,
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var buttonStackConstraints: [NSLayoutConstraint] = {
        let views: [String: Any] = [ "stack": self.buttonStack ]
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stack]-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[stack]-40-|", options: .alignAllBottom, metrics: nil, views: views)
        return constraints
    }()

    @IBAction func throwAction(_ sender: UIButton) {

        guard let frame = self.sceneView.session.currentFrame else {
            return
        }

        let camera = SCNMatrix4(frame.camera.transform)
        let direction = SCNVector3(camera.m31, camera.m32, camera.m33) * -1
        let position  = SCNVector3(camera.m41, camera.m42, camera.m43)

        let ball = SCNNode.ball()
        self.add(ball: ball)

        ball.position = position
        ball.physicsBody?.applyForce(direction * 4.0, asImpulse: true)
    }

    private var magicHat: SCNNode?

    private var floor: SCNNode?

    private lazy var balls: SCNNode = {
        let node = SCNNode()
        self.sceneView.scene.rootNode.addChildNode(node)
        return node
    }()

    private var isMagicHatPlaced: Bool {
        return self.magicHat != nil
            && self.floor != nil
    }

    private func add(ball: SCNNode) {
        self.sceneView.scene.rootNode.addChildNode(ball)
        self.balls.addChildNode(ball)
    }

    private func updateUserInterface() {
        DispatchQueue.main.async {
            self.throwButton.isEnabled = self.isMagicHatPlaced
        }
    }

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

        self.view.addSubview(self.buttonStack)
        NSLayoutConstraint.activate(self.buttonStackConstraints)

        self.updateUserInterface()
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
            let floor = SCNNode.floor(on: anchor)
            node.addChildNode(floor)
            return floor
        }()

        self.magicHat = {
            let hat = SCNNode.magicHat(on: anchor)
            node.addChildNode(hat)
            return hat
        }()

        self.updateUserInterface()
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard let anchor = anchor as? ARPlaneAnchor else {
            return
        }

        guard let floor = node.childNodes.first(where: { $0.name == "Floor" }) else {
            return
        }

        floor.updateFloor(on: anchor)
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
