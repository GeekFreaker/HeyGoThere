function(doc, req) {
   if (req.method !== 'POST') {
	  return [null, 'only POST allowed'];
   }
   if(!doc) {
        doc = {} 
        if(req.id){
              doc._id = req.id
        } else {
              doc._id = req.uuid
        }
    }


   if (req.query.nostamp != 'yes') {
      doc.timestamp = new Date();
   }

   
   // parsed = JSON.parse(req.body)
   // if(parsed.token){
   //   doc.token = parsed.token
   // }

   parsed = JSON.parse(req.body)
   for(var attr in parsed){
     doc[attr] = parsed[attr]
   }


   doc.type = "user"
   doc.id = doc._id

   return [doc, JSON.stringify(doc)];
}


