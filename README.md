# Reflector

A simple HTTP endpoint that "reflects" back information about the caller making the request (in JSON format).

You can use it to answer questions like:
- What is my public facing IP (and hostname)?
- Is my request coming in using IPv6?
- What's the User-Agent in my request?

You can deploy this anywhere you can run Rack applications (e.g. Heroku) and use it e.g. to debug connection issues. At least that's what I use it for, YMMV.

## Example request / response

Request (using HTTPie):

```
$ http GET http://localhost:5000
```

Response (just the JSON):

```
{
    "host": "localhost",
    "ip": "::1",
    "user_agent": "HTTPie/0.9.9",
    "v6": true
}
```
