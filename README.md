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
cd wrapper
```
```
bin/rails c
```
##### Initiate!
```
client = Restful::V1::Client.new
```
##### Run it, just replace `times` with how many times you want to run it
```
client.objects(times)
```