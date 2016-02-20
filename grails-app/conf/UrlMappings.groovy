class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: "front",action: "index")
		"500"(view:'/error')
        "/down.myapp.com/android"(controller:"front",action:"download")
	}
}
