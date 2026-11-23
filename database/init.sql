CREATE DATABASE IF NOT EXISTS vecinoactivo CHARACTER SET utf8mb4;
USE vecinoactivo;

CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  usuario VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  telefono VARCHAR(20),
  genero ENUM('M','F','O'),
  password_hash VARCHAR(255) NOT NULL,
  rol ENUM('usuario','admin') DEFAULT 'usuario',
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE quejas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  tipo_problema ENUM('Educación','Infraestructura','Medio Ambiente','Seguridad','Servicios Públicos') NOT NULL,
  nivel_urgencia ENUM('BAJO','MEDIO','ALTO') NOT NULL,
  descripcion TEXT NOT NULL,
  latitud DECIMAL(10,7),
  longitud DECIMAL(10,7),
  estado ENUM('pendiente','en_proceso','resuelto') DEFAULT 'pendiente',
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

INSERT INTO usuarios (nombres, apellidos, usuario, email, password_hash, rol)
VALUES ('Admin','VecinoActivo','admin','admin@vecinoactivo.com','$2y$10$...hash...','admin');