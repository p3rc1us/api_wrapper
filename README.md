# How to start Part 1: Backend Task

##### Clone my repo
```
git clone https://github.com/p3rc1us/api_wrapper
```
##### Install gems
```
bundle install
```
##### Start 'em engines!
```
cd api_wrapper
```
```
bin/rails c
```
##### Initiate!
```
client = Restful::V1::Client.new
```
##### Run it, just replace `times` and `format` with how many times you want to run it and what format you wanted it.
```
client.objects(times, format)
```

### Example Usage:
```
client.objects(3, :csv)
```
```
client.objects(3, :json)
```
```
client.objects(3, :console)
```

##### Reminder:
Look at the root folder for the `data.csv` and `data.json` files
![alt text](image.png)

# How to start Part 2: Frontend Task

##### With the same repository, we just need to transfer to another branch!(from main branch)
```
git checkout -b Frontend_Task
```
##### Then git pull
```
git pull origin Frontend_Task
```
##### Start the server
```
bin/rails s
```
#### Then try the buttons!

## Here is the proof of downloadables
![alt text](image-1.png)

## Note that too many request will have an error response. Mostly with the csv button.
### this has too many requests, thats why there's nothing
![alt text](image-2.png)


## So make sure first that the homepage has Items on the table then click the buttons.

## Also make sure you have PostgreSQL
