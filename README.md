
## For Setup, run
``` 
bundle install
```

### To run test, run command

rspec

### To run rails server, run
```
rails s
```

### Api documentation
```
    # URL: POST /api/robot/0/orders
    # request body
    {
      commands: ["PLACE 0,0,NORTH", "MOVE", "REPORT"]
    }
    
    # success response
    {
      location: [0,1,'NORTH']
    }
    
    # failure response
    {
      error: "Invalid command: 'STAND'"
    }
```
