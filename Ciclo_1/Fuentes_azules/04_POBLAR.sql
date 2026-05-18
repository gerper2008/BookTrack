---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarOK -> Ingreso de datos correctos
---------------------------------------------------------------------------------------------

-- Categoria
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT001', 'Ficcion', 'Narrativa imaginativa y mundos inventados');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT002', 'Historia', 'Relatos y analisis de eventos historicos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT003', 'Ciencia', 'Divulgacion cientifica y conocimiento empirico');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT004', 'Filosofia', 'Pensamiento critico y reflexion existencial');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT005', 'Poesia', 'Expresion literaria en verso y metafora');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT006', 'Biografia', 'Relatos de vida de personajes destacados');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT007', 'Infantil', 'Lecturas educativas y recreativas para ninos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT008', 'Terror', 'Narrativa de suspenso y miedo');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT009', 'Romance', 'Historias de amor y relaciones sentimentales');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT010', 'Aventura', 'Relatos de accion expediciones y peligro');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT011', 'Tecnologia', 'Libros sobre informatica y avances tecnologicos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT012', 'Arte', 'Expresion visual musica y cultura estetica');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT013', 'Psicologia', 'Estudio de la mente y comportamiento humano');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT014', 'Economia', 'Finanzas mercados y sistemas economicos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT015', 'Derecho', 'Normas juridicas y sistemas legales');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT016', 'Medicina', 'Salud anatomia y ciencias medicas');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT017', 'Religion', 'Espiritualidad tradiciones y textos sagrados');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT018', 'Sociologia', 'Estudio de la sociedad y sus estructuras');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT019', 'Matematicas', 'Calculo algebra y logica matematica');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT020', 'Linguistica', 'Estudio del lenguaje y la comunicacion');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT021', 'Politica', 'Sistemas de gobierno e ideologias politicas');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT022', 'Ecologia', 'Medioambiente sostenibilidad y naturaleza');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT023', 'Gastronomia', 'Cocina recetas y cultura culinaria');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT024', 'Viajes', 'Guias turisticas y relatos de exploracion');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT025', 'Autoayuda', 'Desarrollo personal y bienestar emocional');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT026', 'Fantasia', 'Mundos magicos criaturas y magia');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT027', 'Ciencia Ficcion', 'Tecnologia futura y mundos especulativos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT028', 'Teatro', 'Obras dramaticas y guiones escenicas');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT029', 'Arquitectura', 'Diseno construccion y espacios urbanos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT030', 'Educacion', 'Pedagogia y metodologias de ensenanza');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT031', 'Mitologia', 'Leyendas mitos y tradiciones culturales');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT032', 'Humor', 'Satira comedia y escritura humoristica');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT033', 'Ensayo', 'Reflexion argumentada sobre temas diversos');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT034', 'Deporte', 'Actividad fisica competicion y salud deportiva');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT035', 'Narrativa Historica', 'Ficcion ambientada en periodos historicos reales');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT036', 'Criminologia', 'Estudio del crimen y la conducta delictiva');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT037', 'Astronomia', 'Estudio del universo los planetas y las estrellas');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT038', 'Geopolitica', 'Relaciones internacionales y poder global');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT039', 'Comunicacion', 'Medios periodismo y teoria de la comunicacion');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT040', 'Fotografia', 'Tecnica artistica y narrativa visual fotografica');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT041', 'Musica', 'Historia teoria y practica musical');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT042', 'Cine', 'Historia analisis y critica cinematografica');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT043', 'Etica', 'Valores morales y principios de conducta');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT044', 'Urbanismo', 'Planificacion y desarrollo de ciudades');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT045', 'Antropologia', 'Estudio del ser humano y sus culturas');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT046', 'Literatura Clasica', 'Obras canonicas de la tradicion literaria universal');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT047', 'Novela Negra', 'Ficcion policial y thriller de crimen');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT048', 'Cuento', 'Narrativa breve de ficcion literaria');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT049', 'Genealogia', 'Historia familiar y registros de linajes');
INSERT INTO Categoria (id, nombre, descripcion) VALUES ('CAT050', 'Fisica', 'Leyes del universo materia energia y movimiento');

-- Editorial
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT001', 'contacto@alfaguara.com', '3001112233', 'Alfaguara', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT002', 'info@penguinlibros.com', '3002223344', 'Penguin Random House', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT003', 'ventas@paidos.com', '3003334455', 'Paidos', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT004', 'editorial@fce.com.mx', '3004445566', 'Fondo de Cultura Economica', 'Mexico');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT005', 'info@seix.barral.es', '3005556677', 'Seix Barral', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT006', 'contacto@anagrama.com', '3006667788', 'Anagrama', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT007', 'info@norma.com.co', '3007778899', 'Norma', 'Colombia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT008', 'editorial@planeta.com.co', '3008889900', 'Planeta', 'Colombia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT009', 'ventas@tusquets.com', '3009990011', 'Tusquets Editores', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT010', 'info@sigloXXI.com', '3010001122', 'Siglo XXI Editores', 'Mexico');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT011', 'prensa@debate.es', '3011112233', 'Debate', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT012', 'contacto@lumen.es', '3012223344', 'Lumen', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT013', 'editorial@salamandra.com', '3013334455', 'Salamandra', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT014', 'info@editoraambo.com', '3014445566', 'Emece Editores', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT015', 'contacto@visor.es', '3015556677', 'Visor Libros', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT016', 'info@circulo.com.co', '3016667788', 'Circulo de Lectores', 'Colombia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT017', 'ventas@temis.com.co', '3017778899', 'Temis', 'Colombia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT018', 'editorial@unam.mx', '3018889900', 'UNAM', 'Mexico');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT019', 'info@galimard.fr', '3019990011', 'Gallimard', 'Francia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT020', 'editorial@fischer.de', '3020001122', 'S Fischer Verlag', 'Alemania');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT021', 'contacto@feltrinelli.it', '3021112233', 'Feltrinelli', 'Italia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT022', 'info@vintage.co.uk', '3022223344', 'Vintage Books', 'Reino Unido');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT023', 'editorial@picador.com', '3023334455', 'Picador', 'Reino Unido');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT024', 'ventas@faber.co.uk', '3024445566', 'Faber and Faber', 'Reino Unido');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT025', 'info@scribner.com', '3025556677', 'Scribner', 'Estados Unidos');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT026', 'contacto@knopf.com', '3026667788', 'Alfred A Knopf', 'Estados Unidos');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT027', 'editorial@houghton.com', '3027778899', 'Houghton Mifflin', 'Estados Unidos');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT028', 'info@farrar.com', '3028889900', 'Farrar Straus and Giroux', 'Estados Unidos');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT029', 'ventas@shueisha.jp', '3029990011', 'Shueisha', 'Japon');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT030', 'editorial@harvest.com', '3030001122', 'Harvest Books', 'Estados Unidos');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT031', 'info@edaf.es', '3031112233', 'EDAF', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT032', 'contacto@grijalbo.com', '3032223344', 'Grijalbo', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT033', 'editorial@destino.es', '3033334455', 'Destino', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT034', 'info@punto.com.ar', '3034445566', 'Punto de Lectura', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT035', 'ventas@edhasa.com', '3035556677', 'Edhasa', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT036', 'contacto@losada.com.ar', '3036667788', 'Losada', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT037', 'editorial@sudamericana.com', '3037778899', 'Sudamericana', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT038', 'info@vergara.com.ar', '3038889900', 'Vergara Editores', 'Argentina');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT039', 'ventas@negroni.com.br', '3039990011', 'Companhia das Letras', 'Brasil');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT040', 'editorial@bertrand.pt', '3040001122', 'Bertrand Editora', 'Portugal');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT041', 'info@minuit.fr', '3041112233', 'Les Editions de Minuit', 'Francia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT042', 'contacto@seuil.fr', '3042223344', 'Editions du Seuil', 'Francia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT043', 'editorial@hanser.de', '3043334455', 'Carl Hanser Verlag', 'Alemania');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT044', 'info@mondadori.it', '3044445566', 'Mondadori', 'Italia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT045', 'ventas@rizzoli.it', '3045556677', 'Rizzoli', 'Italia');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT046', 'contacto@ediciones.uv.mx', '3046667788', 'Universidad Veracruzana', 'Mexico');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT047', 'editorial@colofon.com.mx', '3047778899', 'Coloofon', 'Mexico');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT048', 'info@espasa.com', '3048889900', 'Espasa', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT049', 'ventas@taurus.com', '3049990011', 'Taurus', 'Espana');
INSERT INTO Editorial (id, correo, telefono, nombre, pais) VALUES ('EDT050', 'contacto@aguilar.com', '3050001122', 'Aguilar', 'Espana');

