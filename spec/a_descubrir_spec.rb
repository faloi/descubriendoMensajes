require_relative '../lib/a_descubrir'

RSpec.describe "ADescubrir" do
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
end
