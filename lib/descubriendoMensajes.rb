require 'descubriendoMensajes/version'

class ADescubrir
  def method_missing(selector, *argumentos)
    "te agarre pibe, me dijiste #{selector}"
  end
end
