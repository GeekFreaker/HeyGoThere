class TagsController < ApplicationController

  DATABASE = "http://localhost:5984"


  ##
  # Return data in mixare format to display on app 
  ##
  def index


#application/mixare-json 

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
   response[:results] = []

   request["rows"].each do |row|

    title = row["value"]["kind"] == "recommendation" ? "Go There - " : "Don't Go There - "
    title = "#{title}#{row['value']['description']}"

    response[:results] << {
      id: row["id"],
      lat: row["value"]["lat"].to_s,
      lng: row["value"]["lon"].to_s,
      elevation: "0.0",
      title: title,
      distance: "0",
      has_detail_page: "0",
      webpage: ""
    }
   end


            #    "id": "2821",
            # "lat": "46.49396",
            # "lng": "11.2088",
            # "elevation": "1865",
            # "title": "Gantkofel",
            # "distance": "9.771",
            # "has_detail_page": "0",
            # "webpage": ""

   response[:status] = "OK"
   response[:num_results] = response[:results].length

    #    "status": "OK",
    # "num_results": 3,

   render json: response, :content_type => 'application/mixare-json'
  end





end
