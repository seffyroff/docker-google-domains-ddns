# Docker Google Domains DDNS


## Intent

This container is used to update your [Google Domains](https://domains.google.com) dynamic DNS entry.



## Technical details

This container uses ENV to set multiple variables required by the Google Domains API.

Requirements:
- USER_AGENT - You must set a user agent in your request as well. Web browsers will generally add this for you when testing via the above url.
- USERNAME - Username found on the Dynamic DNS entry.
- PASSWORD - Password found on the Dynamic DNS entry.
- HOSTNAME- Which Dynamic DNS entry to run.
- INTERVAL - How often to update Google Domains.
  - INTERVAL must be a number followed by m, h, or d. Example: 5m
  - INTERVAL must not be less than 5 minutes.

Example:

```
$ docker run -d -e USER_AGENT="jknsware/docker-google-domains-ddns" -e HOSTNAME=<insert_hostname> -e USERNAME=<insert_password> -e PASSWORD=<insert_password> -e INTERVAL=5m --name google-domains-ddns jknsware/docker-google-domains-ddns
```
Probably should set `USER_AGENT` to the container name being used. Example: `USER_AGENT="jknsware/docker-google-domains-ddns"`

### External Links

- [Dynamic DNS](https://support.google.com/domains/answer/6147083), for more documentation.


### Thanks

-  [@seanstanley](https://github.com/seanstaley), and the other contributers to give me a starting place.
-  [@codep0tato](https://github.com/codep0tato), for introducing me to <insert_anything_cool_here>.
