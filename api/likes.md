# Likes

### Like Create

#### Request

###### HTTP Request

```javascript
POST /api/v1/likes
```

###### Request Body

| Name           | Value     | Description           |
| -------------- | --------- | --------------------- |
| `storyPointId` | `string`  | required, SP's id     |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "storyPointId": integer,
    "likedStoryPoint": object
  }
}
```

###### Response Parameters

| Name              | Value      | Description        |
| ----------------- | ---------- | ------------------ |
| `id`              | `integer`  | Like's id          |
| `userId`          | `integer`  | User's id          |
| `storyPointId`    | `integer`  | SP's id            |
| `likedStoryPoint` | `object`   | liked Story Point  |

###### Liked Story Point

```javascript
{
  "id": integer,
  "userId": integer,
  "storyId": integer,
  "caption": string,
  "public": boolean,
  "kind": string,
  "text": text,
  "address": string,
  "latitude": float,
  "longitude": float,
  "file": string,
  "thumbnail": string,
  "createdAt": datetime,
  "updatedAt": datetime,
  "tags": array,
  "relationId": integer,
  "saved": boolean,
  "liked": boolean
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
| `latitude`  | `float`    |                                   |
| `longitude` | `float`    |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `createdAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updatedAt` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |
| `relationId`| `integer`  | Relation id                       |
| `saved`     | `boolean`  | true/false                        |
| `liked`     | `boolean`  | true/false                        |


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}

```

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "errorMessages": [ "StoryPointId can't be blank" ],
    "details": {
      "storyPointId": ["can't be blank"]
    }
  }
}
```

### Like Destroy

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/likes/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | Like's id      |


#### Response

**HTTP/1.1 200 OK**

```javascript
{}
```

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find Like with 'id'= #{id}" ]
  }
}
```

---
