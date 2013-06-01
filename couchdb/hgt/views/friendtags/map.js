function(doc) {
  if(doc.type && doc.type == "tag"){
     if(doc.userid){
        emit(doc.userid,doc)
     }
  }
}
