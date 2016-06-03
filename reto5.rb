=begin
  1. Realizar pregunta
  2. Esperar respuesta del usuario
  3. Respuesta correcta?
    a. No, usuario vuelve a intentarlo
    b. Si, regresar a paso 1
=end

# Estructura de Datos
# Cómo representamos una pregunta y una respuesta?
# Cómo representamos una baraja de preguntas?


# +++++++++++++++ ESTRUCTURA DE DATOS +++++++++++++++

# Monkey Patching para extender funcionalidad clase HASH y poder hacer shuffle
class Hash
  def shuffle
    Hash[self.to_a.sample(self.length)]
  end

  def shuffle!
    self.replace(self.shuffle)
  end
end

class InitSetup
  attr_reader :questions, :answers

  def initialize(file)
    # Representamos las preguntas y respuestas en un HASH para cada objeto
    @questions = {}
    @answers = {}
    @questionnaire = open(file)
    base_define
  end

  def base_define
    i = 1
    q = 1
    a = 1
    # Se organizan con números para que sea más facil encontrar las respuestas a las preguntas en el respectivo Hash luego de revolverles para que cada juego sea diferente.
    @questionnaire.each do |line|
      if i.odd?
        @questions[q] = line.strip
        q += 1
      else
        @answers[a] = line.strip
        a += 1
      end
      i += 1
    end
  end
end

# Haremos una "baraja" de 5 preguntas para Reto5
class Questions_Deck
  attr_reader :questions, :present_question

  def initialize(questions)
    @questions = Hash[questions.shuffle!.first(5)]
    @present_question
  end

  def hit!
    @present_question = @questions.shift
  end
end

# +++++++++++++++ ESTRUCTURA DE DATOS (FIN)+++++++++++++++

# +++++++++++++++ LOGICA DE DATOS +++++++++++++++

# Inicializamos nuestra baraja de preguntas


class Game

  def initialize
    game = InitSetup.new('reto5_preguntas.txt')
    deck = Questions_Deck.new(game.questions)
    puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para cada una de las definiciones. Tendrás 1000 puntos por respuesta correcta. Listo? Vamos!"
    # 1. REALIZAR PREGUNTA
    i = 0
    points = 0 # Variable usada para almacenar los puntos (1000 por pregunta)

    while deck.questions.length > 0
      i += 1
      puts "Definición: #{i}"
      # Tomamos la primera pregunta de la baraja y la mostramos
      deck.hit!
      puts deck.present_question[1]
      puts "Adivinar: "
      user_input = gets.chomp.upcase
      attempt = 1
      # Definimos un numero de intentos por pregunta a 3
      while user_input != game.answers[deck.present_question[0]] && attempt < 3
        puts "Incorrecto!, Trata de nuevo"
        puts "Adivinar: "
        user_input = gets.chomp.upcase
        attempt += 1
      end
      points += 1000 if attempt <= 3 && user_input == game.answers[deck.present_question[0]]
      puts "Correcto!" if user_input == game.answers[deck.present_question[0]]
      puts
    end

    if points < 3000
      puts "Buen intento pero necesitas practicar más. Tu resultado final son #{points} puntos"
    elsif points < 5000
      puts "Nada mal, tu resultado final son #{points} puntos"
    else
      puts "Felicidades tu resultado final es de #{points} puntos :) Perfecto!!"
    end

  end
end

# +++++++++++++++ LOGICA DE DATOS (FIN) +++++++++++++++

Juego = Game.new
