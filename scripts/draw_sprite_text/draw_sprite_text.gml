/// draw_sprite_text(_text, _x, _y, _spacing)
/// _text: El texto a dibujar
/// _x, _y: Posición donde empieza el texto
/// _spacing: Espacio entre caracteres

function draw_sprite_text(_text, _x, _y, _spacing) {
    var len = string_length(_text);
    var char, index;

    for (var i = 1; i <= len; i++) {
        char = string_lower(string_char_at(_text, i)); // Convierte a minúscula
        index = -1; // Índice predeterminado

        // Letras (a-z)
        if (ord(char) >= ord("a") && ord(char) <= ord("z")) {
            index = ord(char) - ord("a"); // Convierte "a" en 0, "b" en 1, etc.
        }
        // Números (0-9)
        else if (ord(char) >= ord("0") && ord(char) <= ord("9")) {
            index = 26 + (ord(char) - ord("1")); // Convierte "1" en 26, "2" en 27, ..., "0" en 35
            if (char == "0") index = 35; // "0" es la última subimagen
        }

        // Dibujar si hay un índice válido
        if (index >= 0) {
            draw_sprite(sFont_Orange, index, _x + (i - 1) * _spacing, _y);
        }
    }
}