-- Autor
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT001', 'Gabriel', 'Garcia Marquez', 'Masculino', 'Colombiana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT002', 'Isabel', 'Allende', 'Femenino', 'Chilena');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT003', 'Jorge Luis', 'Borges', 'Masculino', 'Argentina');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT004', 'Mario', 'Vargas Llosa', 'Masculino', 'Peruana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT005', 'Julio', 'Cortazar', 'Masculino', 'Argentina');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT006', 'Pablo', 'Neruda', 'Masculino', 'Chilena');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT007', 'Octavio', 'Paz', 'Masculino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT008', 'Laura', 'Esquivel', 'Femenino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT009', 'Carlos', 'Fuentes', 'Masculino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT010', 'Clarice', 'Lispector', 'Femenino', 'Brasilena');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT011', 'Franz', 'Kafka', 'Masculino', 'Checa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT012', 'Albert', 'Camus', 'Masculino', 'Francesa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT013', 'Virginia', 'Woolf', 'Femenino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT014', 'Ernest', 'Hemingway', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT015', 'Fyodor', 'Dostoevsky', 'Masculino', 'Rusa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT016', 'Leo', 'Tolstoy', 'Masculino', 'Rusa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT017', 'Haruki', 'Murakami', 'Masculino', 'Japonesa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT018', 'Chimamanda', 'Ngozi Adichie', 'Femenino', 'Nigeriana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT019', 'Umberto', 'Eco', 'Masculino', 'Italiana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT020', 'Milan', 'Kundera', 'Masculino', 'Checa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT021', 'Toni', 'Morrison', 'Femenino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT022', 'Gabriel', 'Zaid', 'Masculino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT023', 'Elena', 'Poniatowska', 'Femenino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT024', 'Eduardo', 'Galeano', 'Masculino', 'Uruguaya');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT025', 'Rosario', 'Castellanos', 'Femenino', 'Mexicana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT026', 'William', 'Faulkner', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT027', 'John', 'Steinbeck', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT028', 'Stephen', 'King', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT029', 'Agatha', 'Christie', 'Femenino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT030', 'Arthur', 'Conan Doyle', 'Masculino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT031', 'George', 'Orwell', 'Masculino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT032', 'Aldous', 'Huxley', 'Masculino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT033', 'Ray', 'Bradbury', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT034', 'Philip K', 'Dick', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT035', 'Isaac', 'Asimov', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT036', 'Carl', 'Sagan', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT037', 'Richard', 'Feynman', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT038', 'Yuval Noah', 'Harari', 'Masculino', 'Israeli');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT039', 'Nietzsche', 'Friedrich', 'Masculino', 'Alemana');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT040', 'Platon', 'Aristoclides', 'Masculino', 'Griega');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT041', 'Sigmund', 'Freud', 'Masculino', 'Austriaca');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT042', 'Carl', 'Jung', 'Masculino', 'Suiza');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT043', 'Jean Paul', 'Sartre', 'Masculino', 'Francesa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT044', 'Simone', 'de Beauvoir', 'Femenino', 'Francesa');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT045', 'Jhumpa', 'Lahiri', 'Femenino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT046', 'Kazuo', 'Ishiguro', 'Masculino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT047', 'Salman', 'Rushdie', 'Masculino', 'Britanica');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT048', 'Cormac', 'McCarthy', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT049', 'Don', 'DeLillo', 'Masculino', 'Estadounidense');
INSERT INTO Autor (id, nombre, apellidos, genero, nacionalidad) VALUES ('AUT050', 'Sor Juana', 'Ines de la Cruz', 'Femenino', 'Mexicana');

-- Proveedor
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV001', 'carlos.mora@distriblibros.com', 'Carlos', 'Mora Suarez', 'Distrib Libros', '3101112233');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV002', 'ana.perez@librerias.com', 'Ana', 'Perez Valdez', 'Libreria Cosmos', '3112223344');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV003', 'mario.ruiz@ediciones.com', 'Mario', 'Ruiz Heredia', 'Ediciones Sur', '3123334455');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV004', 'lucia.gomez@bookcenter.com', 'Lucia', 'Gomez Arias', 'Book Center', '3134445566');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV005', 'juan.castillo@lectura.com', 'Juan', 'Castillo Pena', 'Lecturas del Sur', '3145556677');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV006', 'rosa.medina@papelibros.com', 'Rosa', 'Medina Torres', 'Papelibros', '3156667788');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV007', 'pedro.silva@importlibros.com', 'Pedro', 'Silva Lara', 'Import Libros', '3167778899');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV008', 'marta.vega@textos.com', 'Marta', 'Vega Quintero', 'Textos y Mas', '3178889900');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV009', 'alberto.diaz@cultura.com', 'Alberto', 'Diaz Moreno', 'Cultura Viva', '3189990011');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV010', 'elena.rojas@mundolibros.com', 'Elena', 'Rojas Cano', 'Mundo Libros', '3190001122');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV011', 'david.vargas@editbooks.com', 'David', 'Vargas Blanco', 'Edit Books', '3101112234');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV012', 'paula.ospina@palabras.com', 'Paula', 'Ospina Reyes', 'Palabras Vivas', '3112223345');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV013', 'marcos.leon@novedad.com', 'Marcos', 'Leon Fuentes', 'Novedades Editoriales', '3123334456');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV014', 'isabel.arango@clasicos.com', 'Isabel', 'Arango Mena', 'Clasicos del Mundo', '3134445567');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV015', 'hugo.correa@distribuciones.com', 'Hugo', 'Correa Jimenez', 'Distribuciones BC', '3145556678');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV016', 'nathalia.rios@letras.com', 'Nathalia', 'Rios Uribe', 'Letras y Arte', '3156667789');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV017', 'andres.parra@libroimport.com', 'Andres', 'Parra Agudelo', 'Libro Import', '3167778900');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV018', 'gloria.muñoz@grafos.com', 'Gloria', 'Munoz Ceron', 'Grafos Editorial', '3178889901');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV019', 'felix.castro@lecturasplus.com', 'Felix', 'Castro Andrade', 'Lecturas Plus', '3189990012');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV020', 'cecilia.bermudez@palabramayor.com', 'Cecilia', 'Bermudez Orozco', 'Palabra Mayor', '3190001123');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV021', 'tomas.henao@libreriacol.com', 'Tomas', 'Henao Velez', 'Libreria Colombia', '3101112235');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV022', 'viviana.loaiza@selecta.com', 'Viviana', 'Loaiza Franco', 'Selecta Libros', '3112223346');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV023', 'raul.carvajal@textosla.com', 'Raul', 'Carvajal Isaza', 'Textos Latinoam', '3123334457');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV024', 'adriana.zapata@impresoslibros.com', 'Adriana', 'Zapata Saldarriaga', 'Impresos Libros', '3134445568');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV025', 'samuel.garzon@bibliocentro.com', 'Samuel', 'Garzon Duque', 'Biblio Centro', '3145556679');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV026', 'virginia.acosta@legados.com', 'Virginia', 'Acosta Largo', 'Legados Editoriales', '3156667790');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV027', 'ernesto.bedoya@editorial.com', 'Ernesto', 'Bedoya Cifuentes', 'Editorial Progreso', '3167778901');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV028', 'helena.echavarria@fueradelibros.com', 'Helena', 'Echavarria Hoyos', 'Fuera de Serie', '3178889902');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV029', 'ignacio.mejia@paginamayor.com', 'Ignacio', 'Mejia Acevedo', 'Pagina Mayor', '3189990013');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV030', 'sara.palacio@librointl.com', 'Sara', 'Palacio Barrera', 'Libro Internacional', '3190001124');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV031', 'jorge.cano@editorialcentral.com', 'Jorge', 'Cano Espinoza', 'Editorial Central', '3101112236');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV032', 'lina.trujillo@librosymas.com', 'Lina', 'Trujillo Rendon', 'Libros y Mas', '3112223347');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV033', 'rodrigo.florez@textomundo.com', 'Rodrigo', 'Florez Montoya', 'Texto Mundo', '3123334458');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV034', 'claudia.naranjo@galeria.com', 'Claudia', 'Naranjo Bernal', 'Galeria Letras', '3134445569');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV035', 'sebastian.arenas@culturaledit.com', 'Sebastian', 'Arenas Botero', 'Cultural Edit', '3145556680');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV036', 'juliana.marin@paginas.com', 'Juliana', 'Marin Cardona', 'Paginas Nuevas', '3156667791');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV037', 'nicolas.hurtado@saber.com', 'Nicolas', 'Hurtado Giraldo', 'Saber Libros', '3167778902');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV038', 'beatriz.muñoz@distriblat.com', 'Beatriz', 'Munoz Velez', 'Distrib Latina', '3178889903');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV039', 'carlos.zuluaga@maspalabras.com', 'Carlos', 'Zuluaga Cadena', 'Mas Palabras', '3189990014');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV040', 'daniela.guerrero@editcentro.com', 'Daniela', 'Guerrero Perea', 'Edit Centro', '3190001125');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV041', 'gabriel.ibarra@tintafina.com', 'Gabriel', 'Ibarra Penagos', 'Tinta Fina', '3101112237');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV042', 'marcela.velasquez@librototal.com', 'Marcela', 'Velasquez Urrego', 'Libro Total', '3112223348');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV043', 'fernando.rios@culturasur.com', 'Fernando', 'Rios Osorio', 'Cultura Sur', '3123334459');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV044', 'tatiana.salazar@hojas.com', 'Tatiana', 'Salazar Velez', 'Hojas y Paginas', '3134445570');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV045', 'alberto.montoya@librosalternativos.com', 'Alberto', 'Montoya Serna', 'Libros Alternativos', '3145556681');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV046', 'pilar.ramirez@editregion.com', 'Pilar', 'Ramirez Galvis', 'Edit Region', '3156667792');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV047', 'esteban.soto@palabrasgrandes.com', 'Esteban', 'Soto Quintana', 'Palabras Grandes', '3167778903');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV048', 'angela.reyes@distribletras.com', 'Angela', 'Reyes Cano', 'Distrib Letras', '3178889904');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV049', 'hector.cordoba@libroslatam.com', 'Hector', 'Cordoba Arboleda', 'Libros Latam', '3189990015');
INSERT INTO Proveedor (id, correo, nombre, apellidos, empresa, telefono) VALUES ('PRV050', 'emma.delgado@editnorte.com', 'Emma', 'Delgado Navarrete', 'Edit Norte', '3190001126');

