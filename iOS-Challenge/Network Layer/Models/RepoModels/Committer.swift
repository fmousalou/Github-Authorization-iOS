/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Committer : Mappable {
	var login : String?
	var id : Int?
	var node_id : String?
	var avatar_url : String?
	var gravatar_id : String?
	var url : String?
	var html_url : String?
	var followers_url : String?
	var following_url : String?
	var gists_url : String?
	var starred_url : String?
	var subscriptions_url : String?
	var organizations_url : String?
	var repos_url : String?
	var events_url : String?
	var received_events_url : String?
	var type : String?
	var site_admin : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		login <- map["login"]
		id <- map["id"]
		node_id <- map["node_id"]
		avatar_url <- map["avatar_url"]
		gravatar_id <- map["gravatar_id"]
		url <- map["url"]
		html_url <- map["html_url"]
		followers_url <- map["followers_url"]
		following_url <- map["following_url"]
		gists_url <- map["gists_url"]
		starred_url <- map["starred_url"]
		subscriptions_url <- map["subscriptions_url"]
		organizations_url <- map["organizations_url"]
		repos_url <- map["repos_url"]
		events_url <- map["events_url"]
		received_events_url <- map["received_events_url"]
		type <- map["type"]
		site_admin <- map["site_admin"]
	}

}