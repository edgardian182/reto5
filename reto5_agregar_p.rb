puts "Para poder agregar preguntas y respuestas a Reto5 por favor ingrese la clave de ADMIN: "
clave = gets.chomp

if clave == "RETO5"
  loop {
  datos = open('reto5_preguntas.txt', 'a')
  puts "Ingrese la pregunta: "
  pregunta = gets.chomp
  puts "Ingrese la respuesta: "
  respuesta = gets.chomp
  datos.write("\n#{pregunta.capitalize}\n")
  datos.write("#{respuesta.upcase}")
  puts "Desea agregar otra pregunta? (Y/N)"
  r = gets.chomp
  break if r == "N"
  }
else
  puts "INCORRECTO"
end

