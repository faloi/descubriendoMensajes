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

    expect(Perro.mensajes_recibidos).to eq([:ladrar, :correr].to_set)
  end

  it "puede discriminar los mensajes segun su clase" do
    Perro.new.ladrar
    Gato.new.maullar

    expect(Perro.mensajes_recibidos).to eq([:ladrar].to_set)
    expect(Gato.mensajes_recibidos).to eq([:maullar].to_set)
  end

end
