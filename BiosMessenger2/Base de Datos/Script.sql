use master
go

if exists(Select * FROM SysDataBases WHERE name='BiosMessenger2')
BEGIN
	DROP DATABASE BiosMessenger2
END
go

create database BiosMessenger2
go

use BiosMessenger2
go

create table Usuario
(
	UsuarioLogueo char(8) primary key check(len(UsuarioLogueo) = 8),
	Contrasena char(6) not null check(Contrasena like '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9]'),
	Nombre varchar(50) not null,
	Apellido varchar(50) not null,
	Mail varchar(50) not null check(Mail like '%@%.%' or Mail like '%@%.%.%')	
)
go

create table TipodeMensaje
(
	Codigo char(3) primary key check(Codigo like '[A-Z][A-Z][A-Z]'),
	Nombre varchar(20) not null
)
go

create table Mensaje
(
	Codigo int identity (1,1) primary key,
	TextoMensaje varchar(max) not null,
	Asunto varchar(30) not null,
	FechaHora datetime not null default getdate(),
	UsuarioLogueo char(8) not null foreign key references Usuario(UsuarioLogueo),
	FechaCaducidad datetime not null check(datediff(hour, getdate(), FechaCaducidad) >= 24),
	TipoMensaje char(3) not null foreign key references TipodeMensaje(Codigo)
)
go

create table Reciben
(
	UsuarioLogueo char(8) not null foreign key references Usuario(UsuarioLogueo),
	Codigo int not null foreign key references Mensaje(Codigo),
		primary key (UsuarioLogueo, Codigo)
)
go


insert into Usuario (UsuarioLogueo, Contrasena, Nombre, Apellido, Mail)
values ('UsuarioA', 'AAAAA1', 'Alberto','Gonzalez','albertico@gmail.com.uy'),
       ('UsuarioB', 'BBBBB2', 'Camila', 'Medina', 'cmedina@hotmail.com'),
	   ('UsuarioC', 'CCCCC3', 'Juan', 'Perez', 'juanp@yahoo.com'),
	   ('UsuarioD', 'DDDDD4', 'Leandro', 'Andrade', 'leandrade@gmail.com'),
	   ('UsuarioE', 'EEEEE5', 'Marcelo', 'Velazquez', 'mavelazquez@hotmail.com'),
	   ('UsuarioF', 'FFFFF6', 'Jose', 'Coimbra', 'josecoi@yahoo.com'),
	   ('UsuarioG', 'GGGGG7', 'Manuel', 'Mora', 'manum@gmail.com'),
	   ('UsuarioH', 'HHHHH8', 'Francisco', 'Morales', 'franmora@yahoo.com'),
	   ('UsuarioI', 'IIIII9', 'David', 'Moreno', 'dmoreno@yahoo.com'),
	   ('UsuarioJ', 'JJJJJ0', 'Daniel', 'Pereira', 'danipe@hotmail.com'),
	   ('UsuarioK', 'KKKKK1', 'Javier', 'Pineda', 'jpineda@yahoo.com'),
	   ('UsuarioL', 'LLLLL2', 'Antonio', 'Portillo', 'tonip@gmail.com'),
	   ('UsuarioM', 'MMMMM3', 'Isabel', 'Quispe', 'isaq@hotmail.com'),
	   ('UsuarioN', 'NNNNN4', 'Josefa', 'Reyes', 'joreyes@yahoo.com'),
	   ('UsuarioO', 'OOOOO5', 'Ana', 'Rivas', 'anarivas@gmail.com'),
	   ('UsuarioP', 'PPPPP6', 'Carmen', 'Rivera', 'carmenriv@yahoo.com'),
	   ('UsuarioQ', 'QQQQQ7', 'Maria', 'Rojas', 'mariarojas@hotmail.com'),
	   ('UsuarioR', 'RRRRR8', 'Paula', 'Salazar', 'pausalazar@yahoo.com'),
	   ('UsuarioS', 'SSSSS9', 'Valeria', 'Santana', 'valesantana@gmail.com'),
	   ('UsuarioT', 'TTTTT0', 'Julia', 'Santos', 'jullisantos@yahoo.com')
go

------------------ TIPOS DE MENSAJE -------------------
insert into TipodeMensaje (Codigo, Nombre)
values ('URG', 'Urgente'), ('AGE', 'Agenda'), ('IMP', 'Importante'), ('REC', 'Recordatorio'),
('IVT', 'Invitación'), ('EVT', 'Eventos'), ('LAB', 'Laboral'), ('CON', 'Consulta'), 
('PUB', 'Publicitario'), ('INF', 'Informativo')
go


