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
| `storyId`   | `string`  | required                                        |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "storyId": integer,
    "followedStory": relationships_object
  }
}
```

###### Response Parameters

| Name            | Value      | Description                       |
| --------------- | ---------- | --------------------------------- |
| `id`            | `integer`  | relationship's id                 |
| `userId`        | `integer`  | user's id                         |
| `storyId`       | `integer`  | story's id                        |
| `followedStory` | `object`   | followed story in JSON            |

###### Followed Story

```javascript
{
  "id": integer,
  "userId": integer,
  "name": string,
  "description": text,
  "public": boolean,
  "createdAt": datetime,
  "updatedAt": datetime
}
```

###### Response Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | story's id               |
| `userId`      | `integer`  | user's id                |
| `name`        | `string`   | name                     |
| `description` | `text`     | description              |
| `public`      | `boolean`  | true/false               |
| `createdAt`   | `datetime` | datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ |
| `updatedAt`   | `datetime` | datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ |


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
    "errorMessages": [ "StoryId can't be blank" ],
    "details": {
      "storyId": ["can't be blank"]
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
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find StoryRelation with 'id'= #{id}" ]
  }
}
```

---
