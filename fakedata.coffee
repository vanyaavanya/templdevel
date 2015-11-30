faker        = require 'faker' 
faker.locale = "ru"

data = ->
        version:
          process.env.npm_package_version
        data: 
          one: 'one'
          two: 'two'
          three: 'three'
          four: 'four'
          five: 'five'
          six: 
            seven:
              seven_is : 'seven'
        page:
          "test"
        fake:
          faker.helpers.userCard()


module.exports = data