-- Libro
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB001', 'Cien Anos de Soledad', TO_DATE('05/06/1967', 'DD/MM/YYYY'), 'Espanol', 'Saga epica de la familia Buendia en Macondo', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB002', 'La Casa de los Espiritus', TO_DATE('01/01/1982', 'DD/MM/YYYY'), 'Espanol', 'Saga familiar de los Trueba en Chile', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB003', 'Ficciones', TO_DATE('01/01/1944', 'DD/MM/YYYY'), 'Espanol', 'Cuentos filosoficos y laberinticos de Borges', 'CAT048');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB004', 'La Ciudad y los Perros', TO_DATE('01/01/1963', 'DD/MM/YYYY'), 'Espanol', 'Novela de denuncia sobre una academia militar', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB005', 'Rayuela', TO_DATE('28/06/1963', 'DD/MM/YYYY'), 'Espanol', 'Novela experimental sobre la busqueda existencial', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB006', 'Veinte Poemas de Amor', TO_DATE('01/01/1924', 'DD/MM/YYYY'), 'Espanol', 'Coleccion de poemas liricos y amorosos', 'CAT005');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB007', 'El Laberinto de la Soledad', TO_DATE('01/01/1950', 'DD/MM/YYYY'), 'Espanol', 'Ensayo sobre la identidad del mexicano', 'CAT033');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB008', 'Como Agua para Chocolate', TO_DATE('01/01/1989', 'DD/MM/YYYY'), 'Espanol', 'Novela sobre amor reprimido y recetas de cocina', 'CAT009');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB009', 'La Muerte de Artemio Cruz', TO_DATE('01/01/1962', 'DD/MM/YYYY'), 'Espanol', 'Reflexion sobre el poder y la traicion en Mexico', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB010', 'La Pasion segun GH', TO_DATE('01/01/1964', 'DD/MM/YYYY'), 'Portugues', 'Novela introspectiva de alto vuelo filosofico', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB011', 'La Metamorfosis', TO_DATE('01/01/1915', 'DD/MM/YYYY'), 'Espanol', 'Relato de la transformacion de Gregor Samsa', 'CAT048');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB012', 'El Extranjero', TO_DATE('01/01/1942', 'DD/MM/YYYY'), 'Espanol', 'Novela existencialista sobre la absurdidad de la vida', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB013', 'Las Olas', TO_DATE('08/10/1931', 'DD/MM/YYYY'), 'Espanol', 'Novela experimental de voces y conciencias', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB014', 'El Viejo y el Mar', TO_DATE('01/09/1952', 'DD/MM/YYYY'), 'Espanol', 'Historia de lucha y resistencia de un pescador anciano', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB015', 'Crimen y Castigo', TO_DATE('01/01/1866', 'DD/MM/YYYY'), 'Espanol', 'Novela psicologica sobre culpa y redencion', 'CAT013');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB016', 'Anna Karenina', TO_DATE('01/01/1877', 'DD/MM/YYYY'), 'Espanol', 'Tragedia de amor en la sociedad rusa del siglo XIX', 'CAT009');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB017', 'Kafka en la Orilla', TO_DATE('01/01/2002', 'DD/MM/YYYY'), 'Japones', 'Novela de viaje interior y misterio surrealista', 'CAT026');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB018', 'Americanah', TO_DATE('14/05/2013', 'DD/MM/YYYY'), 'Ingles', 'Novela sobre raza identidad e inmigracion en el mundo globalizado', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB019', 'El Nombre de la Rosa', TO_DATE('01/01/1980', 'DD/MM/YYYY'), 'Espanol', 'Novela historica en un monasterio medieval', 'CAT035');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB020', 'La Insoportable Levedad del Ser', TO_DATE('01/01/1984', 'DD/MM/YYYY'), 'Espanol', 'Novela filosofica sobre el amor la libertad y el destino', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB021', 'Beloved', TO_DATE('16/09/1987', 'DD/MM/YYYY'), 'Ingles', 'Novela sobre la esclavitud y sus consecuencias psicologicas', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB022', 'Memoria del Fuego', TO_DATE('01/01/1982', 'DD/MM/YYYY'), 'Espanol', 'Trilogia sobre la historia de America Latina', 'CAT002');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB023', 'Las Venas Abiertas de America Latina', TO_DATE('01/01/1971', 'DD/MM/YYYY'), 'Espanol', 'Ensayo historico sobre la explotacion de America Latina', 'CAT002');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB024', 'Sapiens', TO_DATE('01/06/2011', 'DD/MM/YYYY'), 'Espanol', 'Historia breve de la humanidad desde la prehistoria', 'CAT002');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB025', 'El Cosmos', TO_DATE('01/10/1980', 'DD/MM/YYYY'), 'Espanol', 'Viaje cientifico por el universo y la astronomia', 'CAT037');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB026', 'Seis Piezas Faciles', TO_DATE('01/01/1994', 'DD/MM/YYYY'), 'Espanol', 'Introduccion a la fisica para el publico general', 'CAT050');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB027', 'Homo Deus', TO_DATE('01/01/2015', 'DD/MM/YYYY'), 'Espanol', 'Reflexion sobre el futuro de la humanidad y la tecnologia', 'CAT003');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB028', 'Mas alla del Bien y del Mal', TO_DATE('01/01/1886', 'DD/MM/YYYY'), 'Espanol', 'Critica de la moral convencional por Nietzsche', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB029', 'La Republica', TO_DATE('01/01/0380', 'DD/MM/YYYY'), 'Espanol', 'Dialogo de Platon sobre justicia y politica', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB030', 'La Interpretacion de los Suenos', TO_DATE('01/11/1899', 'DD/MM/YYYY'), 'Espanol', 'Obra fundadora del psicoanalisis de Freud', 'CAT013');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB031', 'Arquetipos e Inconsciente Colectivo', TO_DATE('01/01/1959', 'DD/MM/YYYY'), 'Espanol', 'Fundamentos de la psicologia analitica de Jung', 'CAT013');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB032', 'El Ser y la Nada', TO_DATE('01/01/1943', 'DD/MM/YYYY'), 'Espanol', 'Obra magistral del existencialismo sartreano', 'CAT004');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB033', 'El Segundo Sexo', TO_DATE('01/01/1949', 'DD/MM/YYYY'), 'Espanol', 'Ensayo fundacional del feminismo contemporaneo', 'CAT033');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB034', 'Interprete de Emociones', TO_DATE('18/08/1999', 'DD/MM/YYYY'), 'Espanol', 'Cuentos sobre inmigrantes indios en Estados Unidos', 'CAT048');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB035', 'Lo que Queda del Dia', TO_DATE('01/05/1989', 'DD/MM/YYYY'), 'Espanol', 'Novela sobre la dignidad y el servicio en Inglaterra', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB036', 'Hijos de la Medianoche', TO_DATE('12/04/1981', 'DD/MM/YYYY'), 'Espanol', 'Novela epica sobre la independencia de India', 'CAT035');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB037', 'La Carretera', TO_DATE('26/09/2006', 'DD/MM/YYYY'), 'Espanol', 'Novela postapoocaliptica de padre e hijo', 'CAT027');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB038', 'Ruido de Fondo', TO_DATE('10/01/1985', 'DD/MM/YYYY'), 'Espanol', 'Novela posmoderna sobre la cultura del consumo', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB039', 'Rebelion en la Granja', TO_DATE('17/08/1945', 'DD/MM/YYYY'), 'Espanol', 'Fabula politica sobre el totalitarismo', 'CAT021');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB040', 'Un Mundo Feliz', TO_DATE('01/01/1932', 'DD/MM/YYYY'), 'Espanol', 'Distopia sobre el control social y la felicidad artificial', 'CAT027');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB041', 'Cronicas Marcianas', TO_DATE('01/05/1950', 'DD/MM/YYYY'), 'Espanol', 'Cuentos sobre la colonizacion de Marte', 'CAT027');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB042', 'Los Suenos que Suenan los Androides', TO_DATE('01/01/1968', 'DD/MM/YYYY'), 'Espanol', 'Novela sobre la identidad y los androodes', 'CAT027');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB043', 'Yo Robot', TO_DATE('02/12/1950', 'DD/MM/YYYY'), 'Espanol', 'Cuentos sobre las tres leyes de la robotica', 'CAT027');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB044', 'El Asesinato de Roger Ackroyd', TO_DATE('13/06/1926', 'DD/MM/YYYY'), 'Espanol', 'Clasico del genero policial de Agatha Christie', 'CAT047');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB045', 'Estudio en Escarlata', TO_DATE('01/11/1887', 'DD/MM/YYYY'), 'Espanol', 'Primera aparicion de Sherlock Holmes', 'CAT047');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB046', 'El Resplandor', TO_DATE('28/01/1977', 'DD/MM/YYYY'), 'Espanol', 'Novela de terror psicologico en un hotel aislado', 'CAT008');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB047', 'Redondillas', TO_DATE('01/01/1689', 'DD/MM/YYYY'), 'Espanol', 'Poemas de Sor Juana Ines de la Cruz', 'CAT005');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB048', 'Las Uvas de la Ira', TO_DATE('14/04/1939', 'DD/MM/YYYY'), 'Espanol', 'Novela sobre la migracion en la Gran Depresion', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB049', 'El Sonido y la Furia', TO_DATE('07/10/1929', 'DD/MM/YYYY'), 'Espanol', 'Novela modernista sobre la decadencia de una familia suredna', 'CAT001');
INSERT INTO Libro (id, titulo, fecha_publicacion, idioma, descripcion, idCategoria) VALUES ('LIB050', 'Primer Amor y otros Cuentos', TO_DATE('01/01/1958', 'DD/MM/YYYY'), 'Espanol', 'Cuentos de Beckett sobre la soledad y el absurdo', 'CAT048');

