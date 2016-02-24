# Auth

### Sign Up

#### Request

###### HTTP request

```javascript
POST /api/v1/auth
```
###### Request Body
  ```javascript
{
  "email": string,
  "password": string
}
```

###### Request Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `email`       | `string` |required |
| `password` | `string` | required, minimum length 8 characters |

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "status": "success",
  "data": {
    "id": integer,
    "provider": string,
    "uid": string,
    "username": string,
    "email": string,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```
###### Response Parameters
| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `id`       | integer |user's id |
| `provider` | `string` | 'email' |
|`uid`|`string`|user's email|
|`username`|`string`|user's username, default: User#{user_id}, can be changed in next step|
|`email`|`string`|user's email|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 403 Forbidden**

 ```javascript
{ 
  "error": {
    "error_messages": array,
    "details": object
  }
}
```
###### Response Parameters

**Available fields error["details"]**:

| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `details ["email"]`| `array` | Array of serverside validation errors for email
| `details ["password"]`| `array` | Array of serverside validation errors for password

**Available  `details["email"] errors`**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty email|
| `is not an email`|if email has wrong format|
| `address is already in use`|if user with email already exists|

**Available  `details["password"] errors`**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty password|
| `is too short (minimum is 8 characters)`|if password length less then 8 characters|


**Available  `error["error_messages"]`**:

Can include all available messages for each field.
Creates from the following rules:
 `field name` +  `errors ["field_message"]`
 For example => Password can't be blank

------------

### Sign In

#### Request

###### HTTP request

```javascript
POST /api/v1/auth/sign_in
```

###### Request Body

```javascript
{
  "provider": string,
  "email": string,
  "password": string
}
```

###### Request Parameters
| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`provider`| `string` |required, available: "email", "facebook", "google" |
|`email`|`string`|required if provider email|
| `password` | `string` | required, facebook/google access token if provider facebook/google|

#### Response

**HTTP/1.1 200 OK**

```javascript
{
  "data": {
    "id": integer,
    "provider": string,
    "uid": string,
    "email": string,
    "username": string,
    "firstname": string,
    "lastname": string,
    "created_at": datetime,
    "updated_at": datetime
  }
}
```

###### Response Parameters
| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `id`       | `integer` |user's id |
| `provider` | `string` | available |
|`uid`|`string`|user's uid|
|`email`|`string`|user's email|
|`username`|`string`|user's username|
|`firstname`|`string`|optional, user's firstname|
|`lastname`|`string`|optional, user's lastname|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|

**HTTP/1.1 401 Unauthorized**

 ```javascript
{
  "error": {
    "error_messages": [ "Invalid login credentials. Please try again." ]
  }
}
```
------------


### Sign Out

#### Request

###### HTTP request

```javascript
DELETE /api/v1/auth/sign_out
```
#### Response

 **HTTP/1.1 200 OK**

```javascript
{
  "success": true
}
```

 **HTTP/1.1 404  Not Found**
```javascript
{
  "error": {
    "error_messages": [ "User was not found or was not logged in." ]
}
```
------------


### Reset Password via Email

#### Request

###### HTTP request

```javascript
POST /api/v1/auth/password
```

###### Request Body

```javascript
{
  "email": string
  "redirect_url": string
}
```
###### Request Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`email`| `string` |required |
|`redirect_url`|`string`|required|

#### Response

 **HTTP/1.1 200 OK**

###### Response Body

```javascript
{
  "success": boolean,
  "message": string
}
```

###### Response Parameters


| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`success`| `boolean` |true|
|`message`|`string`|"An email has been sent to `email` containing instructions for resetting your password."|


 **HTTP/1.1 404 Not Found**

###### Response Body


```javascript
{
  "error": {
    "error_messages": [ "Unable to find user with email #{email}." ]
  }
}
```

------------

### Reset Password

#### Request

###### HTTP request

```javascript
PUT /api/v1/auth
```

###### Request Body

```javascript
{
  "password": string,
  "password_confirmation": string,
  "current_password": string
}
```
###### Request Parameters

| Name         | Value    | Description   |
| ------------ |----------| --------------|
|`password`| `string` |required, new user's password |
|`password_confirmation`|`string`|required, confirmation of new user's password|
|`current_password`| `string` |required, current user's password |


#### Response

 **HTTP/1.1 200 OK**

###### Response Body

```javascript
{
  "data": {
    "id": integer,
    "provider": string,
    "uid": string,
    "email": string,
    "username": string,
    "firstname": string,
    "lastname": string,
    "created_at": datetime,
    "updated_at": datetime
    }
}
```
###### Response Parameters
| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `id`       | integer |user's id |
| `provider` | `string` | 'email' |
|`uid`|`string`|user's email|
|`username`|`string`|user's username|
|`email`|`string`|user's email|
|`created_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|
|`updated_at`|`datetime`|datetime, format:  YYYY-MM-DDTHH: mm:ss.sssZ|


**HTTP/1.1 403 Forbidden**

 ```javascript
{ 
  "error": {
    "error_messages": array,
    "details": object
}
```
###### Response Parameters

**Available fields error["details"]**:

| Name         | Value    | Description   |
| ------------ |----------| --------------|
| `details["password"]`| `array` | Array of serverside validation errors for password
| `details["password_confirmation"]`| `array` | Array of serverside validation errors for password_confirmation
| `details["current_password]`| `array` | Array of serverside validation errors for current_password

**Available  `details["password"]`**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty password|
| `is too short (minimum is 8 characters)`|if password length less then 8 characters|

**Available  `details["password_confirmation"]`**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty password confirmation|
| `doesn't match Password`|if passwords aren't equal|

**Available  `errors ["current_password"]`**:

| Name      | Description   |
| ------------| --------------|
| `can't be blank`| if empty current password|
| `is invalid`|if invalid current password|

**Available  `error["error_messages"]`**:

Can include all available messages for each field.
Creates from the following rules:
 `field name` +  `errors ["field_message"]`
 For example => Password can't be blank
