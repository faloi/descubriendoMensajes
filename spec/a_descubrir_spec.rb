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
end