------------- MENSAJES -------------
DECLARE @idMensaje INT
-- 1 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Primer Texto de Mensaje', 'Asunto de Mensaje 1', 'UsuarioA', '20221212 21:00', 'URG')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 2 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Segundo Texto de Mensaje', 'Asunto de Mensaje 2', 'UsuarioA', '20221218 21:00', 'URG')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)

-- 3 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Tercer Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioA', '20221218 21:00', 'URG')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)

-- 4 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB', '20221218 21:00', 'CON')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
 
-- 5 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB', '20221220 21:00', 'CON')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 6 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB', '20221220 21:00', 'CON')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 7 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Séptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB', '20221222 21:00', 'CON')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)

-- 8 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Octavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioB', '20221222 18:00', 'LAB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 9 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC', '20221219 18:00', 'LAB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 10 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC', '20221219 18:00', 'LAB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)

-- 11 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Primero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC', '20221219 18:00', 'LAB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 12 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Segundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioC', '20221223 18:00', 'LAB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 13 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Tercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD', '20221217 19:00', 'AGE')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 14 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD', '20221219 18:00', 'AGE')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 15 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD', '20221219 18:00', 'AGE')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 16 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD', '20221209 19:00', 'AGE')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 17 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Séptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioD', '20221219 18:00', 'AGE')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 18 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Octavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221219 18:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 19 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Décimo Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221219 18:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 20 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221218 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 21 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Primero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221218 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)

-- 22 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Segundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221218 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 23 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Tercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221218 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 24 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221217 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioC', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 25 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioE', '20221217 20:00', 'PUB')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 26 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221221 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 27 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Séptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221221 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 28 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Octavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221221 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioN', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 29 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Vigésimo Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221221 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 30 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221222 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)

-- 31 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Primero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221222 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 32 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Segundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221222 21:00', 'IMP')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 33 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Tercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221222 21:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)

-- 34 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221222 21:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioA', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 35 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221222 21:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)

-- 36 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221219 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 37 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Séptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221219 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 38 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Octavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221219 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 39 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Trigésimo Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221219 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)

-- 40 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221216 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 41 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Primero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221216 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)

-- 42 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Segundo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioF', '20221216 22:00', 'EVT')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioB', @idMensaje)

-- 43 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Tercero Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221216 22:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioF', @idMensaje)

-- 44 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Cuarto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221216 22:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)

-- 45 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Quinto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221216 22:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioK', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 46 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Sexto Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221217 17:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioM', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 47 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Séptimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioG', '20221217 17:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioE', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioO', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioP', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioL', @idMensaje)

-- 48 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Octavo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioH', '20221217 17:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioG', @idMensaje)

-- 49 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Cuadragésimo Noveno Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioH', '20221217 17:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)

-- 50 --
insert into Mensaje (TextoMensaje, Asunto, UsuarioLogueo, FechaCaducidad, TipoMensaje)
values ('Quincuagésimo Texto de Mensaje', 'Asunto de Mensaje', 'UsuarioH', '20221217 17:00', 'REC')
SELECT @idMensaje = @@IDENTITY
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioI', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioJ', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioD', @idMensaje)
insert into Reciben(UsuarioLogueo, Codigo)
values ('UsuarioH', @idMensaje)
go

------------- ELIMINAR USUARIO -------------
Create Procedure BajaUsuario @logueo char(8), @ret int output AS
Begin
	if not exists(select * from Usuario where UsuarioLogueo = @logueo)
	begin
		set @ret = -1
		return
	end

	If exists(select * from Mensaje where Mensaje.UsuarioLogueo = @logueo or
	   exists(select * from Reciben where Reciben.UsuarioLogueo = @logueo))
	begin
		set @ret = -2
		return
	end

	begin
		Delete From Usuario where UsuarioLogueo = @logueo
		set @ret = 1
		return
	end
end
go

---------------- Creacion de usuario IIS para que el webservice pueda acceder a la bd ----------------
USE master
GO

CREATE LOGIN [IIS APPPOOL\DefaultAppPool] FROM WINDOWS 
GO

USE BiosMessenger2
GO

CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool]
GO

exec sys.sp_addrolemember 'db_owner', [IIS APPPOOL\DefaultAppPool]
go