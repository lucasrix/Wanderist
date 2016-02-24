# UserRelationships

### UserRelationship Create

#### Request

###### HTTP Request

```javascript
POST /api/v1/user_relationships
```

###### Request Body

| Name        | Value     | Description                                        |
| ----------- | --------- | -------------------------------------------------- |
| `user_id`    | `string`  | required, target user's id                         |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "follower_id": integer,
    "followed_id": integer,
    "followed_user": relationships_object
  }
}
```

###### Response Parameters

| Name          | Value      | Description                       |
| ------------  | ---------- | --------------------------------- |
| `id`          | `integer`  | relationship's id                 |
| `follower_id`  | `integer`  | follower's id                     |
| `followed_id`  | `integer`  | following's id                    |
| `followed_user`| `object`   | followed user   in JSON           |

###### Followed User in JSON

```javascript
{
  "id": integer,
  "firstname": string,
  "lastname": string,
  "username": string,
  "avatar": string,
  "home": string,
  "about": text,
  "personal_url": string,
  "story_points_count": integer,
  "followed": boolean,
  "relation_id": integer,
  "created_at": datetime,
  "updated_at": datetime
}
```
###### Parameters
| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`id`       | integer |user's id |
|`firstname` | `string` | user's firstname |
|`lastname`|`string`|user's lastname|
|`username`|`string`|user's username|
|`avatar`|`string`|path to user's avatar|
|`home`|`string`|user's address|
|`about`|`text`|user's description|
| `personal_url`   | `string`   | optional, link to user's personal webpage|
|`story_points_count`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relation_id`|`integer`|optional if followed, id of relation object|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


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
    "error_messages": [ "user_id can't be blank" ],
    "details": {
      "user_id": ["can't be blank"]
    }
  }
}
```

### StoryRelationship Destroy

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/user_relationships/:id
```
###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | user relation's id  |


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
    "error_messages": [ "Couldn't find user_relation with 'id'= #{id}" ]
  }
}
```

---
