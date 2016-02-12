# Story Points

### Get SPs for Capture

#### Request

###### HTTP Request

```javascript
GET /api/v1/capture
```

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": [
    {
      "id": integer,
      "userId": integer,
      "storyId": integer,
      "caption": string,
      "public": boolean,
      "kind": string,
      "text": text,
      "address": string,
      "latitude": string,
      "longitude": string,
      "file": string,
      "thumbnail": string,
      "createdAt": datetime,
      "updatedAt": datetime,
      "tags": array,
      "story": {
        "id": integer,
        "userId": integer,
        "name": string,
        "description": text,
        "public": boolean,
        "createdAt": datetime,
        "updatedAt": datetime
      },
      "user": {
      }
    }
  ]
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `caption`   | `string`   | SP's caption, max. 140 chrs       |
| `address`   | `string`   |                                   |
| `latitude`  | `string`   |                                   |
| `longitude` | `string`   |                                   |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `story`     | `object`   |                                   |
| `user`      | `object`   |                                   |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

---

## User's SPs

#### Request

###### HTTP Request

```javascript
GET /api/v1/story_points
```

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": [
    {
      "id": integer,
      "userId": integer,
      "storyId": integer,
      "caption": string,
      "public": boolean,
      "kind": string,
      "text": text,
      "address": string,
      "latitude": string,
      "longitude": string,
      "file": string,
      "thumbnail": string,
      "createdAt": datetime,
      "updatedAt": datetime,
      "tags": array
    }
  ]
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `userId`    | `integer`  | User's id                         |
| `storyId`   | `integer`  | Story's id                        |
| `caption`   | `string`   | SP's caption, max. 140 chrs       |
| `public`    | `boolean`  | default: true                     |
| `kind`      | `string`   | 'text', 'audio', 'image', 'video' |
| `text`      | `text`     |                                   |
| `address`   | `string`   |                                   |
| `latitude`  | `string`   |                                   |
| `longitude` | `string`   |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

---

## Create a new Story Point

#### Request

###### HTTP Request

```javascript
POST /api/v1/story_points
```

###### Request Body

| Name        | Value     | Description                                        |
| ----------- | --------- | -------------------------------------------------- |
| `kind`      | `string`  | required, can be 'audio', 'image', 'video', 'text' |
| `text`      | `text`    | required if kind is 'text'                         |
| `file`      | `file`    | required unless kind is 'text'                     |
| `caption`   | `string`  | required, max. 140 ch.                             |
| `address`   | `string`  | required                                           |
| `latitude`  | `string`  | required                                           |
| `longitude` | `string`  | required                                           |
| `tags`      | `array`   | optional                                           |
| `storyId`   | `integer` | optional                                           |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "storyId": integer,
    "caption": string,
    "public": boolean,
    "kind": string,
    "text": text,
    "address": string,
    "latitude": string,
    "longitude": string,
    "file": string,
    "thumbnail": string,
    "createdAt": datetime,
    "updatedAt": datetime,
    "tags": array
  }
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `userId`    | `integer`  | User's id                         |
| `storyId`   | `integer`  | Story's id                        |
| `caption`   | `string`   | SP's caption, max. 140 chrs       |
| `public`    | `boolean`  | default: true                     |
| `kind`      | `string`   | 'text', 'audio', 'image', 'video' |
| `text`      | `text`     |                                   |
| `address`   | `string`   |                                   |
| `latitude`  | `string`   |                                   |
| `longitude` | `string`   |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "errors": array
  }
}
```

###### Response Parameters

| Name              | Value     | Description                           |
| ----------------- | --------- | ------------------------------------- |
| `error["errors"]` | `array`   | Array of serverside validation errors |

###### Available `errors` messages

| Name        | Description                                      |
| ----------- | ------------------------------------------------ |
| `caption`   | Caption can't be blank                           |
| `caption`   | Caption is too long (maximum is 140 characters)" |
| `kind`      | Kind can't be blank                              |
| `kind`      | Kind is not included in the list                 |
| `text`      | Text can't be blank                              |
| `file`      | File can't be blank                              |
| `address`   | Address can't be blank                           |
| `latitude`  | Latitude can't be blank                          |
| `longitude` | Longitude can't be blank                         |


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}

```

