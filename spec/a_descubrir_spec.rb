require_relative '../lib/a_descubrir'

RSpec.describe "Un descendiente de ADescubrir" do
  before(:each) do
    Perro = Class.new(ADescubrir)
    Gato = Class.new(ADescubrir)
  end

  it "atrapa los mensajes que se le envian" do
    lassie = Perro.new
    lassie.ladrar
    lassie.correr
    lassie.correr

    expect(Perro.mensajes_recibidos).to eq([:ladrar, :correr])
  end

  it "puede discriminar los mensajes segun su clase" do
    Perro.new.ladrar
    Gato.new.maullar

    expect(Perro.mensajes_recibidos).to eq([:ladrar])
    expect(Gato.mensajes_recibidos).to eq([:maullar])
  end

  it "sabe cuantas veces fue enviado cada mensaje" do
    lassie = Perro.new
    toby = Perro.new
    lassie.ladrar
    toby.ladrar
    toby.ladrar

    expect(Perro.cuantas_veces_recibiste(:ladrar)).to eq(3)
    expect(Perro.cuantas_veces_recibiste(:correr)).to eq(0)
  end

  it "si no se le envian mensajes, no se parece a ninguna clase" do
    expect(Perro.que_clases_se_me_parecen).to be_empty
  end

  it "si se le envian mensajes, sabe que clases se le parecen" do
    cuchuflito = Perro.new
    cuchuflito.size
    cuchuflito.upcase

    expect(Perro.que_clases_se_me_parecen).to include(String)
  end

  describe "puede crear metodos para mensajes faltantes" do
    before(:each) do
      @lassie = Perro.new
      toby = Perro.new
      @lassie.ladrar
      toby.ladrar
      toby.ladrar
      @lassie.correr

      Perro.crear_metodos_para_mensajes_faltantes(2)
    end

    it "con una implementacion dummy" do
      expect(@lassie.ladrar).to eq("Soy un Perro y me estan enviando el mensaje ladrar")
    end

    it "solo para los que se llamaron al menos n veces" do
      expect(@lassie.correr).not_to be_a(String)
    end

    it "solo para la clase en cuestion" do
      expect(Gato.new.ladrar).not_to be_a(String)
    end
  end

  describe "puede crear metodos para mensajes faltantes en todos los descendientes" do
    before(:each) do
      @lassie = Perro.new
      @lassie.correr
      @lassie.correr
      @lassie.correr
    end

    it "partiendo de cualquier descendiente de ADescubrir" do
      Salchicha = Class.new(Perro)
      pancho = Salchicha.new
      pancho.poneteKetchup
      pancho.poneteKetchup
      pancho.poneteKetchup

      Perro.crear_metodos_para_mensajes_faltantes_con_descendientes(3)

      expect(@lassie.correr).to eq("Soy un Perro y me estan enviando el mensaje correr")
      expect(pancho.poneteKetchup).to eq("Soy un Salchicha y me estan enviando el mensaje poneteKetchup")
    end

    it "partiendo de ADescubrir" do
      garfield = Gato.new
      garfield.maullar
      garfield.maullar
      garfield.maullar

      ADescubrir.crear_metodos_para_mensajes_faltantes_con_descendientes(3)

      expect(@lassie.correr).to eq("Soy un Perro y me estan enviando el mensaje correr")
      expect(garfield.maullar).to eq("Soy un Gato y me estan enviando el mensaje maullar")
    end
  end

  it "puede exportar el codigo fuente con las implementaciones dummies" do
    lassie = Perro.new
    toby = Perro.new
    lassie.ladrar
    toby.ladrar
    toby.ladrar
    lassie.correr
    lassie.correr

    fuentePerro = "/home/faloi/Desktop/Perro.rb"
    Perro.exportar_codigo_fuente_con_implementaciones(fuentePerro, 2)
    expect(File.read(fuentePerro)).to eq(
"""class Perro
  def ladrar
    \"Soy un Perro y me estan enviando el mensaje ladrar\"
  end

  def correr
    \"Soy un Perro y me estan enviando el mensaje correr\"
  end
end""")
  end
end
