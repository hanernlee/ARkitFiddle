//
//  ViewController.swift
//  Planets
//
//  Created by Christopher Lee on 26/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sun = SCNNode()
        sun.geometry = SCNSphere(radius: 0.35)
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
        sun.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(sun)
        
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(earthParent)
        
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(venusParent)
        
        let moonParent = SCNNode()
        moonParent.position = SCNVector3(1.2, 0, 0)

        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2, 0 ,0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        let sunAction = rotation(time: 8)
        let earthParentRotation = rotation(time: 14)
        let venusParentRotation = rotation(time: 10)
        let earthRotation = rotation(time: 8)
        let moonRotation = rotation(time: 1)
        
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
        venusParent.addChildNode(venus)
        
        sun.runAction(sunAction)
        earthParent.runAction(earthParentRotation)
        earth.runAction(earthRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
    }

    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        return foreverRotation
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

