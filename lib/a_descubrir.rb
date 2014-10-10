require 'descubriendoMensajes/version'

class ADescubrir
  class << self
    attr_accessor :mensajes
  end

  def self.inherited(subclass)
    subclass.mensajes = Hash.new
    subclass.mensajes.default = 0
  end

  def self.mensajes_recibidos
    self.mensajes.keys
  end

  def self.cuantas_veces_recibiste(selector)
    self.mensajes[selector]
  end

  def method_missing(selector, *argumentos)
    self.class.mensajes[selector] = self.class.mensajes[selector] + 1
  end
end
