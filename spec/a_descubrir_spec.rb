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
end
