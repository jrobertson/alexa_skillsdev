#!/usr/bin/env ruby

# file: alexa_skillsdev.rb

# description: Provides convenient access to the Alexa Skills API methods
# status: Currently under development.

# see also: 
# * [How to get an access token to access the Alexa Skills REST API](http://www.jamesrobertson.eu/snippets/2018/jun/20/how-to-get-an-access-token-to-access-the-alexa-skills-rest-api.html)
# * [Alexa Skills Kit Command Line Interface and Alexa Skill Management API Overview](https://developer.amazon.com/docs/smapi/ask-cli-intro.html#smapi-intro)

require 'pp'
require 'json'
require 'rest-client'



class AlexaSkillsDev

  attr_reader :vendor_id

  def initialize(accesskey, url: 'https://api.amazonalexa.com', debug: false)
    
    @accesskey, @url_base, @debug = accesskey, url, debug

  end
  
  def interaction_model(skill_id, stage: 'development', local: 'en-US')
    
    get "/v1/skills/{skill_id}/stages/{stage}/interactionModel/" + 
        "locales/{locale}"

  end      
  
  # list skills by name
  #
  def list()
    self.skills[:skills].map {|x| x[:nameByLocale].to_a[0].last}
  end
  
  def manifest(name)
    
    r = skill(name)
    get r[:_links][:self][:href]
    
  end
  
  def model(name=nil, id: nil, stage: 'development', locale: nil)    
    
    if name then
      r = skill(name)      
      id, stage, locale = r[:skillId], r[:stage], r[:nameByLocale].keys.first
    end
    
    puts  "id: %s stage: %s locale: %s" % [id, stage, locale] if @debug
    get "/v1/skills/#{id}/stages/#{stage}/interactionModel/locales/#{locale}"
    
  end

  def vendor()

    h = self.vendors()[:vendors].first
    @vendor_id = h[:id]
    h

  end

  def vendors()
    
    get '/v1/vendors'

  end
  
  def skill(name=nil, id: nil, stage: 'development', locale: nil)
    
    if name then
      
      r = self.skills()[:skills].select do |x|
        
        if locale then
          x[:nameByLocale][locale].downcase == name.downcase
        else
          x[:nameByLocale].to_a[0].last.downcase == name.downcase
        end
      end
      
      return r.first if r.any?
      
    end
    
    get "/v1/skills/#{id}/stages/#{stage}/manifest"

  end    
  

  def skills(vendor_id=@vendor_id)
    
    vendor_id ||= vendor[:id]
    get "/v1/skills?vendorId=#{vendor_id}"

  end


  protected

  def get(uri)

    r = RestClient.get(@url_base + uri, \
      headers={'Authorization' => @accesskey})
    JSON.parse r.body, symbolize_names: true

  end

end
