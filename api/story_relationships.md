# StoryRelationships

### StoryRelationship Create

#### Request

###### HTTP Request

```javascript
POST /api/v1/story_relationships
```

###### Request Body

| Name        | Value     | Description                                     |
| ----------- | --------- | ----------------------------------------------- |
| `story_id`   | `string`  | required                                        |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "user_id": integer,
    "story_id": integer,
    "followed_story": relationships_object
  }
}
```

###### Response Parameters

| Name            | Value      | Description                       |
| --------------- | ---------- | --------------------------------- |
| `id`            | `integer`  | relationship's id                 |
| `user_id`        | `integer`  | user's id                         |
| `story_id`       | `integer`  | story's id                        |
| `followed_story` | `object`   | followed story in JSON            |

###### Followed Story

```javascript
{
  "id": integer,
  "user_id": integer,
  "name": string,
  "description": text,
  "public": boolean,
  "created_at": datetime,
  "updated_at": datetime
}
```

###### Response Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | story's id               |
| `user_id`      | `integer`  | user's id                |
| `name`        | `string`   | name                     |
| `description` | `text`     | description              |
| `public`      | `boolean`  | true/false               |
| `created_at`   | `datetime` | datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ |
| `updated_at`   | `datetime` | datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ |


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
    "error_messages": [ "story_id can't be blank" ],
    "details": {
      "story_id": ["can't be blank"]
    }
  }
}
```

---

### StoryRelationship Destroy

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/story_relationships/:id
```
###### Request Path

| Name        | Value     | Description                             |
| ----------- | --------- | --------------------------------------- |
| `:id`       | `string`  | required, story relation's id           |

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
    "error_messages": [ "Couldn't find story_relation with 'id'= #{id}" ]
  }
}
```

---
