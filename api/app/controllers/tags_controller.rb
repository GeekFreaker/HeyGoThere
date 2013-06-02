class TagsController < ApplicationController

  DATABASE = "http://localhost:5984"


  ##
  # Return data in mixare format to display on app 
  ##
  def index


  	slat = params[:slat]
  	slon = params[:slon]
  	elat = params[:elat]
  	elon = params[:elon]

  	# /hgt/_design/hgt/_view/tags?startkey=[-27,27]\&endkey=[-25,28]
    #uri = "#{DATABASE}/hgt/_design/hgt/_view/tags?startkey=[#{slat},#{slon}]&endkey=[#{elat},#{elon}]"
    uri = "#{DATABASE}/hgt/_design/hgt/_view/tags"

   request = RestClient.get uri

   request = Yajl::Parser.parse(request)

   puts request.inspect

   response = {}
   response[:result] = []

   request["rows"].each do |row|

    title = row["value"]["kind"] == "recommendation" ? "Go There - " : "Don't Go There - "
    title = "#{title}#{row['value']['description']}"

    response[:result] << {
      id: row["id"],
      lat: row["value"]["lat"].to_f,
      lng: row["value"]["lon"].to_f,
      elevation: 0.0,
      title: title

    }
   end

   # lat (latitude), lng (longitude), elevation (could be "0"), 

   render json: response

# {"id"=>"1", "key"=>[-26.05, 27.6], 
#   "value"=>{"_id"=>"1", "_rev"=>"1-9cec123b4bd6ab35e6eb560901935e2e", 
#     "kind"=>"recommendation", 
#     "lat"=>-26.05, 
#     "lon"=>27.6, 
#     "expires"=>"2013-06-02T12:34:56Z", 
#     "description"=>"Lot of milk here for the rest of the weekend", 
#     "username"=>"anonymous", 
#     "type"=>"tag", 
#     "timestamp"=>"2013-06-01T18:01:26.303Z"}
#   }


#         {
#             "id": "2821",
#             "lat": "46.49396",
#             "lng": "11.2088",
#             "elevation": "1865",
#             "title": "Gantkofel",
#             "distance": "9.771",
#             "has_detail_page": "0",
#             "webpage": ""
#         },


#http://localhost:5984/hgt/_design/hgt/_view/tags?startkey=[-27,27]&endkey=[-25,28]



  end



# {
#     "status": "OK",
#     "num_results": 3,
#     "results": [
#         {
#             "id": "2827",
#             "lat": "46.43893",
#             "lng": "11.21706",
#             "elevation": "1737",
#             "title": "Penegal",
#             "distance": "9.756",
#             "has_detail_page": "1",
#             "webpage": "http%3A%2F%2Fwww.suedtirolerland.it%2Fapi%2Fmap%2FgetMarkerTplM%2F%3Fmarker_id%3D2827%26project_id%3D15%26lang_id%3D9"
#         },
#         {
#             "id": "2821",
#             "lat": "46.49396",
#             "lng": "11.2088",
#             "elevation": "1865",
#             "title": "Gantkofel",
#             "distance": "9.771",
#             "has_detail_page": "0",
#             "webpage": ""
#         },
#         {
#             "id": "2829",
#             "lat": "46.3591",
#             "lng": "11.1921",
#             "elevation": "2116",
#             "title": "Roen",
#             "distance": "17.545",
#             "has_detail_page": "1",
#             "webpage": "http%3A%2F%2Fwww.suedtirolerland.it%2Fapi%2Fmap%2FgetMarkerTplM%2F%3Fmarker_id%3D2829%26project_id%3D15%26lang_id%3D9"
#         }
#     ]
# }
# There must be an array whos name is "results" at the first level of the JSON object.

# Each element of the array must contain at least lat (latitude), lng (longitude), elevation (could be "0"), 
# title (the string that will be shown below the Marker).

# Each element of the array could contain webpage (a link to the what is shown when the user clicks on the marker) 
# and if it does it must contain has_detail_page with a value of 1). NB: A value of 0 for has_detail_page means that 
# mixare will not consider clicks on that marker.

# Each element of the array could contain distance.

# It is strongly recommended to add a unique ID to each marker. This ID (among with the title) is used to distinguish 
# among different markers. (in mixare version < 0.8.2 there was a bug where markers with the same title were collapsed into 
# one even if the ID was specified)






end
