# Stories

## Create a new Story

#### Request

###### HTTP request

```javascript
POST /api/v1/stories
```

###### Request Body

| Name            | Value    | Description |
| --------------- |--------- | ----------- |
| `name`          | `string` | required    |
| `description`   | `text`   | optional    |
| `story_point_ids` | `array`  | optional    |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "user_id": integer,
    "name": string,
    "description": text,
    "public": boolean,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | Story's id               |
| `user_id`      | `integer`  | User's id                |
| `name`        | `string`   | Name                     |
| `description` | `text`     | Description              |
| `public`      | `boolean`  | true/false               |
| `created_at`   | `datetime` | 2016-02-09T09:23:23.000Z |
| `updated_at`   | `datetime` | 2016-02-09T09:23:23.000Z |

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "error_messages": array,
    "details": object
  }
}
```

###### Response Parameters

| Name               | Value     | Description                           |
| ------------------ | --------- | ------------------------------------- |
| `details["name"]`  | `array`   | Array of serverside validation errors |

###### Available `details["name"]` errors

| Name             | Description   |
| -----------------| ------------- |
| `can't be blank` | if empty name |

###### Available `error["errorMessages"]`

Can include all available messages for each field.
Creates from the following rules:
`field name` + `errors["field_message"]`
For example => Name can't be blank

**HTTP/1.1 403 Forbidden**

```javascript
{
  "error": {
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

---

## Update a Story

#### Request

###### HTTP request

```javascript
PUT /api/v1/stories/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | Story's id     |

###### Request Body

| Name            | Value    | Description |
| --------------- |--------- | ----------- |
| `name`          | `string` | required    |
| `description`   | `text`   | optional    |
| `story_point_ids` | `array`  | optional    |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "user_id": integer,
    "name": string,
    "description": text,
    "public": boolean,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters

| Name          | Value      | Description              |
| ------------- | ---------- | ------------------------ |
| `id`          | `integer`  | Story's id               |
| `user_id`      | `integer`  | User's id                |
| `name`        | `string`   | Name                     |
| `description` | `text`     | Description              |
| `public`      | `boolean`  | true/false               |
| `created_at`   | `datetime` | 2016-02-09T09:23:23.000Z |
| `updated_at`   | `datetime` | 2016-02-09T09:23:23.000Z |

**HTTP/1.1 422 Unprocessable Entity**

```javascript
{
  "error": {
    "error_messages": array,
    "details": object
  }
}
```

###### Response Parameters

| Name               | Value     | Description                           |
| ------------------ | --------- | ------------------------------------- |
| `details["name"]`  | `array`   | Array of serverside validation errors |

###### Available `details["name"]` errors

| Name             | Description   |
| -----------------| ------------- |
| `can't be blank` | if empty name |

###### Available  `error["errorMessages"]`

Can include all available messages for each field.
Creates from the following rules:
`field name` + `errors["field_message"]`
For example => Name can't be blank

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
    "error_messages": [ "Couldn't find Story with 'id'=#{:id}" ]
  }
}
```

---

## Show a Story

#### Request

###### HTTP request

```javascript
GET /api/v1/stories/:id
```

###### Request Path
| Name  | Value    | Description |
| ----- |--------- | ----------- |
| `:id` | `string` | Story's id  |

#### Response

**HTTP/1.1 200 OK**

If successful, this method returns a response body with the following structure:

```javascript
{
  "data": {
    "id": integer,
    "userId": integer,
    "name": string,
    "public": boolean,
    "description": text,
    "created_at": datetime,
    "updated_at": datetime,
    "followed": boolean,
    "relation_id": integer,
    "story_points": [
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
    ]
  }
}
```

###### Response Parameters

| Name          | Value      | Description                     |
| ------------- |----------- | ------------------------------- |
| `id`          | `integer`  | Story's id                      |
| `user_id`      | `integer`  | User's id                       |
| `name`        | `string`   | Name                            |
| `description` | `text`     | Description                     |
| `public`      | `boolean`  | true/false                      |
| `created_at`   | `datetime` | 2016-02-09T09:23:23.000Z        |
| `updated_at`   | `datetime` | 2016-02-09T09:23:23.000Z        |
| `followed`    | `boolean`  | true/false                      |
| `relation_id`  | `integer`  | optional if followed, id of relation object|
| `story_points` | `array`    | SPs in Story                    |

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
    "error_messages": [ "Couldn't find Story with 'id'=#{:id}" ]
  }
}
```

---

## Remove a Story

#### Request

###### HTTP Request

```javascript
DELETE /api/v1/stories/:id
```

###### Request Path

| Name   | Value    | Description    |
| ------ |----------| -------------- |
| `:id`  | `string` | Story's id     |

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
    "error_messages": [ "You don't have permission to access" ]
  }
}
```

**HTTP/1.1 404 Not Found**

```javascript
{
  "error": {
    "error_messages": [ "Couldn't find Story with 'id'=#{:id}" ]
  }
}
```

---
