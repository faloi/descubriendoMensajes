## I. Descubriendo métodos faltantes
Queremos tener la posibilidad de ir descubriendo qué métodos necesita cada clase de un diseño que se va armando. Para eso, crear una clase `ADescubrir`, subclase de `Object`, que no agregue comportamiento. Cuando una instancia de un descendiente de `ADescubrir` recibe un mensaje que no puede procesar, se debe registrar, de forma tal que se pueda consultar para cada clase, qu ́e mensajes se le enviaron a alguna instancia que no pudo responder, y para cada uno de estos mensajes, cuántas veces. A cada descendiente de `ADescubrir` se le tiene que poder preguntar:

- qué mensajes se le han enviado a sus instancias, que no han podido responder
- dado un mensaje, cuántas veces se lo ha enviado.

Ambas deben ser consultas a la clase, p.ej.

```ruby
Perro.mensajesRecibidos
Perro.cuantasVecesRecibiste(:ladrar)
```

donde `Perro` es descendiente de `ADescubrir`.
Ejemplo: si se crea la clase Perro, y despu ́es de hace lo siguiente

```ruby
lassie = Perro.new
toby = Perro.new
lassie.ladrar
toby.ladrar
toby.ladrar
toby.correr
```

la respuesta a `Perro.mensajesRecibidos` debe ser `[:ladrar, :correr]`, y `Perro.cuantasVecesRecibiste(:ladrar)` debe devolver `3`.

## II. A qué clases me parezco
Poder preguntarle a un descendiente de ADescubrir qu ́e clases existentes (no los descendientes de ADescubrir, sino las “clases de verdad”) se le parecen. P.ej.

```ruby
Perro.queClasesSeMeParecen
```

La clase `D`, que es una clase que desciende de `ADescubrir`, se parece a una clase `C` si: se le envió al menos un mensaje a `D`, y todos los mensajes que se le enviaron a `D`, los entienden las instancias de `C`. P.ej. si los mensajes que recibieron instancias de `Cuchuflito` son `:size` y `:upcase`, entonces la respuesta a `Cuchuflito.queClasesSeMeParecen` debe incluir `String`, porque los `String`s entienden estos dos mensajes.

## III. Generación de métodos faltantes
Poder pedirle a un descendiente de `ADescubrir` que cree métodos para todos los mensajes que se le enviaron al menos _n_ veces, donde el _n_ es un parámetro. Los métodos agregados deben devolver el `String` `"Soy un XXXX y me estan enviando el mensaje YYYY"`, donde `XXXX` es la clase e `YYYY` es el selector.
Sobre el ejemplo de la parte 1, después de evaluar
```ruby
Perro.crearMetodosParaMensajesFaltantes(2)
```
al hacer
```ruby
lassie.ladrar
```
tiene que entender el mensaje, y tiene que devolver
```
Soy un Perro y me estan enviando el mensaje ladrar
```
Adicionalmente a `crearMetodosParaMensajesFaltantes(n)`, tiene que implementarse también una variante, que se llame `crearMetodosParaMensajesFaltantesConDescendientes(n)`, que cree los métodos de acuerdo a lo recién explicado, para la clase que recibe el mensaje (hasta acá es igual al método pedido antes) y también para todos sus descendientes (esto es lo que tiene de distinto el nuevo método).
P.ej. si hago
```ruby
ADescubrir.crearMetodosParaMensajesFaltantesConDescendientes(2)
```
lo hace para `ADescubrir`, y también para todos sus descendientes.

## IV. Bonus
Lo mismo del punto 3, pero en lugar de crear los métodos, generar un archivo de texto con el fuente. P.ej. si el único mensaje para agregar es `Perro.ladrar`, entonces el archivo tiene que tener esta forma.

```ruby
class Perro
  def ladrar
    return "Soy un Perro y me estan enviando el mensaje ladrar"
  end
end
```
