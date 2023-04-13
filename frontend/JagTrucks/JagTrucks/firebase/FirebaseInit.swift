//
//  FirebaseInit.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

var app: Void = FirebaseApp.configure()

let db = Firestore.firestore()
