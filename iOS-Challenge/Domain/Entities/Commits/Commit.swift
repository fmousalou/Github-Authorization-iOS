//
//  Commit.swift
//  iOS-Challenge
//
//  Created by Amir Abbas Kashani on 2/4/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Commit {
	let sha : String?
	let node_id : String?
	let commit : Info?
	let url : String?
	let html_url : String?
	let comments_url : String?
	let author : Author?
	let committer : Committer?
	let parents : [Parents]?
}
