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

   doc.timestamp = new Date();
   parsed = JSON.parse(req.body)
   if(parsed.token){
     doc.token = parsed.token
   }
   doc.type = "user"
   doc.id = doc._id

   return [doc, JSON.stringify(doc)];
}