-- Libro_Autor
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB001', 'AUT001');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB002', 'AUT002');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB003', 'AUT003');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB004', 'AUT004');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB005', 'AUT005');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB006', 'AUT006');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB007', 'AUT007');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB008', 'AUT008');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB009', 'AUT009');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB010', 'AUT010');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB011', 'AUT011');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB012', 'AUT012');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB013', 'AUT013');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB014', 'AUT014');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB015', 'AUT015');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB016', 'AUT016');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB017', 'AUT017');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB018', 'AUT018');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB019', 'AUT019');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB020', 'AUT020');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB021', 'AUT021');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB022', 'AUT024');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB023', 'AUT024');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB024', 'AUT038');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB025', 'AUT036');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB026', 'AUT037');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB027', 'AUT038');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB028', 'AUT039');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB029', 'AUT040');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB030', 'AUT041');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB031', 'AUT042');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB032', 'AUT043');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB033', 'AUT044');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB034', 'AUT045');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB035', 'AUT046');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB036', 'AUT047');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB037', 'AUT048');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB038', 'AUT049');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB039', 'AUT031');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB040', 'AUT032');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB041', 'AUT033');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB042', 'AUT034');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB043', 'AUT035');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB044', 'AUT029');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB045', 'AUT030');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB046', 'AUT028');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB047', 'AUT050');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB048', 'AUT027');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB049', 'AUT026');
INSERT INTO Libro_Autor (idLibro, idAutor) VALUES ('LIB050', 'AUT003');

-- Edicion (id, año, paginas, idLibro, idEditorial)
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI001', TO_DATE('01/01/2010', 'DD/MM/YYYY'), 471, 'LIB001', 'EDT001');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI002', TO_DATE('01/01/2015', 'DD/MM/YYYY'), 433, 'LIB002', 'EDT002');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI003', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 209, 'LIB003', 'EDT006');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI004', TO_DATE('01/01/2012', 'DD/MM/YYYY'), 348, 'LIB004', 'EDT002');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI005', TO_DATE('01/01/2011', 'DD/MM/YYYY'), 635, 'LIB005', 'EDT001');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI006', TO_DATE('01/01/2014', 'DD/MM/YYYY'), 108, 'LIB006', 'EDT015');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI007', TO_DATE('01/01/2009', 'DD/MM/YYYY'), 261, 'LIB007', 'EDT004');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI008', TO_DATE('01/01/2013', 'DD/MM/YYYY'), 256, 'LIB008', 'EDT007');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI009', TO_DATE('01/01/2016', 'DD/MM/YYYY'), 345, 'LIB009', 'EDT004');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI010', TO_DATE('01/01/2018', 'DD/MM/YYYY'), 187, 'LIB010', 'EDT039');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI011', TO_DATE('01/01/2007', 'DD/MM/YYYY'), 128, 'LIB011', 'EDT003');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI012', TO_DATE('01/01/2010', 'DD/MM/YYYY'), 159, 'LIB012', 'EDT012');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI013', TO_DATE('01/01/2017', 'DD/MM/YYYY'), 223, 'LIB013', 'EDT022');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI014', TO_DATE('01/01/2005', 'DD/MM/YYYY'), 128, 'LIB014', 'EDT025');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI015', TO_DATE('01/01/2014', 'DD/MM/YYYY'), 671, 'LIB015', 'EDT003');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI016', TO_DATE('01/01/2016', 'DD/MM/YYYY'), 879, 'LIB016', 'EDT003');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI017', TO_DATE('01/01/2019', 'DD/MM/YYYY'), 615, 'LIB017', 'EDT009');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI018', TO_DATE('01/01/2014', 'DD/MM/YYYY'), 477, 'LIB018', 'EDT026');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI019', TO_DATE('01/01/2013', 'DD/MM/YYYY'), 508, 'LIB019', 'EDT019');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI020', TO_DATE('01/01/2012', 'DD/MM/YYYY'), 316, 'LIB020', 'EDT006');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI021', TO_DATE('01/01/2015', 'DD/MM/YYYY'), 321, 'LIB021', 'EDT026');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI022', TO_DATE('01/01/2011', 'DD/MM/YYYY'), 891, 'LIB022', 'EDT037');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI023', TO_DATE('01/01/2010', 'DD/MM/YYYY'), 379, 'LIB023', 'EDT010');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI024', TO_DATE('01/01/2018', 'DD/MM/YYYY'), 496, 'LIB024', 'EDT002');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI025', TO_DATE('01/01/2009', 'DD/MM/YYYY'), 365, 'LIB025', 'EDT011');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI026', TO_DATE('01/01/2017', 'DD/MM/YYYY'), 165, 'LIB026', 'EDT027');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI027', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 464, 'LIB027', 'EDT002');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI028', TO_DATE('01/01/2008', 'DD/MM/YYYY'), 267, 'LIB028', 'EDT049');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI029', TO_DATE('01/01/2006', 'DD/MM/YYYY'), 510, 'LIB029', 'EDT004');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI030', TO_DATE('01/01/2015', 'DD/MM/YYYY'), 582, 'LIB030', 'EDT003');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI031', TO_DATE('01/01/2016', 'DD/MM/YYYY'), 358, 'LIB031', 'EDT003');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI032', TO_DATE('01/01/2013', 'DD/MM/YYYY'), 771, 'LIB032', 'EDT041');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI033', TO_DATE('01/01/2012', 'DD/MM/YYYY'), 581, 'LIB033', 'EDT042');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI034', TO_DATE('01/01/2017', 'DD/MM/YYYY'), 216, 'LIB034', 'EDT028');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI035', TO_DATE('01/01/2018', 'DD/MM/YYYY'), 268, 'LIB035', 'EDT022');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI036', TO_DATE('01/01/2011', 'DD/MM/YYYY'), 647, 'LIB036', 'EDT023');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI037', TO_DATE('01/01/2019', 'DD/MM/YYYY'), 311, 'LIB037', 'EDT025');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI038', TO_DATE('01/01/2014', 'DD/MM/YYYY'), 342, 'LIB038', 'EDT025');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI039', TO_DATE('01/01/2010', 'DD/MM/YYYY'), 152, 'LIB039', 'EDT022');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI040', TO_DATE('01/01/2013', 'DD/MM/YYYY'), 269, 'LIB040', 'EDT022');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI041', TO_DATE('01/01/2016', 'DD/MM/YYYY'), 256, 'LIB041', 'EDT030');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI042', TO_DATE('01/01/2015', 'DD/MM/YYYY'), 244, 'LIB042', 'EDT030');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI043', TO_DATE('01/01/2017', 'DD/MM/YYYY'), 253, 'LIB043', 'EDT030');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI044', TO_DATE('01/01/2014', 'DD/MM/YYYY'), 312, 'LIB044', 'EDT005');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI045', TO_DATE('01/01/2012', 'DD/MM/YYYY'), 288, 'LIB045', 'EDT005');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI046', TO_DATE('01/01/2020', 'DD/MM/YYYY'), 512, 'LIB046', 'EDT008');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI047', TO_DATE('01/01/2018', 'DD/MM/YYYY'), 136, 'LIB047', 'EDT018');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI048', TO_DATE('01/01/2011', 'DD/MM/YYYY'), 455, 'LIB048', 'EDT027');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI049', TO_DATE('01/01/2013', 'DD/MM/YYYY'), 336, 'LIB049', 'EDT028');
INSERT INTO Edicion (id, anio, paginas, idLibro, idEditorial) VALUES ('EDI050', TO_DATE('01/01/2021', 'DD/MM/YYYY'), 189, 'LIB050', 'EDT006');

