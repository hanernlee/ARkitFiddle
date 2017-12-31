//
//  ViewController.swift
//  FloorIsLava
//
//  Created by Christopher Lee on 31/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.delegate = self
        lavaNode = createLava()
        sceneView.scene.rootNode.addChildNode(lavaNode)
    }
    
    func createLava() -> SCNNode {
        let lavaNode = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        lavaNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Lava")
        lava.position(0,0,-1)
        return lavaNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        <#code#>
    }
}

