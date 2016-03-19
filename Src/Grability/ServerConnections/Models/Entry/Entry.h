//
//  Entry.h
//  Grability
//
//  Created by Ahmad Abdul-Gawad Mahmoud on 3/19/16.
//  Copyright © 2016 Ahmad Abdul-Gawad Mahmoud. All rights reserved.
//

#import "BaseModel.h"
@class Feed;
#import "Link.h"

@protocol ImgAttributes @end
@interface ImgAttributes : BaseModel
@property NSString <Optional> *height;
@end

@protocol ImImage @end
@interface ImImage : BaseModel
@property BaseModel <Optional, ImgAttributes> *attributes;
@end

@protocol PriceAttributes @end
@interface PriceAttributes : BaseModel
@property NSString <Optional> *amount;
@property NSString <Optional> *currency;
@end

@protocol ImPrice @end
@interface ImPrice : BaseModel
@property BaseModel <Optional, PriceAttributes> *attributes;
@end

@protocol ImContentTypeAttributes @end
@interface ImContentTypeAttributes : BaseModel
@property NSString <Optional> *term;
@end

@protocol ImContentType @end
@interface ImContentType : BaseModel
@property BaseModel <Optional, ImContentTypeAttributes> *attributes;
@end

@protocol EntryAttributes @end
@interface EntryAttributes : BaseModel
@property NSString <Optional> *imid; //$ im:id
@property NSString <Optional> *imbundleId; //$ im:bundleId
@end

@protocol EntryId @end
@interface EntryId : BaseModel
@property EntryAttributes <Optional> *attributes;
@end

@protocol ImArtistAttributes @end
@interface ImArtistAttributes : BaseModel
@property NSString <Optional> *href;
@end

@protocol ImArtist @end
@interface ImArtist : BaseModel
@property ImArtistAttributes <Optional> *attributes;
@end

@protocol CategoryAttributes @end
@interface CategoryAttributes : BaseModel
@property NSString <Optional> *imid; //$ im:id
@property NSString <Optional> *term;
@property NSString <Optional> *scheme;

@end

@protocol Categoryy @end
@interface Categoryy : BaseModel
@property CategoryAttributes <Optional> *attributes;
@end

@protocol ImReleaseDate @end
@interface ImReleaseDate : BaseModel
@property BaseModel <Optional> *attributes;
@end

@protocol Entry @end
@interface Entry : BaseModel
@property BaseModel <Optional> *imname; //$ im:name
@property NSArray <Optional, ImImage> *imimage; //$ im:image
@property BaseModel <Optional> *summary;
@property ImPrice <Optional> *imprice; //$ im:price
@property ImContentType <Optional> *imcontentType; //$ im:contentType
@property BaseModel <Optional> *rights;
@property BaseModel <Optional> *title;
@property Link <Optional> *link;
@property EntryId <Optional> *id;
@property ImArtist <Optional> *imartist; //$ im:artist
@property Categoryy <Optional> *category;
@property ImReleaseDate <Optional> *imreleaseDate; //$ im:releaseDate
@end