-- Ejemplar (id, estadoFisico, disponibilidad, localizacion, fecha_adquisicion, idEdicion)
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM001', 'Bueno', 1, 'Sala A', TO_DATE('15/03/2021', 'DD/MM/YYYY'), 'EDI001');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM002', 'Nuevo', 1, 'Sala B', TO_DATE('20/04/2022', 'DD/MM/YYYY'), 'EDI001');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM003', 'Bueno', 1, 'Sala A', TO_DATE('10/06/2020', 'DD/MM/YYYY'), 'EDI002');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM004', 'Desgastado', 0, 'Sala C', TO_DATE('05/01/2019', 'DD/MM/YYYY'), 'EDI002');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM005', 'Bueno', 1, 'Sala A', TO_DATE('22/07/2021', 'DD/MM/YYYY'), 'EDI003');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM006', 'Nuevo', 1, 'Sala D', TO_DATE('18/09/2022', 'DD/MM/YYYY'), 'EDI004');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM007', 'Restaurado', 0, 'Sala B', TO_DATE('30/11/2018', 'DD/MM/YYYY'), 'EDI005');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM008', 'Bueno', 1, 'Sala A', TO_DATE('14/02/2023', 'DD/MM/YYYY'), 'EDI006');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM009', 'Nuevo', 1, 'Sala C', TO_DATE('03/05/2022', 'DD/MM/YYYY'), 'EDI007');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM010', 'Desgastado', 0, 'Sala B', TO_DATE('25/08/2017', 'DD/MM/YYYY'), 'EDI008');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM011', 'Bueno', 1, 'Sala A', TO_DATE('11/01/2023', 'DD/MM/YYYY'), 'EDI009');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM012', 'Nuevo', 1, 'Sala D', TO_DATE('07/03/2024', 'DD/MM/YYYY'), 'EDI010');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM013', 'Bueno', 1, 'Sala A', TO_DATE('19/06/2021', 'DD/MM/YYYY'), 'EDI011');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM014', 'Desgastado', 0, 'Sala C', TO_DATE('12/10/2016', 'DD/MM/YYYY'), 'EDI012');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM015', 'Restaurado', 0, 'Sala B', TO_DATE('28/02/2019', 'DD/MM/YYYY'), 'EDI013');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM016', 'Bueno', 1, 'Sala A', TO_DATE('04/07/2022', 'DD/MM/YYYY'), 'EDI014');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM017', 'Nuevo', 1, 'Sala D', TO_DATE('16/11/2023', 'DD/MM/YYYY'), 'EDI015');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM018', 'Bueno', 1, 'Sala A', TO_DATE('09/04/2021', 'DD/MM/YYYY'), 'EDI016');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM019', 'Desgastado', 0, 'Sala C', TO_DATE('23/08/2018', 'DD/MM/YYYY'), 'EDI017');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM020', 'Nuevo', 1, 'Sala B', TO_DATE('01/12/2022', 'DD/MM/YYYY'), 'EDI018');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM021', 'Bueno', 1, 'Sala A', TO_DATE('17/05/2020', 'DD/MM/YYYY'), 'EDI019');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM022', 'Restaurado', 0, 'Sala D', TO_DATE('06/09/2017', 'DD/MM/YYYY'), 'EDI020');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM023', 'Nuevo', 1, 'Sala B', TO_DATE('29/01/2024', 'DD/MM/YYYY'), 'EDI021');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM024', 'Bueno', 1, 'Sala A', TO_DATE('13/06/2021', 'DD/MM/YYYY'), 'EDI022');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM025', 'Desgastado', 0, 'Sala C', TO_DATE('07/10/2015', 'DD/MM/YYYY'), 'EDI023');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM026', 'Nuevo', 1, 'Sala D', TO_DATE('22/03/2023', 'DD/MM/YYYY'), 'EDI024');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM027', 'Bueno', 1, 'Sala A', TO_DATE('14/07/2022', 'DD/MM/YYYY'), 'EDI025');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM028', 'Restaurado', 0, 'Sala B', TO_DATE('05/11/2018', 'DD/MM/YYYY'), 'EDI026');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM029', 'Nuevo', 1, 'Sala C', TO_DATE('18/04/2024', 'DD/MM/YYYY'), 'EDI027');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM030', 'Bueno', 1, 'Sala A', TO_DATE('02/09/2021', 'DD/MM/YYYY'), 'EDI028');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM031', 'Desgastado', 0, 'Sala D', TO_DATE('26/01/2016', 'DD/MM/YYYY'), 'EDI029');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM032', 'Bueno', 1, 'Sala B', TO_DATE('10/05/2023', 'DD/MM/YYYY'), 'EDI030');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM033', 'Nuevo', 1, 'Sala A', TO_DATE('24/08/2022', 'DD/MM/YYYY'), 'EDI031');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM034', 'Bueno', 1, 'Sala C', TO_DATE('08/12/2020', 'DD/MM/YYYY'), 'EDI032');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM035', 'Restaurado', 0, 'Sala D', TO_DATE('19/03/2017', 'DD/MM/YYYY'), 'EDI033');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM036', 'Nuevo', 1, 'Sala A', TO_DATE('31/07/2023', 'DD/MM/YYYY'), 'EDI034');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM037', 'Bueno', 1, 'Sala B', TO_DATE('15/11/2021', 'DD/MM/YYYY'), 'EDI035');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM038', 'Desgastado', 0, 'Sala C', TO_DATE('03/04/2014', 'DD/MM/YYYY'), 'EDI036');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM039', 'Nuevo', 1, 'Sala D', TO_DATE('27/08/2024', 'DD/MM/YYYY'), 'EDI037');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM040', 'Bueno', 1, 'Sala A', TO_DATE('12/01/2022', 'DD/MM/YYYY'), 'EDI038');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM041', 'Restaurado', 0, 'Sala B', TO_DATE('06/05/2016', 'DD/MM/YYYY'), 'EDI039');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM042', 'Nuevo', 1, 'Sala C', TO_DATE('20/09/2023', 'DD/MM/YYYY'), 'EDI040');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM043', 'Bueno', 1, 'Sala A', TO_DATE('04/02/2022', 'DD/MM/YYYY'), 'EDI041');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM044', 'Desgastado', 0, 'Sala D', TO_DATE('18/06/2019', 'DD/MM/YYYY'), 'EDI042');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM045', 'Bueno', 1, 'Sala B', TO_DATE('09/10/2021', 'DD/MM/YYYY'), 'EDI043');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM046', 'Nuevo', 1, 'Sala A', TO_DATE('23/03/2024', 'DD/MM/YYYY'), 'EDI044');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM047', 'Restaurado', 0, 'Sala C', TO_DATE('17/07/2018', 'DD/MM/YYYY'), 'EDI045');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM048', 'Bueno', 1, 'Sala D', TO_DATE('11/11/2022', 'DD/MM/YYYY'), 'EDI046');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM049', 'Nuevo', 1, 'Sala A', TO_DATE('25/04/2023', 'DD/MM/YYYY'), 'EDI047');
INSERT INTO Ejemplar (id, estadoFisico, disponibilidad, localizacion, fechaAdquisicion, idEdicion) VALUES ('EJM050', 'Bueno', 1, 'Sala B', TO_DATE('08/08/2021', 'DD/MM/YYYY'), 'EDI048');

