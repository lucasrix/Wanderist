# Relationships

### Relationship Create

#### Request

###### HTTP Request

```javascript
POST /api/v1/relationships
```

###### Request Body

| Name        | Value     | Description                                        |
| ----------- | --------- | -------------------------------------------------- |
| `id`        | `string`  | required                                           |
| `type`      | `string`  | required, can be "user" or "story"                 |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "entityId": integer,
    "entityType": string,
    "entity": relationships_object
  }
}
```
###### Response Parameters

| Name         | Value      | Description                       |
| ------------ | ---------- | --------------------------------- |
| `id`         | `integer`  | relationship's id                 |
| `entityId`   | `integer`  | entity's id                       |
| `entityType` | `string`   | can be "user" or "story"          |
| `entity`     | `object`   | user or story   in JSON            |

###### User as relationships_object

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
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

###### Story as relationships_object

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

###### Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | story's id               |
| `userId`      | `integer`  | user's id                |
| `name`        | `string`   | name                     |
| `description` | `text`     | description              |
| `public`      | `boolean`  | true/false               |
|`createdAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updatedAt`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}

```

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
| `error["errors"]` | `array`   | array of serverside validation errors |

###### Available `errors` messages

| Name         | Description                                      |
| ------------ | ------------------------------------------------ |
| `entityId`   | "entityId can't be blank"                         |
| `entityType` | "entityType can't be blank"                        |
------------


### Relationship Destroy

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/relationships
```
###### Request Body

| Name        | Value     | Description                                   |
| ----------- | --------- | -------------------------------------------- |
| `id`        | `string`  | required                                        |
| `type`      | `string`  | required, can be "user" or "story"  |

#### Response

**HTTP/1.1 200 OK**

```javascript
{}
```

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "message": "You don't have permission to access"
  }
}

```
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
| `error["errors"]` | `array`   | array of serverside validation errors |

###### Available `errors` messages

| Name         | Description                                      |
| ------------ | ------------------------------------------------ |
| `entityId`   | "entityId can't be blank"                          |
| `entityType` | "entityType can't be blank"                       |
------------
