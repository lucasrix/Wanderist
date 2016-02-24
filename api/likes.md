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
| `story_point_id` | `string`  | required, SP's id     |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "user_id": integer,
    "story_point_id": integer,
    "liked_story_point": object
  }
}
```

###### Response Parameters

| Name              | Value      | Description        |
| ----------------- | ---------- | ------------------ |
| `id`              | `integer`  | Like's id          |
| `user_id`          | `integer`  | User's id          |
| `story_point_id`    | `integer`  | SP's id            |
| `liked_story_point` | `object`   | liked Story Point  |

###### Liked Story Point

```javascript
{
  "id": integer,
  "user_id": integer,
  "story_id": integer,
  "caption": string,
  "public": boolean,
  "kind": string,
  "text": text,
  "address": string,
  "latitude": float,
  "longitude": float,
  "file": string,
  "thumbnail": string,
  "created_at": datetime,
  "updated_at": datetime,
  "tags": array,
  "relation_id": integer,
  "saved": boolean,
  "liked": boolean
}
```
###### Response Parameters

| Name        | Value      | Description                       |
| ----------- | ---------- | --------------------------------- |
| `id`        | `integer`  | SP's id                           |
| `user_id`    | `integer`  | User's id                         |
| `story_id`   | `integer`  | Story's id                        |
| `caption`   | `string`   | SP's caption, max. 140 chrs       |
| `public`    | `boolean`  | default: true                     |
| `kind`      | `string`   | 'text', 'audio', 'image', 'video' |
| `text`      | `text`     |                                   |
| `address`   | `string`   |                                   |
| `latitude`  | `float`    |                                   |
| `longitude` | `float`    |                                   |
| `file`      | `string`   | file path                         |
| `thumbnail` | `string`   | thumbnail path                    |
| `created_at` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `updated_at` | `datetime` | "2016-02-09T09:23:23.000Z"        |
| `tags`      | `array`    | ex. [ "usa", "museum", "2016" ]   |
| `relation_id`| `integer`  | Relation id                       |
| `saved`     | `boolean`  | true/false                        |
| `liked`     | `boolean`  | true/false                        |


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}

```

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "error_messages": [ "story_point_id can't be blank" ],
    "details": {
      "story_point_id": ["can't be blank"]
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
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find Like with 'id'= #{id}" ]
  }
}
```

---