-- Usuario
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR001', 'admin.bogota@biblioteca.co', 'Administrador', 'Andres', 'Moreno Castillo', '3101234567');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR002', 'admin.medellin@biblioteca.co', 'Administrador', 'Catalina', 'Rios Herrera', '3202345678');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR003', 'biblio.norte@biblioteca.co', 'Bibliotecario', 'Jorge', 'Pedraza Lozano', '3053456789');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR004', 'biblio.sur@biblioteca.co', 'Bibliotecario', 'Mariana', 'Vega Suarez', '3124567890');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR005', 'lector.uno@correo.co', 'Lector', 'Pedro', 'Sanchez Ruiz', '3175678901');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR006', 'lector.dos@correo.co', 'Lector', 'Luisa', 'Fernandez Diaz', '3006789012');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR007', 'lector.tres@correo.co', 'Lector', 'Ricardo', 'Gomez Pena', '3117890123');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR008', 'lector.cuatro@correo.co', 'Lector', 'Valentina', 'Torres Mejia', '3148901234');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR009', 'lector.cinco@correo.co', 'Lector', 'Diego', 'Ramirez Ospina', '3159012345');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR010', 'lector.seis@correo.co', 'Lector', 'Natalia', 'Jimenez Vargas', '3160123456');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR011', 'biblio.este@biblioteca.co', 'Bibliotecario', 'Felipe', 'Cardona Arango', '3001234560');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR012', 'biblio.oeste@biblioteca.co', 'Bibliotecario', 'Sandra', 'Molina Cano', '3012345601');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR013', 'lector.siete@correo.co', 'Lector', 'Camilo', 'Parra Acosta', '3023456712');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR014', 'lector.ocho@correo.co', 'Lector', 'Adriana', 'Bernal Duran', '3034567823');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR015', 'lector.nueve@correo.co', 'Lector', 'Sebastian', 'Varela Montoya', '3045678934');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR016', 'lector.diez@correo.co', 'Lector', 'Paola', 'Gutierrez Rios', '3056780045');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR017', 'lector.once@correo.co', 'Lector', 'Juan', 'Escobar Blanco', '3067891156');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR018', 'lector.doce@correo.co', 'Lector', 'Monica', 'Castro Velez', '3078902267');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR019', 'lector.trece@correo.co', 'Lector', 'Andres', 'Zapata Ceron', '3089013378');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR020', 'lector.catorce@correo.co', 'Lector', 'Diana', 'Salinas Pinzon', '3090124489');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR021', 'admin.cali@biblioteca.co', 'Administrador', 'Alejandro', 'Mora Quintero', '3101235590');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR022', 'biblio.central@biblioteca.co', 'Bibliotecario', 'Gloria', 'Hurtado Palacios', '3112346601');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR023', 'lector.quince@correo.co', 'Lector', 'Esteban', 'Londono Silva', '3123457712');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR024', 'lector.dieciseis@correo.co', 'Lector', 'Claudia', 'Navarro Trujillo', '3134568823');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR025', 'lector.diecisiete@correo.co', 'Lector', 'Oscar', 'Reyes Florez', '3145679934');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR026', 'lector.dieciocho@correo.co', 'Lector', 'Angela', 'Cruz Maldonado', '3156780045');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR027', 'lector.diecinueve@correo.co', 'Lector', 'Ivan', 'Rojas Medina', '3167891156');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR028', 'lector.veinte@correo.co', 'Lector', 'Carolina', 'Aguilar Munoz', '3178902267');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR029', 'lector.veintiuno@correo.co', 'Lector', 'Mauricio', 'Delgado Serrano', '3189013378');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR030', 'lector.veintidos@correo.co', 'Lector', 'Lina', 'Perez Correa', '3190124489');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR031', 'lector.veintitres@correo.co', 'Lector', 'Nicolas', 'Alvarez Guerrero', '3001235590');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR032', 'lector.veinticuatro@correo.co', 'Lector', 'Marcela', 'Bermudez Soto', '3012346601');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR033', 'lector.veinticinco@correo.co', 'Lector', 'Hernan', 'Correa Ibarra', '3023457712');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR034', 'biblio.infantil@biblioteca.co', 'Bibliotecario', 'Patricia', 'Ortiz Fuentes', '3034568823');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR035', 'lector.veintiseis@correo.co', 'Lector', 'Rodrigo', 'Murillo Pedrosa', '3045679934');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR036', 'lector.veintisiete@correo.co', 'Lector', 'Tatiana', 'Nieto Lara', '3056780145');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR037', 'lector.veintiocho@correo.co', 'Lector', 'Wilson', 'Quiroz Salgado', '3067891256');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR038', 'lector.veintinueve@correo.co', 'Lector', 'Beatriz', 'Montoya Arenas', '3078902367');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR039', 'lector.treinta@correo.co', 'Lector', 'Alejandra', 'Soto Pulido', '3089013478');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR040', 'lector.treintauno@correo.co', 'Lector', 'Ernesto', 'Cano Valencia', '3090124589');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR041', 'admin.barranquilla@biblioteca.co', 'Administrador', 'Constanza', 'Mejia Contreras', '3101235690');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR042', 'biblio.referencia@biblioteca.co', 'Bibliotecario', 'Jaime', 'Velasquez Rubio', '3112346701');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR043', 'lector.treintados@correo.co', 'Lector', 'Milena', 'Giraldo Ospina', '3123457812');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR044', 'lector.treintatres@correo.co', 'Lector', 'Luis', 'Suarez Bedoya', '3134568923');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR045', 'lector.treintacuatro@correo.co', 'Lector', 'Yolanda', 'Prado Solano', '3145670034');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR046', 'lector.treintacinco@correo.co', 'Lector', 'Fernando', 'Marin Angulo', '3156781145');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR047', 'lector.treintaseis@correo.co', 'Lector', 'Blanca', 'Ossa Ocampo', '3167892256');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR048', 'lector.treintasiete@correo.co', 'Lector', 'Gustavo', 'Leal Pimiento', '3178903367');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR049', 'lector.treintaocho@correo.co', 'Lector', 'Pilar', 'Arenas Galindo', '3189014478');
INSERT INTO Usuario (id, correo, rol, nombre, apellidos, telefono) VALUES ('USR050', 'lector.treintanueve@correo.co', 'Lector', 'Sergio', 'Florez Cossio', '3190125589');

