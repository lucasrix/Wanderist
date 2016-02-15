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
| `userId`    | `string`  | required, target user's id                         |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "followerId": integer,
    "followedId": integer,
    "followedUser": relationships_object
  }
}
```

###### Response Parameters

| Name          | Value      | Description                       |
| ------------  | ---------- | --------------------------------- |
| `id`          | `integer`  | relationship's id                 |
| `followerId`  | `integer`  | follower's id                     |
| `followedId`  | `integer`  | following's id                    |
| `followedUser`| `object`   | followed user   in JSON           |

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
  "personalUrl": string,
  "storyPointsCount": integer,
  "followed": boolean,
  "relationId": integer,
  "createdAt": datetime,
  "updatedAt": datetime
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
| `personalUrl`   | `string`   | optional, link to user's personal webpage|
|`storyPointsCount`|`integer`|quantity of sPs created by user|
|`followed`|`boolean`|true if followed user|
|`relationId`|`integer`|optional if followed, id of relation object|
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


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
    "errorMessages": [ "UserId can't be blank" ],
    "details": {
      "userId": ["can't be blank"]
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
    "errorMessages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "errorMessages": [ "Couldn't find UserRelation with 'id'= #{id}" ]
  }
}
```

---
