# Introducing the alexa_skillsdev gem

The alexa_skillsdev gem contains a collection of methods which access the Amazon Alexa Skill API (web service).

Usage:

    require 'alexa_skillsdev'

    asd = AlexaSkillsDev.new 'YOUR-AMAZON-ACCESS-KEY'
    asd.vendor
    #=> {:id=>"M13T...", :name=>"James Robertson", :roles=>["ROLE_ADMINI..."]}


## Resources

* How to get an access token to access the Alexa Skills REST API http://www.jamesrobertson.eu/snippets/2018/jun/20/how-to-get-an-access-token-to-access-the-alexa-skills-rest-api.html#
* alexa_skillsdev https://rubygems.org/gems/alexa_skillsdev

alexa skills amazon gem skillsdev api rest
