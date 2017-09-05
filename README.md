
## Restaurant Review

restaurant reviewing app (api) built on rails using trailblazers. 


### Run

- `rake db:migrate`
- `rake db:restaurant_seed`

### User login
- POST request to `/api/app_tokens` with username and password credentials response will be a token if success
- Save token for future

### Raw headers in api calls
> accept: application/json; version=1;  
> Authorization: Bearer token=TOKEN;  
> Content-Type: application/x-www-form-urlencoded
