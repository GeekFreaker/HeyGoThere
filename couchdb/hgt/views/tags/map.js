function(doc) {
  if(doc.type && doc.type == "tag"){
     emit([doc.lat,doc.lon],doc)
  }
  
}
