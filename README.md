
Basic Image Upload to S3 with Sinatra
================

Live on Heroku at https://aqueous-tor-70733.herokuapp.com/images

### Requirements:

- ImageMagick see [here](https://github.com/thoughtbot/paperclip/blob/master/README.md#image-processor) for installation
- [Postgres](https://www.postgresql.org/download/macosx/)

To setup on local machine:

- `bundle install`
- `rake db:schema:load`
- `rake db:seed` if you want to seed the database.
- `rackup config.ru` will run the server locally

-------------------------------------------------------------------------

## API Documentation

This API only consumes JSON, all requests should be encoded as such.

### POST /images

```JSON
POST /shorten
Content-Type: "application/json"

{
  "image": {
    "title": "An edgy title",
    "author": "Man Ray",
    "image": "data:image/jpg;base64,al13alkjfahbcsal...",
    "all_tags": "candid, urban"
  }
}
```

Attribute | Description
--------- | -----------
title     | title of image
author    | author of image, optional
image     | base64 encoded image, only accepts jpg or png, optional
all_tags  | comma seperated string of tags, optional

##### Returns:

```JSON
201 Created
Content-Type: "application/json"

{
  "id": 1,
  "title": "An edgy title",
  "author": "Man Ray",
  "thumbnail": "https://s3.eu-west-2...",
  "square": "https://s3.eu-west-2...",
  "greyscale": "https://s3.eu-west-2...",
  "tags":[
    {
      "id" :1,
      "name": "candid"
    },
    { "id": 2,
      "name": "urban"
    }
  ]
}
```

##### Errors:

Error | Description
----- | ------------
422   | Title is not present or image is not a jpg or png.

### POST /images

```JSON
PUT /images/:id
Content-Type: "application/json"

{
  "image": {
    "title": "A new title"
  }
}
```

Attribute | Description
--------- | -----------
title     | title of image
author    | author of image, optional
image     | base64 encoded image, only accepts jpg or png, optional
all_tags  | comma seperated string of tags, optional

##### Returns:

```JSON
200 Success
Content-Type: "application/json"

{
  "id": 1,
  "title": "A new title",
  "author": "Lincoln",
  "thumbnail": "https://s3.eu-west-2...",
  "square": "https://s3.eu-west-2...",
  "greyscale": "https://s3.eu-west-2...",
  "tags":[]
}
```

##### Errors:

Error | Description
----- | ------------
422   | Title is not present or image is not a jpg or png.


### GET /image/:id

```
GET /image/:id
Content-Type: "application/json"

```

Attribute      | Description
-------------- | -----------
id             | id of the image

##### Returns:

```JSON
200 Success
Content-Type: "application/json"

{
  "id": 1,
  "title": "Ruben",
  "author": "Lincoln",
  "thumbnail": "https://s3.eu-west-2...",
  "square": "https://s3.eu-west-2...",
  "greyscale": "https://s3.eu-west-2...",
  "tags":[
    {
      "id" :1,
      "name": "candid"
    },
    { "id": 2,
      "name": "urban"
    }
  ]
}
```

##### Errors

Error | Description
----- | ------------
404   | That image can't be found

### DELETE /image/:id

```
DELETE /image/:id
Content-Type: "application/json"
```

Attribute      | Description
-------------- | -----------
id             | id of the image

##### Returns:

```JSON
204 No Content

```

### GET /search/:tag

```
GET /image/:tag
Content-Type: "application/json"

```

Attribute      | Description
-------------- | -----------
tag            | name of the tag to search by

##### Returns:

```JSON
200 Success
Content-Type: "application/json"

[
  {
  "id": 6,
  "title": "Shannon",
  "author": "Bernice",
  "thumbnail": "https://s3.eu-west-2...",
  "square": "https://s3.eu-west-2...",
  "greyscale": "https://s3.eu-west-2...",
  "tags":[
    {
      "id" :1,
      "name": "candid"
    },
    { "id": 2,
      "name": "urban"
    }
  ]
  },
  {
  "id": 7,
  "title": "Tom",
  "author": "Oceane",
  "thumbnail": "https://s3.eu-west-2...",
  "square": "https://s3.eu-west-2...",
  "greyscale": "https://s3.eu-west-2...",
  "tags":[
    {
      "id" :1,
      "name": "candid"
    }
  ]
  }
]

```

If no tag is supplied then all images are returned






