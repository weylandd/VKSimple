//
//  VKSimpleMethodsExecuteCode.h
//  VkSimpleSdk
//

// ------------
// getAllPhotos
// ------------

/*
 var id = Args.user_id;
 if (!id)
 {
    id = API.users.get({})@.uid;
 }
 var offset = Args.offset;
 if (!offset)
 {
    offset = 0;
 }
 var count = Args.count;
 if (!count)
 {
    count = 0;
 }
 var photoSizes = Args.photo_sizes;
 if (!photoSizes)
 {
    photoSizes = 0;
 }
 var extended = Args.extended;
 if (!extended)
 {
    extended = 0;
 }
 
 var countParam = 200;
 if (count < countParam)
 {
    countParam = count;
 }
 var repeats = 24;
 
 var photos = API.photos.getAll({"owner_id": id, "extended": extended,"offset": offset, "count": countParam, "photo_sizes": photoSizes});
 repeats = repeats - 1;
 count = count - countParam;
 offset = offset + countParam;
 
 while (repeats > 0 && count > 0)
 {
    if (count < countParam)
    {
        countParam = count;
    }
    photos = photos + API.photos.getAll({"owner_id": id, "extended": extended,"offset": offset, "count": countParam, "photo_sizes": photoSizes});
    offset = offset + countParam;
    repeats = repeats - 1;
    count = count - countParam;
 };
 return photos;
*/