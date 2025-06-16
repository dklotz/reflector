# Reflector

A simple HTTP endpoint that "reflects" back information about the caller making the request (in JSON format).

You can use it to answer questions like:
- What is my public facing IP (and hostname)?
- Is my request coming in using IPv6?
- What's the User-Agent in my request?
- What headers is the proxy in front of my application adding?

You can deploy this anywhere you can run Rack applications (e.g. Heroku, GCR or anywhere you can deploy docker containers) and use it e.g. to debug connection issues. At least that's what I use it for, YMMV.

## Example request / response

Request (using HTTPie):

```
$ http GET http://localhost:9292
```

Response (just the JSON):

```
{
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive",
        "Host": "localhost:9292",
        "User-Agent": "HTTPie/2.1.0",
        "Version": "HTTP/1.1"
    },
    "host": "localhost",
    "ip": "::1",
    "user_agent": "HTTPie/2.1.0",
    "v6": true
}
```

## Live version

You can try out a live version here (currently deployed to GCR):

```
http -v GET https://reflector.koerdt.dev
```
