require 'descubriendoMensajes/version'

class ADescubrir
  class << self
    attr_accessor :mensajes
  end

  def self.init(subclass)
    subclass.mensajes = Hash.new
    subclass.mensajes.default = 0
  end

  self.init(self)

  def self.inherited(subclass)
    init(subclass)
  end

  def self.mensajes_recibidos
    mensajes.keys
  end

  def self.cuantas_veces_recibiste(selector)
    mensajes[selector]
  end

  def self.que_clases_se_me_parecen
    if mensajes_recibidos.empty?
      []
    else
      ObjectSpace.each_object(Class).select { |clazz| Set.new(mensajes_recibidos).subset? Set.new(clazz.instance_methods) }
    end
  end

  def self.crear_metodos_para_mensajes_faltantes(cantidad_minima)
    mensajes_recibidos
      .select { |mensaje| cuantas_veces_recibiste(mensaje) >= cantidad_minima }
      .each { |mensaje| crear_metodo_para(mensaje) }
  end

  def self.crear_metodos_para_mensajes_faltantes_con_descendientes(cantidad_minima)
    descendientes.each { |clazz| clazz.crear_metodos_para_mensajes_faltantes(cantidad_minima) }
  end

  def self.descendientes
    ObjectSpace.each_object(Class).select { |clazz| clazz.ancestors.include? self }
  end

  def self.crear_metodo_para(selector)
    define_method(selector) do
      "Soy un #{self.class.name} y me estan enviando el mensaje #{selector}"
    end
  end

  def method_missing(selector, *argumentos)
    self.class.mensajes[selector] = self.class.mensajes[selector] + 1
  end
end