---

## Update a Story Point

#### Request

###### HTTP Request

```javascript
PUT /api/v1/story_points/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | SP's id     |

###### Request Body

| Name        | Value     | Description                                        |
| ----------- | --------- | -------------------------------------------------- |
| `caption`   | `string`  | required, max. 140 ch.                             |
| `address`   | `string`  | required                                           |
| `latitude`  | `string`  | required                                           |
| `longitude` | `string`  | required                                           |
| `tags`      | `array`   | optional                                           |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "storyId": integer,
    "caption": string,
    "public": boolean,
    "kind": string,
    "text": text,
    "address": string,
    "latitude": string,
    "longitude": string,
    "file": string,
    "thumbnail": string,
    "createdAt": datetime,
    "updatedAt": datetime,
    "tags": array
  }
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `userId`    | `integer`  | User's id                         |
| `storyId`   | `integer`  | Story's id                        |
| `caption`   | `string`   | SP's caption, max. 140 chrs       |
| `public`    | `boolean`  | default: true                     |
| `kind`      | `string`   | 'text', 'audio', 'image', 'video' |
| `text`      | `text`     |                                   |
| `address`   | `string`   |                                   |
| `latitude`  | `string`   |                                   |
| `longitude` | `string`   |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "errors": array
  }
}
```

###### Response Parameters

| Name              | Value     | Description                           |
| ----------------- | --------- | ------------------------------------- |
| `error["errors"]` | `array`   | Array of serverside validation errors |

###### Available `errors` messages

| Name        | Description                                      |
| ----------- | ------------------------------------------------ |
| `caption`   | Caption can't be blank                           |
| `caption`   | Caption is too long (maximum is 140 characters)" |
| `address`   | Address can't be blank                           |
| `latitude`  | Latitude can't be blank                          |
| `longitude` | Longitude can't be blank                         |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}

```

---

## Show SP

#### Request

###### HTTP Request

```javascript
GET /api/v1/story_points/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | SP's id        |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "storyId": integer,
    "caption": string,
    "public": boolean,
    "kind": string,
    "text": text,
    "address": string,
    "latitude": string,
    "longitude": string,
    "file": string,
    "thumbnail": string,
    "createdAt": datetime,
    "updatedAt": datetime,
    "tags": array,
    "saved": boolean,
    "liked": boolean,
    "user": {
    }
  }
}
```

###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `userId`    | `integer`  | User's id                         |
| `storyId`   | `integer`  | Story's id                        |
| `caption`   | `string`   | SP's caption, max. 40 chrs        |
| `public`    | `boolean`  | default: true                     |
| `kind`      | `string`   | 'text', 'audio', 'image', 'video' |
| `text`      | `text`     |                                   |
| `address`   | `string`   |                                   |
| `latitude`  | `string`   |                                   |
| `longitude` | `string`   |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |
| `saved`     | `boolean`  | true/false                        |
| `liked`     | `boolean`  | true/false                        |
| `user`      | `object`   |                                   |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "message": "Couldn't find StoryPoint with 'id'=1"
  }
}
```

---

## Remove SP

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/story_points/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | SP's id        |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
}
```

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}

```
**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "message": "Couldn't find StoryPoint with 'id'=1"
  }
}
```

---

## Report SP

#### Request

###### HTTP Request

```javascript
POST /api/v1/story_points/:id/reports
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | SP's id        |

###### Request Body

| Name    | Value    | Description                                     |
| ------- |--------- | ----------------------------------------------- |
| `kind`  | `string` | required, "dislike", "spam", "risk", "unsuited" |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "kind": string,
    "storyPointId:": integer,
    "userId": integer
  }
}
```

###### Response Parameters

| Name           | Value      | Description              |
| -------------- | ---------- | ------------------------ |
| `id`           | `integer`  | Report's id              |
| `kind`         | `string`   | Report's kind            |
| `storyPointId` | `integer`  | SP's id                  |
| `userId`       | `integer`  | User's id                |

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "message": "Couldn't find StoryPoint with 'id'=1"
  }
}
```

---
