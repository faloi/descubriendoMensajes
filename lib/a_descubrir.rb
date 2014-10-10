require 'descubriendoMensajes/version'

class ADescubrir
  class << self
    attr_accessor :mensajes_recibidos
  end

  def method_missing(selector, *argumentos)
    self.class.mensajes_recibidos << selector
  end

  def self.inherited(subclass)
    subclass.mensajes_recibidos = Set.new
  end
end
