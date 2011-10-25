require 'yajl'

class BusinessEvent
  
  def initialize(params)
    @params = params
    try(:after_initialize)
  end
  
  def process
    # verify all the data
    # then process unconditionally
    unconditional_process
  end
  
  def unconditional_process
    throw "unconditional_process and process methods should be implemented"
  end
    
  def serialize
    Yajl::Encoder.encode({ :class => self.class.to_s, :params => @params })
  end

  def self.deserialize(json)
    obj_params = HashWithIndifferentAccess.new(Yajl::Parser.parse(json))
    obj_params[:class].constantize.new(obj_params[:params])
  end
  
  def self.load(event_model)
    return nil if !event_model.successful
    deserialize(event_model.serialized)
  end
  
  def self.replay_up_to(time)
    Event.where("created_at <= ?", time).each do |e|
      Timecop.travel(e.created_at) do
        load(e).unconditional_process
      end
    end
  end
  
  def save(succeeded)
    Event.create!(:serialized => serialize, :successful => succeeded)
  end
end