-- Administrador
INSERT INTO Administrador (idUsuario, permisos, sede) VALUES ('USR001', 'Total', 'Sede Bogota');
INSERT INTO Administrador (idUsuario, permisos, sede) VALUES ('USR002', 'Operativo', 'Sede Medellin');
INSERT INTO Administrador (idUsuario, permisos, sede) VALUES ('USR021', 'Operativo', 'Sede Cali');
INSERT INTO Administrador (idUsuario, permisos, sede) VALUES ('USR041', 'Solo Lectura', 'Sede Barranquilla');

-- Compra
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM001', TO_DATE('15/01/2023', 'DD/MM/YYYY'), 850000.00, 'COMPLETADO', 'PRV001');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM002', TO_DATE('22/02/2023', 'DD/MM/YYYY'), 620000.00, 'COMPLETADO', 'PRV002');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM003', TO_DATE('10/03/2023', 'DD/MM/YYYY'), 370000.00, 'PENDIENTE', 'PRV003');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM004', TO_DATE('05/04/2023', 'DD/MM/YYYY'), 490000.00, 'COMPLETADO', 'PRV004');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM005', TO_DATE('18/05/2023', 'DD/MM/YYYY'), 200000.00, 'RECHAZADO', 'PRV005');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM006', TO_DATE('30/06/2023', 'DD/MM/YYYY'), 715000.00, 'COMPLETADO', 'PRV006');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM007', TO_DATE('12/07/2023', 'DD/MM/YYYY'), 540000.00, 'COMPLETADO', 'PRV007');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM008', TO_DATE('25/08/2023', 'DD/MM/YYYY'), 320000.00, 'PENDIENTE', 'PRV008');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM009', TO_DATE('09/09/2023', 'DD/MM/YYYY'), 430000.00, 'COMPLETADO', 'PRV009');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM010', TO_DATE('20/10/2023', 'DD/MM/YYYY'), 155000.00, 'RECHAZADO', 'PRV010');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM011', TO_DATE('04/11/2023', 'DD/MM/YYYY'), 890000.00, 'COMPLETADO', 'PRV011');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM012', TO_DATE('17/12/2023', 'DD/MM/YYYY'), 670000.00, 'COMPLETADO', 'PRV012');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM013', TO_DATE('08/01/2024', 'DD/MM/YYYY'), 290000.00, 'PENDIENTE', 'PRV013');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM014', TO_DATE('21/02/2024', 'DD/MM/YYYY'), 460000.00, 'COMPLETADO', 'PRV014');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM015', TO_DATE('13/03/2024', 'DD/MM/YYYY'), 185000.00, 'RECHAZADO', 'PRV015');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM016', TO_DATE('26/04/2024', 'DD/MM/YYYY'), 730000.00, 'COMPLETADO', 'PRV016');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM017', TO_DATE('09/05/2024', 'DD/MM/YYYY'), 580000.00, 'COMPLETADO', 'PRV017');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM018', TO_DATE('23/06/2024', 'DD/MM/YYYY'), 345000.00, 'PENDIENTE', 'PRV018');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM019', TO_DATE('07/07/2024', 'DD/MM/YYYY'), 410000.00, 'COMPLETADO', 'PRV019');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM020', TO_DATE('19/08/2024', 'DD/MM/YYYY'), 250000.00, 'RECHAZADO', 'PRV020');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM021', TO_DATE('02/09/2024', 'DD/MM/YYYY'), 920000.00, 'COMPLETADO', 'PRV021');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM022', TO_DATE('15/10/2024', 'DD/MM/YYYY'), 640000.00, 'COMPLETADO', 'PRV022');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM023', TO_DATE('28/11/2024', 'DD/MM/YYYY'), 380000.00, 'PENDIENTE', 'PRV023');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM024', TO_DATE('12/12/2024', 'DD/MM/YYYY'), 510000.00, 'COMPLETADO', 'PRV024');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM025', TO_DATE('05/01/2025', 'DD/MM/YYYY'), 175000.00, 'RECHAZADO', 'PRV025');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM026', TO_DATE('18/02/2025', 'DD/MM/YYYY'), 760000.00, 'COMPLETADO', 'PRV026');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM027', TO_DATE('03/03/2025', 'DD/MM/YYYY'), 595000.00, 'COMPLETADO', 'PRV027');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM028', TO_DATE('16/04/2025', 'DD/MM/YYYY'), 330000.00, 'PENDIENTE', 'PRV028');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM029', TO_DATE('29/05/2025', 'DD/MM/YYYY'), 475000.00, 'COMPLETADO', 'PRV029');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM030', TO_DATE('11/06/2025', 'DD/MM/YYYY'), 215000.00, 'RECHAZADO', 'PRV030');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM031', TO_DATE('24/07/2025', 'DD/MM/YYYY'), 840000.00, 'COMPLETADO', 'PRV031');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM032', TO_DATE('06/08/2025', 'DD/MM/YYYY'), 660000.00, 'COMPLETADO', 'PRV032');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM033', TO_DATE('19/09/2025', 'DD/MM/YYYY'), 395000.00, 'PENDIENTE', 'PRV033');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM034', TO_DATE('01/10/2025', 'DD/MM/YYYY'), 520000.00, 'COMPLETADO', 'PRV034');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM035', TO_DATE('14/11/2025', 'DD/MM/YYYY'), 165000.00, 'RECHAZADO', 'PRV035');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM036', TO_DATE('27/12/2025', 'DD/MM/YYYY'), 785000.00, 'COMPLETADO', 'PRV036');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM037', TO_DATE('10/01/2024', 'DD/MM/YYYY'), 610000.00, 'COMPLETADO', 'PRV037');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM038', TO_DATE('23/02/2024', 'DD/MM/YYYY'), 360000.00, 'PENDIENTE', 'PRV038');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM039', TO_DATE('07/03/2024', 'DD/MM/YYYY'), 495000.00, 'COMPLETADO', 'PRV039');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM040', TO_DATE('20/04/2024', 'DD/MM/YYYY'), 225000.00, 'RECHAZADO', 'PRV040');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM041', TO_DATE('03/05/2024', 'DD/MM/YYYY'), 870000.00, 'COMPLETADO', 'PRV041');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM042', TO_DATE('16/06/2024', 'DD/MM/YYYY'), 685000.00, 'COMPLETADO', 'PRV042');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM043', TO_DATE('29/07/2024', 'DD/MM/YYYY'), 415000.00, 'PENDIENTE', 'PRV043');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM044', TO_DATE('11/08/2024', 'DD/MM/YYYY'), 535000.00, 'COMPLETADO', 'PRV044');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM045', TO_DATE('24/09/2024', 'DD/MM/YYYY'), 190000.00, 'RECHAZADO', 'PRV045');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM046', TO_DATE('07/10/2024', 'DD/MM/YYYY'), 810000.00, 'COMPLETADO', 'PRV046');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM047', TO_DATE('20/11/2024', 'DD/MM/YYYY'), 630000.00, 'COMPLETADO', 'PRV047');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM048', TO_DATE('03/12/2024', 'DD/MM/YYYY'), 420000.00, 'PENDIENTE', 'PRV048');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM049', TO_DATE('16/01/2025', 'DD/MM/YYYY'), 555000.00, 'COMPLETADO', 'PRV049');
INSERT INTO Compra (id, fecha, total, estado, idProveedor) VALUES ('COM050', TO_DATE('28/02/2025', 'DD/MM/YYYY'), 270000.00, 'RECHAZADO', 'PRV050');

-- Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro)
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC001', 5, 42000.00, 'COM001', 'LIB001');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC002', 3, 38000.00, 'COM001', 'LIB002');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC003', 4, 45000.00, 'COM002', 'LIB003');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC004', 2, 52000.00, 'COM002', 'LIB004');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC005', 6, 37000.00, 'COM003', 'LIB005');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC006', 3, 29000.00, 'COM003', 'LIB006');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC007', 4, 44000.00, 'COM004', 'LIB007');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC008', 2, 35000.00, 'COM004', 'LIB008');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC009', 5, 41000.00, 'COM005', 'LIB009');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC010', 3, 33000.00, 'COM006', 'LIB010');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC011', 7, 48000.00, 'COM006', 'LIB011');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC012', 4, 36000.00, 'COM007', 'LIB012');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC013', 2, 55000.00, 'COM007', 'LIB013');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC014', 5, 30000.00, 'COM008', 'LIB014');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC015', 3, 46000.00, 'COM009', 'LIB015');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC016', 4, 50000.00, 'COM009', 'LIB016');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC017', 6, 39000.00, 'COM010', 'LIB017');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC018', 2, 43000.00, 'COM011', 'LIB018');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC019', 5, 57000.00, 'COM011', 'LIB019');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC020', 3, 32000.00, 'COM012', 'LIB020');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC021', 4, 47000.00, 'COM012', 'LIB021');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC022', 6, 34000.00, 'COM013', 'LIB022');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC023', 2, 53000.00, 'COM014', 'LIB023');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC024', 5, 40000.00, 'COM014', 'LIB024');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC025', 3, 28000.00, 'COM015', 'LIB025');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC026', 7, 44000.00, 'COM016', 'LIB026');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC027', 4, 38000.00, 'COM016', 'LIB027');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC028', 2, 51000.00, 'COM017', 'LIB028');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC029', 5, 36000.00, 'COM017', 'LIB029');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC030', 3, 49000.00, 'COM018', 'LIB030');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC031', 4, 42000.00, 'COM019', 'LIB031');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC032', 6, 31000.00, 'COM019', 'LIB032');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC033', 2, 54000.00, 'COM020', 'LIB033');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC034', 5, 37000.00, 'COM021', 'LIB034');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC035', 3, 48000.00, 'COM021', 'LIB035');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC036', 4, 43000.00, 'COM022', 'LIB036');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC037', 7, 29000.00, 'COM022', 'LIB037');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC038', 2, 56000.00, 'COM023', 'LIB038');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC039', 5, 33000.00, 'COM024', 'LIB039');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC040', 3, 46000.00, 'COM024', 'LIB040');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC041', 4, 39000.00, 'COM025', 'LIB041');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC042', 6, 52000.00, 'COM026', 'LIB042');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC043', 2, 35000.00, 'COM026', 'LIB043');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC044', 5, 41000.00, 'COM027', 'LIB044');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC045', 3, 44000.00, 'COM027', 'LIB045');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC046', 4, 50000.00, 'COM028', 'LIB046');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC047', 7, 28000.00, 'COM029', 'LIB047');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC048', 2, 47000.00, 'COM029', 'LIB048');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC049', 5, 38000.00, 'COM030', 'LIB049');
INSERT INTO Producto_Compra (id, cantidad, precioUnidad, idCompra, idLibro) VALUES ('PC050', 3, 45000.00, 'COM031', 'LIB050');

---------------------------------------------------------------------------------------------
--- PRUEBAS: PoblarNoOK -> Intento de ingreso de datos erroneos protegidos
---------------------------------------------------------------------------------------------

-- ===== VIOLACIONES DE CLAVE PRIMARIA (PK duplicada) =====

-- PK duplicada en Categoria
INSERT INTO Categoria VALUES ('CAT001', 'Duplicado', 'Viola PRIMARY KEY de Categoria');

-- PK duplicada en Autor
INSERT INTO Autor VALUES ('AUT001', 'Clon', 'Apellido', 'Masculino', 'Colombiana');

-- PK duplicada en Libro
INSERT INTO Libro VALUES ('LIB001', 'Titulo clon', TO_DATE('2000-01-01','YYYY-MM-DD'), 'Espanol', 'Viola PRIMARY KEY de Libro', 'CAT001');

-- PK duplicada en Editorial
INSERT INTO Editorial VALUES ('ED001', 'nuevo@correo.com', '3000000001', 'Editorial Clon', 'Mexico');

-- ===== VIOLACIONES DE CLAVE FORANEA (FK a registro inexistente) =====

-- Libro con idCategoria que no existe
INSERT INTO Libro VALUES ('LIB099', 'Libro Huerfano', TO_DATE('2020-01-01','YYYY-MM-DD'), 'Espanol', 'Sin categoria valida', 'CAT999');

-- Edicion con idLibro que no existe
INSERT INTO Edicion VALUES ('EDI099', TO_DATE('2024-01-01','YYYY-MM-DD'), 100, 'LIB999', 'ED001');

-- Edicion con idEditorial que no existe
INSERT INTO Edicion VALUES ('EDI098', TO_DATE('2024-01-01','YYYY-MM-DD'), 200, 'LIB001', 'ED999');

-- Ejemplar con idEdicion que no existe
INSERT INTO Ejemplar VALUES ('EJE099', 'Nuevo', 1, 'Estante Z nueve', TO_DATE('2024-01-01','YYYY-MM-DD'), 'EDI999');

-- Compra con idProveedor que no existe
INSERT INTO Compra VALUES ('CMP099', TO_DATE('2024-06-01','YYYY-MM-DD'), 99999.00, 'COMPLETADO', 'PRV999');

-- Producto_Compra con idCompra que no existe
INSERT INTO Producto_Compra VALUES ('PC099', 1, 50000.00, 'CMP999', 'LIB001');

-- Producto_Compra con idLibro que no existe
INSERT INTO Producto_Compra VALUES ('PC098', 1, 50000.00, 'CMP001', 'LIB999');

-- Administrador con idUsuario que no existe
INSERT INTO Administrador VALUES ('USR999', 'Total', 'Sede Norte');

-- ===== VIOLACIONES DE CLAVE UNICA (UNIQUE) =====

-- Correo duplicado en Usuario
INSERT INTO Usuario VALUES ('USR099', 'admin@biblioteca.com', 'Lector', 'Intruso', 'Apellido', '3000000000');

-- Correo duplicado en Editorial
INSERT INTO Editorial VALUES ('ED099', 'contacto@planeta.com', '3000000002', 'Editorial Pirata', 'Peru');

-- Telefono duplicado en Editorial
INSERT INTO Editorial VALUES ('ED098', 'diferente@correo.com', '3001234567', 'Editorial Copia', 'Chile');

-- Correo duplicado en Proveedor
INSERT INTO Proveedor VALUES ('PRV099', 'ventas@distribuidora.com', 'Pirata', 'Nombre Falso', 'Empresa Clon', '3199999999');

-- ===== VIOLACIONES DE CHECK (tipos y formatos) =====

-- Rol invalido en Usuario  (valores validos: 'Administrador', 'Lector', 'Bibliotecario')
INSERT INTO Usuario VALUES ('USR098', 'valido@correo.com', 'X', 'Nombre', 'Apellido', '3001112222');

-- Genero invalido en Autor  (valores validos: 'Masculino', 'Femenino', 'Otro')
INSERT INTO Autor VALUES ('AUT099', 'Nombre', 'Apellido', 'Transgenero', 'Colombiana');

-- Paginas negativas en Edicion
INSERT INTO Edicion VALUES ('EDI097', TO_DATE('2020-01-01','YYYY-MM-DD'), -10, 'LIB001', 'ED001');

-- Precio negativo en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC097', 3, -5000.00, 'CMP001', 'LIB001');

-- Cantidad cero en Producto_Compra
INSERT INTO Producto_Compra VALUES ('PC096', 0, 50000.00, 'CMP001', 'LIB001');

-- Total negativo en Compra
INSERT INTO Compra VALUES ('CMP098', TO_DATE('2024-01-01','YYYY-MM-DD'), -100.00, 'PENDIENTE', 'PRV001');

-- Estado invalido en Compra  (valores validos: 'PENDIENTE', 'COMPLETADO', 'RECHAZADO')
INSERT INTO Compra VALUES ('CMP097', TO_DATE('2024-01-01','YYYY-MM-DD'), 50000.00, 'CO', 'PRV001');

-- Correo con formato invalido en Editorial
INSERT INTO Editorial VALUES ('ED097', 'correo_sin_arroba', '3001234999', 'Editorial Mala', 'Bolivia');

-- Telefono con letras en Usuario
INSERT INTO Usuario VALUES ('USR097', 'nuevo@correo.com', 'Administrador', 'Nombre', 'Apellido', 'ABCD123456');

-- Estado fisico invalido en Ejemplar
-- (valores validos: 'Desgastado', 'Bueno', 'Dañado', 'Restaurado', 'Perdido', 'Nuevo')
INSERT INTO Ejemplar VALUES ('EJE098', 'XX', 1, 'Estante Q', TO_DATE('2023-01-01','YYYY-MM-DD'), 'EDI001');

-- Fecha de publicacion futura en Libro
INSERT INTO Libro VALUES ('LIB098', 'Libro Futuro', TO_DATE('2099-01-01','YYYY-MM-DD'), 'Espanol', 'Fecha invalida futura', 'CAT001');

-- Permisos invalidos en Administrador  (valores validos: 'Solo Lectura', 'Operativo', 'Total')
INSERT INTO Administrador VALUES ('USR002', 'X', 'Sede Sur');