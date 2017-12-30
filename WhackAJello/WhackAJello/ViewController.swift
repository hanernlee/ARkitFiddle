//
//  ViewController.swift
//  WhackAJello
//
//  Created by Christopher Lee on 27/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func play(_ sender: UIButton) {
        addNode()
    }
    
    @IBAction func reset(_ sender: UIButton) {
    }
    
    func addNode() {
        let jellyfishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyfishNode = jellyfishScene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        jellyfishNode?.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(jellyfishNode!)
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        
        if hitTest.isEmpty {
            print("Didn't touch any objects")
        } else {
            let results = hitTest.first!
            let node = results.node
            
            if node.animationKeys.isEmpty {            
                animateNode(node: node)
            }
        }
    }
    
    func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2, node.presentation.position.y - 0.2, node.presentation.position.z - 1)
        spin.duration = 0.07
        spin.autoreverses = true
        spin.repeatCount = 5
        node.addAnimation(spin, forKey: "position")
    }
}

