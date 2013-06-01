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

   parsed = JSON.parse(req.body)
   for(var attr in parsed){
     doc[attr] = parsed[attr]
   }
   doc.type = "tag"
   doc.timestamp = new Date();

   return [doc, JSON.stringify(doc)];
}
