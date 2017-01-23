class IdentifierCallback
  include Identifier

  def initialize(attr = "surface")
    @attr = attr
  end

  def before_validation(object)
    object.send "identifier=", self.class.identify(object.send("#{@attr}"))
    true
  end
end
